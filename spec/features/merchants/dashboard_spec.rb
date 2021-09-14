require 'rails_helper'

describe 'merchant dashboard page' do
  before(:each) do
    @merch_1 = create(:merchant)

    visit "/merchants/#{@merch_1.id}/dashboard"
  end

  it 'shows the name of the merchant' do
    expect(page).to have_content(@merch_1.name)
  end

  it 'has link to merchant items index' do
    click_link("#{@merch_1.name}'s Items")

    expect(current_path).to eq("/merchants/#{@merch_1.id}/items")

    visit "/merchants/#{@merch_1.id}/dashboard"

    click_link("#{@merch_1.name}'s Invoices")

    expect(current_path).to eq("/merchants/#{@merch_1.id}/invoices")
  end
end
