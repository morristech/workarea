require 'test_helper'
require 'workarea/lint'

module Workarea
  class Lint
    load_lints

    class SkusMissingPricingTest < TestCase
      def test_errors_for_each_variant_sku_missing_pricing
        Catalog::Product.create!(name: 'Foo', variants: [{ sku: '123' }])
        Catalog::Product.create!(name: 'Bar', variants: [{ sku: '456' }])

        lint = SkusMissingPricing.new
        lint.run

        assert_equal(2, lint.errors)
      end

      def test_errors_for_each_inventory_sku_missing_pricing
        Inventory::Sku.create!(id: '123')
        Inventory::Sku.create!(id: '456')

        lint = SkusMissingPricing.new
        lint.run

        assert_equal(2, lint.errors)
      end
    end
  end
end
