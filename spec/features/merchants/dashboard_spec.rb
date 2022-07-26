require 'rails_helper'

RSpec.describe "merchant dashboard", type: :feature do
  before :each do
    @merchant_1 = Merchant.create!(name: "Schroeder-Jerde", created_at: Time.now, updated_at: Time.now)
    @merchant_2 = Merchant.create!(name: "Klein, Rempel and Jones", created_at: Time.now, updated_at: Time.now)

  end

  it 'shows the merchants name' do
    visit "/merchants/#{@merchant_1.id}/dashboard"
    within('#merchant-details') do
      expect(page).to have_content('Schroeder-Jerde')
      expect(page).to_not have_content('Klein, Rempel and Jones')
    end
  end

  it "has links to merchant items index and merchant invoices index" do
    expect(page).to have_link("My Items", href: "/merchants/#{@merchant_1.id}/items")
    expect(page).to have_link("My Invoices", href: "/merchants/#{@merchant_1.id}/invoices")
    expect(page).to_not have_link("My Items", href: "/merchants/#{@merchant_2.id}/items")
    expect(page).to_not have_link("My Invoices", href: "/merchants/#{@merchant_2.id}/invoices")
  end
end
