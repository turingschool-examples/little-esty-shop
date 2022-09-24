require 'rails_helper'

RSpec.describe 'admin merchant bulk discount index page' do
  before :each do
    @merchant1 = Merchant.create!(name: "Robespierre", status: 'Disabled')
  end

  it 'has a button on merchant dashboard to redirect you to bulk discounts index' do
    visit "merchant_index_path(#{@merchant1.id})"

    click_button "View all Discounts"

    expect(current_path).to eq("/merchants/#{@merchant1.id}/bulk_discounts/index")
  end

end
