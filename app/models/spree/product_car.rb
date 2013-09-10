module Spree
  class ProductCar < Spree::Product

    def car?
      self.is?(Spree::ProductCar)
    end

    def parent_relation_name
      Spree::RELATION_IS_CAR_OF_RENTACAR
    end

    def variant_for_these_params(params)
      context = CarContext.new(params)
      check_in = context.check_in_car
      check_out = context.check_out_car
      transmission_id = context.transmission_id
      duration = (check_out - check_in).to_i

      check_in_str = check_in.strftime(Spree::FORMAT_DATE)
      check_out_str = check_out.strftime(Spree::FORMAT_DATE)

      sql  = "SELECT sv.id AS id "
      sql += ", sv.sku AS sku "
      sql += ", sv.price AS price"
      sql += ", sov1.name AS duration "
      sql += ", sov2.name AS season "
      sql += ", sov3.name AS transmission " if transmission_id.present?
      sql += "FROM spree_variants AS sv "
      sql += "INNER JOIN spree_option_values_variants AS sovv1 ON sovv1.variant_id = sv.id "
      sql += "INNER JOIN spree_option_values AS sov1 ON sov1.id = sovv1.option_value_id "
      sql += "INNER JOIN spree_option_values_variants AS sovv2 ON sovv2.variant_id = sv.id "
      sql += "INNER JOIN spree_option_values AS sov2 ON sov2.id = sovv2.option_value_id "
      sql += "INNER JOIN spree_option_values_variants AS sovv3 ON sovv3.variant_id = sv.id " if transmission_id.present?
      sql += "INNER JOIN spree_option_values AS sov3 ON sov3.id = sovv3.option_value_id " if transmission_id.present?
      sql += "WHERE sv.product_id = #{self.id} "
      sql += "AND substring_index(substring_index(sov1.name, '..', 1), '-', -1) <= #{duration} "
      sql += "AND substring_index(sov1.name, '..', -1) >= #{duration} "
      sql += "AND date(substring_index(substring_index(sov2.name, '-', 2), '-', -1)) <= date('#{check_in_str}') "
      sql += "AND date(substring_index(sov2.name, '-', -1)) >= date('#{check_out_str}') "
      sql += "AND sov3.id = #{transmission_id} " if transmission_id.present?

      records = Spree::Variant.find_by_sql(sql)
      # TODO: revisar que en gradnslam en los cars hay adultos y no deberia ser
      # TODO: revisar por que aqui habia un ciclo en grandslam, lo quite
      records.first

    end

    def price_for_these_params(params)
      variant = variant_for_these_params(params)
      context = CarContext.new(params)
      duration = context.duration
      if variant then variant.price * duration else super end
    end

  end
end

