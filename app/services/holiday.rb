class Holiday
  # This is the Plain Old Ruby Object
  # it exists to convert JSON data into ruby objects
  attr_reader :date, :local_name, :name, :country_code

  def initialize(data)
    # Don't make a "mega PORO" that will sometimes have attributes that are nil
    # instead make multiple poro classes that will take care of those attributes
    @date = data[:date]
    @local_name = data[:localName]
    @name = data[:name]
    @country_code = data[:countryCode]
  end
end