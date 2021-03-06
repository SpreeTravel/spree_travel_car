module Spree
  module Core
    module Search
      class SpreeTravelCarBase
        attr_accessor :properties
        attr_accessor :current_user
        attr_accessor :current_currency

        def initialize(params)
          self.current_currency = Spree::Config[:currency]
          @properties = {}
          prepare(params)
        end

        def retrieve_products
          @products = get_base_scope
          curr_page = page || 1

          unless Spree::Config.show_products_without_price
            @products = @products.where("spree_prices.amount IS NOT NULL").where("spree_prices.currency" => current_currency)
          end
          @products = @products.page(curr_page).per(per_page)
        end

        def method_missing(name)
          if @properties.has_key? name
            @properties[name]
          else
            super
          end
        end

        protected

        def get_base_scope
          base_scope = get_products_by_product_type
          # base_scope = get_variants_with_option_types(base_scope)
          base_scope = check_car_availability(base_scope)
          base_scope = get_products_conditions_for(base_scope, keywords)
          base_scope = add_search_scopes(base_scope)
          base_scope = add_eagerload_scopes(base_scope)
          base_scope
        end

        def get_products_by_product_type
          Spree::Product.joins(variants: :rates)
                        .where(product_type_id: Spree::ProductType.find_by(name: 'car').id)
                        .active
                        .distinct
                        # .group(:products).having('COUNT(spree_rates.variant_id) > 0')
                        # .pluck(:id)
        end

        def get_variants_with_option_types(base_scope)
          common_option_types = (properties[:product_type].variant_option_types & properties[:product_type].context_option_types).pluck(:name)
          option_types_ids = common_option_types.map {|option_type| params['context']["#{properties[:product_type].name}_#{option_type}"]}
          # TODO make some test to check what happends when no context_option_type is passed, for example a case with `All` i the search box
          base_scope.joins(variants: :option_values).where(spree_option_values: {id: option_types_ids}).distinct
        end

        def check_car_availability(base_scope)
          base_scope.joins(variants: :stock_items).where('count_on_hand > ? OR spree_variants.track_inventory = ?', 0, false)
        end

        def add_eagerload_scopes(scope)
          # TL;DR Switch from `preload` to `includes` as soon as Rails starts honoring
          # `order` clauses on `has_many` associations when a `where` constraint
          # affecting a joined table is present (see
          # https://github.com/rails/rails/issues/6769).
          #
          # Ideally this would use `includes` instead of `preload` calls, leaving it
          # up to Rails whether associated objects should be fetched in one big join
          # or multiple independent queries. However as of Rails 4.1.8 any `order`
          # defined on `has_many` associations are ignored when Rails builds a join
          # query.
          #
          # Would we use `includes` in this particular case, Rails would do
          # separate queries most of the time but opt for a join as soon as any
          # `where` constraints affecting joined tables are added to the search;
          # which is the case as soon as a taxon is added to the base scope.
          scope = scope.preload(:tax_category)
          scope = scope.preload(master: :prices)
          scope = scope.preload(master: :images) if include_images
          scope
        end

        def add_search_scopes(base_scope)
          if search.is_a?(ActionController::Parameters)
            search.each do |name, scope_attribute|
              scope_name = name.to_sym
              base_scope = if base_scope.respond_to?(:search_scopes) && base_scope.search_scopes.include?(scope_name.to_sym)
                             base_scope.send(scope_name, *scope_attribute)
                           else
                             base_scope.merge(Spree::Product.ransack(scope_name => scope_attribute).result)
                           end
            end
          end
          base_scope
        end

        # method should return new scope based on base_scope
        def get_products_conditions_for(base_scope, query)
          unless query.blank?
            base_scope = base_scope.like_any([:name, :description], query.split)
          end
          base_scope
        end

        def prepare(params)
          @properties[:params] = params
          @properties[:keywords] = params[:keywords]
          @properties[:search] = params[:search]
          @properties[:include_images] = params[:include_images]

          @properties[:product_type] = Spree::ProductType.find_by_name(params[:product_type])
          @properties[:context] = params['context'].transform_keys {|k| k.slice(4..-1) }
          @properties[:options] = []

          per_page = params[:per_page].to_i
          @properties[:per_page] = per_page > 0 ? per_page : Spree::Config[:products_per_page]
          if params[:page].respond_to?(:to_i)
            @properties[:page] = (params[:page].to_i <= 0) ? 1 : params[:page].to_i
          else
            @properties[:page] = 1
          end
        end
      end
    end
  end
end
