require 'csv'
module ApplicationHelper 
 def import_data(path, type)
    CSV.foreach(path, :headers => true) do |row| 
      type.create!(row.to_hash)
    end
    ActiveRecord::Base.connection.execute("ALTER SEQUENCE invoice_items_id_seq RESTART WITH #{type.maximum(:id) + 1}")
  end
end