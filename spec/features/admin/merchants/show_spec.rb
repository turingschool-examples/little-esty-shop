require 'rails_helper'

RSpec.describe 'Admin Merchants Show Page' do
  before :each do
    @merchant1 = Merchant.create!(name: "Tyler", status: 1)
    @merchant2 = Merchant.create!(name: "Jill", status: 1)
    @merchant3 = Merchant.create!(name: "Bob", status: 1)

    visit admin_merchants_path(@merchant1)
  end

  it "I see the name of the merchant whos page I'm on" do
    expect(current_path).to eq(admin_merchants_path(@merchant1))
    expect(page).to have_content(@merchant1.name)
  end
end
