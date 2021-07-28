require 'rails_helper'

RSpec.describe 'Merchants Items Show page' do
  before(:each) do
    @merchant_1 = create(:merchant)
    @item = create(:item, merchant_id: @merchant_1.id)

    visit "/merchants/#{@merchant_1.id}/items/#{@item.id}"
  end

  it "lists all the items attriutes" do
    save_and_open_page
    expect(page).to have_content(@item.name)
    expect(page).to have_content(@item.description)
    expect(page).to have_content(@item.unit_price)
  end
end
