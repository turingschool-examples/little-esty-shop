require 'rails_helper'

RSpec.describe "Merchant Dashboard" do
  before(:each) do
    @merchant = Merchant.create!(name: 'Ice Cream Parlour')
    visit "/merchant/#{@merchant.id}/dashboard"
  end

  it "can see merchant name" do
    expect(page).to have_content(@merchant.name)
  end

  it "see links to merchant items index and merchant invoices index" do
    save_and_open_page
    expect(page).to have_link('My Items')
    expect(page).to have_link('My Invoices')
  end
end
