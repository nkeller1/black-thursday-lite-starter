require_relative 'item'
require_relative 'csv_loadable'

class Item
  extend CsvLoadable

  @@all = []

  def self.all
    @@all
  end

  def self.from_csv(file_path)
    @@all = create_instances(file_path, "Item")
  end

  def self.find(id)
    @@all.find do |item|
      item.id == id
    end
  end

  def self.where(merchant_id)
    @@all.find_all do |item|
      item.merchant_id == merchant_id
    end
  end

  attr_reader :id, :name, :description, :unit_price, :merchant_id

  def initialize(item_info)
    @description = item_info[:description]
    @id = item_info[:id].to_i
    @name = item_info[:name]
    @unit_price = item_info[:unit_price].to_i
    @merchant_id = item_info[:merchant_id].to_i
  end
end
