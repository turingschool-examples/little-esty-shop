require 'rails_helper'

RSpec.describe 'Merchants Dashboard Page' do
  before :each do
    @merchant = Merchant.create!(name: 'Tom Holland')

    visit merchant_dashboard_index_path(@merchant.id)
  end

  it 'is on the correct page' do
    expect(current_path).to eq(merchant_dashboard_index_path(@merchant.id))
    expect(page).to have_content("#{@merchant.name}")
  end

  it 'can take the user back one page' do
    click_link 'Return to Index'

    expect(current_path).to eq('/merchants')
  end

  it 'can take user to merchant items index page' do
    click_link 'All Items'

    expect(current_path).to eq("/merchants/#{@merchant.id}/items")
  end

  it 'can take user to merchant invoice index page' do
    click_link 'All Invoices'

    expect(current_path).to eq("/merchants/#{@merchant.id}/invoices")
  end

  it 'displays a link that takes you to the merchants discount index page' do
    expect(page).to have_link("Bulk Discounts for #{@merchant.name}")

    click_on "Bulk Discounts for #{@merchant.name}"

    expect(current_path).to eq(merchant_discounts_path(@merchant))
  end
end
