require 'rails_helper'

RSpec.describe 'The Merchant Item New page' do
  before :each do
    @merchant1 = Merchant.create!(name: 'Tom Holland')
    @merchant2 = Merchant.create!(name: 'Mary Jane')

    @item1 = Item.create!(name: 'spider suit', description: 'saves lives', unit_price: '10000', merchant_id: @merchant1.id)
    @item2 = Item.create!(name: 'web shooter', description: 'shoots webs', unit_price: '5000', merchant_id: @merchant1.id)
    @item3 = Item.create!(name: 'upside down kiss', description: 'That Mary jane Swag', unit_price: '15000', merchant_id: @merchant2.id)

    visit new_merchant_item_path(@merchant1.id)
  end

  it 'has a form with fields to create a new Merchant Item' do
    expect(page).to have_field(:name)
    expect(page).to have_field(:description)
    expect(page).to have_field(:unit_price)
  end

  it "can create a new Merchant Item with a default status of 'disable'" do
    fill_in(:name, with: 'Goober')
    fill_in(:description, with: 'USB thumb drive thingy')
    fill_in(:unit_price, with: 20_000)
    click_button 'Submit'

    expect(current_path).to eq(merchant_items_path(@merchant1.id))
    expect(page).to have_content('Goober')
    expect(page).to have_content('Goober successfully Created.')
    expect(Item.last.name).to eq('Goober')
    expect(Item.last.description).to eq('USB thumb drive thingy')
    expect(Item.last.unit_price).to eq(20_000)
    expect(Item.last.enable).to eq('disable')
  end

  it 'displays an alert when empty fields are submitted' do
    click_button 'Submit'
    expect(current_path).to eq(new_merchant_item_path(@merchant1.id))

    expect(page).to have_content("All fields are required.")
  end
end
