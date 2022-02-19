require 'rails_helper'

RSpec.describe 'Invoices', type: :feature do
  before do
    @merchant = create(:merchant)

    @invoice1 = create(:invoice, merchant: @merchant)
    @invoice2 = create(:invoice, merchant: @merchant)
    @invoice3 = create(:invoice, merchant: @merchant)
  end

  it "each merchant has an invoice index page." do
    visit "/merchants/#{@merchant.id}/invoices"

    expect(page).to have_content("Order Status: #{@invoice1.status}")
    expect(page).to have_content("Invoice Number: #{@invoice1.id}")
    expect(page).to have_content("Order Status: #{@invoice2.status}")
    expect(page).to have_content("Invoice Number: #{@invoice2.id}")
    expect(page).to have_content("Order Status: #{@invoice3.status}")
    expect(page).to have_content("Invoice Number: #{@invoice3.id}")
  end

  it "links from the merchants/invoices index to merch/inv/show" do
    visit "/merchants/#{@merchant.id}/invoices"

    click_link("Invoice Number: #{@invoice1.id}")
    expect(current_path).to eq("/merchants/#{@merchant.id}/invoices/#{@invoice1.id}")
  end

end
