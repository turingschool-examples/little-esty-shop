require 'rails_helper'

RSpec.describe "Application Helper" do
  include ApplicationHelper

  it 'concats customer names' do
    customer = create(:customer)

    expect(name(customer)).to eq("#{customer.first_name} #{customer.last_name}")
  end

  it "formats dates" do
    expected = format_date(Date.parse("2021-01-09"))
    actual = "Saturday, January 9, 2021"
    expect(actual).to eq(expected)
  end
end
