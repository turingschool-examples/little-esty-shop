require 'rails_helper'

RSpec.describe 'Merchant Items Show Page' do
  before(:each) do
    @merchant_1 = Merchant.create!(name: 'Schroeder-Jerde')
    @item_1 = @merchant_1.items.create!(name: 'tem Qui Esse', description: 'nihil autem', unit_price: 75107)
    @item_2 = @merchant_1.items.create!(name: 'Item Autem Minima', description: 'Cumque consequuntu', unit_price: 67076)
  end

  it 'contains relevant item information' do
    visit "/merchants/#{@merchant_1.id}/items/#{@item_1.id}"
    expect(page).to have_content(@item_1.name)
    expect(page).to have_content(@item_1.description)
    expect(page).to have_content(@item_1.unit_price)
    expect(page).to_not have_content(@item_2.name)
    expect(page).to_not have_content(@item_2.description)
    expect(page).to_not have_content(@item_2.unit_price)

    visit "/merchants/#{@merchant_1.id}/items/#{@item_2.id}"
    expect(page).to have_content(@item_2.name)
    expect(page).to have_content(@item_2.description)
    expect(page).to have_content(@item_2.unit_price)
    expect(page).to_not have_content(@item_1.name)
    expect(page).to_not have_content(@item_1.description)
    expect(page).to_not have_content(@item_1.unit_price)
  end

  it 'links to appropriate edit button' do
    visit "/merchants/#{@merchant_1.id}/items/#{@item_1.id}"
    click_button("Edit #{@item_1.name}")
    expect(current_path).to eq("/merchants/#{@merchant_1.id}/items/#{@item_1.id}/edit")

    visit "/merchants/#{@merchant_1.id}/items/#{@item_2.id}"
    click_button("Edit #{@item_2.name}")
    expect(current_path).to eq("/merchants/#{@merchant_1.id}/items/#{@item_2.id}/edit")
  end


end
