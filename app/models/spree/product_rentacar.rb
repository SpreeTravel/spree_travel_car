module Spree
  class ProductRentacar < Spree::Product

    def rentacar?
      self.is?(Spree::ProductRentacar)
    end

    def children_relation_name
      Spree::RELATION_IS_CAR_OF_RENTACAR
    end

    def main_child_relation_name
      Spree::RELATION_IS_MAIN_CAR_OF_RENTACAR
    end
  end
end
