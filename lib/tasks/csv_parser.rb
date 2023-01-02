class CSVParser
  def merchants
    lists_hash = List.pluck(:name, :id).to_h
    
    items = []
    CSV.foreach('link/to/file.csv', headers: true) do |row|
      list_id = lists_hash[row[:name]]
      items << { list_id: list_id, title: row[:title] }
    end
    Item.import(items)
  end
end