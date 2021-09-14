require 'rails_helper'

RSpec.describe 'merchant items new page' do
  before :each do
    @merchant = Merchant.create!(name: "Steve")
  end

  it 'has a form' do
    visit "/merchants/#{@merchant.id}/items/new"

    expect(page).to have_content("Add New Item to #{@merchant.name}")
    expect(page).to have_field("Name")
    expect(page).to have_field("Description")
    expect(page).to have_field("Unit price")
  end

  it 'creates a new item' do
    visit "/merchants/#{@merchant.id}/items/new"

    fill_in('Name', with: 'Keyboard')
    fill_in('Description', with: 'RGB')
    fill_in('Unit price', with: 4000)
    click_on "Submit"

    expect(current_path).to eq("/merchants/#{@merchant.id}/items")

    within("#disabled") do
      expect(page).to have_content("Keyboard")
    end
  end

  it 'returns an error when a field is invalid' do
    visit "/merchants/#{@merchant.id}/items/new"

    fill_in('Name', with: 'Keyboard')
    click_on "Submit"

    expect(current_path).to eq("/merchants/#{@merchant.id}/items/new")
    expect(page).to have_content("Item not created. Information missing")
  end
end
