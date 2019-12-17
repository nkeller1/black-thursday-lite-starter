require_relative 'merchant'
require_relative 'csv_loadable'

class MerchantCollection
  include CsvLoadable

  attr_reader :merchants

  def initialize(csv_file_path)
    @merchants = create_instances(csv_file_path, "Merchant")
  end

  #
  # def create_merchants(csv_file_path)
  #   create_instances(csv_file_path, self.class.name)
  # end

  def all
    @merchants
  end

  def find(id)
    all.find do |merchant|
      merchant.id == id
    end
  end

  def create(merchant_name_info)
    new_id = all.last.id + 1
    merchant_info = merchant_name_info.merge({id: new_id})
    all << Merchant.new(merchant_info)
  end

  def destroy(merchant_id)
    merchant_to_delete = all.find {|merchant| merchant.id == merchant_id}

    all.delete(merchant_to_delete)
  end

  def update(merchant_info)
    merchant_to_update = all.find {|merchant| merchant.id == merchant_info[:id]}
    merchant_to_update.name = merchant_info[:name]
  end
end
