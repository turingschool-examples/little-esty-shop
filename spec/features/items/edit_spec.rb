require 'rails_helper'

RSpec.describe 'the item edit page' do
  before do
    @merchant1 = Merchant.create!(name: "Hondo MacGuillicutty", created_at: Time.now, updated_at: Time.now)
    @item1 = Item.create!(name: "Left-handed back scratcher", description: "Finally a solution for left-handed people with itchy backs", unit_price: 25, created_at: Time.now, updated_at: Time.now, merchant_id: @merchant1.id)

    visit edit_merchant_item_path(@merchant1, @item1)
  end

  it 'shows the form with current item info' do
    expect(page).to have_field('Name', with: @item1.name)
    expect(page).to have_field('Description', with: @item1.description)
    expect(page).to have_field('Unit Price', with: @item1.unit_price)
  end
end
