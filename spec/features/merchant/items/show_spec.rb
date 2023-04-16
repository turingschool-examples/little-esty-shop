require 'rails_helper'

RSpec.describe 'Merchant Item Show Page', type: :feature do
  before(:each) do
    @merchant_1 = create(:merchant)
    @item_1 = create(:item, merchant: @merchant_1)

    visit merchant_item_path(@merchant_1.id, @item_1)
  end

  it 'has a header with a link back to the merchant dashboard' do
    expect(page).to have_content("#{@merchant_1.name} Item Details")
    expect(page).to have_link(@merchant_1.name)
  end

  it 'it has a link to the merchant item index' do
    expect(page).to have_link("#{@merchant_1.name} Item Index")
  end

  it 'displays all of the details of the item' do
    expect(page).to have_content(@item_1.name)
    expect(page).to have_content("ID: #{@item_1.id}")
    expect(page).to have_content("Description: #{@item_1.description}")
    expect(page).to have_content("Current Unit Price: #{@item_1.unit_price}")
    expect(page).to have_content("Created at: #{@item_1.created_at}")
    expect(page).to have_content("Updated at: #{@item_1.updated_at}")
  end
end
