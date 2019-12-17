require 'minitest/autorun'
require 'minitest/pride'
require './lib/sales_engine'

class SalesEngineTest < Minitest::Test
  def setup
    @sales_engine = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
    })
  end

  def test_it_exists
    assert_instance_of SalesEngine, @sales_engine
  end

  def test_it_has_attributes
    assert_equal "./data/items.csv", @sales_engine.item_path
    assert_equal "./data/merchants.csv", @sales_engine.merchant_path
  end

  def test_it_can_create_an_item_collection
    assert_instance_of Array, @sales_engine.items
    assert_equal 1367, @sales_engine.items.length
    assert_instance_of Item, @sales_engine.items.first
  end

  def test_it_can_create_a_merchant_collection
    assert_instance_of MerchantCollection, @sales_engine.merchant_collection
  end
end
