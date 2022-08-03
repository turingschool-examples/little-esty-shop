require 'rails_helper'

RSpec.describe 'Merchant Items Create' do
  before :each do
    @walmart = Merchant.create!(name: "Wal-Mart")

    @pencil = Item.create!( name: "Pencil",
                            description: "Sharpen it and write with it.",
                            unit_price: 199,
                            merchant_id: @walmart.id)
  end

  it 'can create an item' do
    visit "/merchants/#{@walmart.id}/items"
    save_and_open_page
    click_link 'Create a New Item'

    expect(current_path).to eq("/merchants/#{@walmart.id}/items/new")

    within '#name-field' do
      fill_in :name, with: "Mechanical Pencil"
    end

    within '#description-field' do
      fill_in :description, with: "You can refill it with lead!"
    end

    within '#unit_price-field' do
      fill_in :unit_price, with: 299
    end

    click_button 'Create Item'

    expect(current_path).to eq("/merchants/#{@walmart.id}/items")

    within '#disabled-items-section' do
      expect(page).to have_content("Mechanical Pencil")
    end

    within '#enabled-items-section' do
      expect(page).to_not have_content("Mechanical Pencil")
    end
  end
end
