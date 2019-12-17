require 'minitest/autorun'
require 'minitest/pride'
require './lib/item'

class ItemTest < Minitest::Test
  def setup
    @new_item = Item.new({
      :id          => 1,
      :name        => "Pencil",
      :description => "You can use it to write things",
      :unit_price  => 1099,
      :merchant_id => 2
    })

    Item.from_csv("./test/fixtures/items_truncated.csv")

    @item = Item.all[2]
  end

  def test_it_exists
    assert_instance_of Item, @item
  end

  def test_it_has_attributes
    assert_equal 1, @new_item.id
    assert_equal "Pencil", @new_item.name
    assert_equal "You can use it to write things", @new_item.description
    assert_equal 1099, @new_item.unit_price
    assert_equal 2, @new_item.merchant_id
  end

  def test_it_can_create_items_from_csv
    assert_instance_of Item, @item
    assert_equal 263396013, @item.id
    assert_equal "Free standing Woden letters", @item.name
    assert_equal "Free standing wooden letters\n\n15cm\n\nAny colours", @item.description
    assert_equal 700, @item.unit_price
    assert_equal 12334185, @item.merchant_id
  end

  def test_it_has_all
    assert_instance_of Array, Item.all
    assert_equal 4, Item.all.length
    assert_instance_of Item, Item.all.first
  end

  def test_it_can_find_by_id
    assert_equal @item, Item.find(263396013)
  end

  def test_it_can_find_all_items_where_merchant_id
    second_merchant_item = Item.all.first
    third_merchant_item = Item.all[1]
    assert_equal [second_merchant_item, third_merchant_item, @item], Item.where(12334185)
  end
end
