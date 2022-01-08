require 'rails_helper'

describe 'merchant item edit page' do
  before do
    @merchant1 = Merchant.create!(name: 'Hair Care')
    @item1 = Item.create!(name: "Shampoo", description: "This washes your hair", unit_price: 10, merchant_id: @merchant1.id)

    visit "/merchants/#{@merchant1.id}/items/#{@item1.id}/edit"
  end

  it 'has a form with current item information' do
    expect(page).to have_field('Name', with: @item1.name)
    expect(page).to have_field('Description', with: @item1.description)
    expect(page).to have_field('Unit Price', with: @item1.unit_price)
  end

  it 'updates item information after submitting form' do
    fill_in('Name', with: 'Sulfate free shampoo')
    fill_in('Description', with: 'Gentle hair cleanser')
    fill_in('Unit Price', with: 11)

    click_button('Submit')
    expect(current_path).to eq(merchant_item_path(@merchant1, @item1))

    expect(page).to have_content('Sulfate free shampoo')
    expect(page).to have_content('Gentle hair cleanser')
    expect(page).to have_content(11)
    expect(page).to have_content("Item sccessfully updated")
  end
end
