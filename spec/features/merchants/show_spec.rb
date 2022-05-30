require 'rails_helper'

RSpec.describe 'Merchant Show Dash' do
  before(:each) do
    @billman = Merchant.create!(name: "Billman", created_at: Time.now, updated_at: Time.now)

    @bracelet = @billman.items.create!(name: "Bracelet", description: "shiny", unit_price: 1001, created_at: Time.now, updated_at: Time.now)
    @mood = @billman.items.create!(name: "Mood Ring", description: "Moody", unit_price: 2002, created_at: Time.now, updated_at: Time.now)

    @brenda = Customer.create!(first_name: "Brenda", last_name: "Bhoddavista", created_at: Time.now, updated_at: Time.now)

    @invoice1 = @brenda.invoices.create!(status: "In Progress", created_at: Time.now, updated_at: Time.now)

    @order1 = @bracelet.invoice_items.create!(quantity: 1, unit_price: 10000, status: "Pending", invoice_id: @invoice1.id, created_at: Time.now, updated_at: Time.now)
    @order2 = @mood.invoice_items.create!(quantity: 1, unit_price: 1000, status: "Pending", invoice_id: @invoice1.id, created_at: Time.now, updated_at: Time.now)
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
