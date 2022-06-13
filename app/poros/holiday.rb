class Holiday
  attr_reader :name, :date

  def initialize(one_holiday)
    @name = one_holiday[:localName]
    @date = one_holiday[:date]
  end
end
