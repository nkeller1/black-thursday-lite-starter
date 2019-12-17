require 'minitest/autorun'
require 'minitest/pride'
require './lib/merchant_collection'

class MerchantCollectionTest < Minitest::Test
  def setup
    @merchant_collection = MerchantCollection.new("./test/fixtures/merchants_truncated.csv")
    @merchant = @merchant_collection.merchants.first
  end

  def test_it_exists
    assert_instance_of MerchantCollection, @merchant_collection
  end

  def test_it_has_attributes
    assert_instance_of Array, @merchant_collection.merchants
    assert_equal 4, @merchant_collection.merchants.length
  end

  def test_it_can_create_merchants_from_csv
    assert_instance_of Merchant, @merchant
    assert_equal 34, @merchant.id
    assert_equal "Candisart", @merchant.name
  end

  def test_it_can_find_all_merchants
    assert_equal @merchant_collection.merchants, @merchant_collection.all
  end

  def test_it_can_find_by_id
    assert_equal @merchant, @merchant_collection.find(34)
  end

  def test_it_can_create_new_merchant
    @merchant_collection.create({name: 'Monster Merchant'})
    added_merchant = @merchant_collection.merchants.last

    assert_equal 5, @merchant_collection.merchants.length
    assert_equal 'Monster Merchant', added_merchant.name
    assert_equal 12334186, added_merchant.id
  end

  def test_it_can_destroy_merchant_by_id
    merchant_to_destroy = @merchant_collection.merchants.last

    assert_equal 4, @merchant_collection.merchants.length
    assert @merchant_collection.merchants.include?(merchant_to_destroy)

    @merchant_collection.destroy(merchant_to_destroy.id)

    assert_equal 3, @merchant_collection.merchants.length
    refute @merchant_collection.merchants.include?(merchant_to_destroy)
  end

  def test_it_can_update_existing_merchant
    merchant_to_update = @merchant_collection.merchants.last

    assert "Candisart", merchant_to_update.name

    @merchant_collection.update({id: 34, name: "New Merchant Name"})

    assert "New Merchant Name", merchant_to_update.name
  end
end
