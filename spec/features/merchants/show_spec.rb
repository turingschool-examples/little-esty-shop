require 'rails_helper'

RSpec.describe 'Merchant Show Dash' do
  before(:each) do
    @billman = Merchant.create!(name: "Billman")

    bracelet = @billman.items.create!(name: "Bracelet")
    mood = @billman.items.create!(name: "Mood Ring")

    brenda = Customer.create!(first_name: "Brenda", last_name: "Bhoddavista")

    invoice1 = brenda.invoices.create!(status: "In Progress")

    order1 = bracelet.invoice_items.create!(quantity: 1, unit_price: 10000, status: "Pending", invoice_id: invoice1.id)
    order2 = mood.invoice_items.create!(quantity: 1, unit_price: 1000, status: "Pending", invoice_id: invoice1.id)
  end
  it "has the name of the merchant on the page" do
    visit "/merchants/#{@billman.id}/dashboard"

    expect(page).to have_content(@billman.name)
  end

  it "has a link to merchant items index" do
    visit "/merchants/#{@billman.id}/dashboard"

    expect(page).to have_link("#{@billman.name}'s Items")

    click_link("#{@billman.name}'s Items")

    expect(page).to have_current_path("/merchants/#{@billman.id}/items")
  end

  it "has a link to merchant invoices index" do
    visit "/merchants/#{@billman.id}/dashboard"

    expect(page).to have_link("#{@billman.name}'s Invoices")

    click_link("#{@billman.name}'s Invoices")

    expect(page).to have_current_path("/merchants/#{@billman.id}/invoices")
  end
end
