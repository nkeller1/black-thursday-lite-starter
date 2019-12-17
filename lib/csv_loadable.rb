require 'csv'

module CsvLoadable
  def create_instances(csv_file_path, class_name)
    csv = CSV.read("#{csv_file_path}", headers: true, header_converters: :symbol)

    csv.map do |row|
      Object.const_get(class_name).new(row)
    end
  end
end
