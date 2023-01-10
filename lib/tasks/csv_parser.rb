class CSVParser
  def self.merchants
    merchants = []
    CSV.foreach('./db/data/merchants.csv', headers: true) do |row|
      merchants << row.to_h
    end
    Merchant.import(merchants)
  end
end
