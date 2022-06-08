require 'rails_helper'

RSpec.describe 'Merchant invoices index', type: :feature do

  before(:each) do
    @billman = Merchant.create!(name: "Billman")
    @parker = Merchant.create!(name: "Parker's Perfection Pagoda")

    @bracelet = @billman.items.create!(name: "Bracelet", description: "shiny", unit_price: 1001)
    @mood = @billman.items.create!(name: "Mood Ring", description: "Moody", unit_price: 2002)
    @necklace = @billman.items.create!(name: "Necklace", description: "Sparkly", unit_price: 3045)

    @beard = @parker.items.create!(name: "Beard Oil", description: "Lavender Scented", unit_price: 5099)
    @balm = @billman.items.create!(name: "Shaving Balm", description: "Balmy", unit_price: 4599)

    @brenda = Customer.create!(first_name: "Brenda", last_name: "Bhoddavista")
    @jimbob = Customer.create!(first_name: "Jimbob", last_name: "Dudeguy")
    @casey = Customer.create!(first_name: "Casey", last_name: "Zafio")

    @invoice1 = @brenda.invoices.create!(status: "In Progress")
    @invoice2 = @brenda.invoices.create!(status: "Completed")
    @invoice3 = @jimbob.invoices.create!(status: "Completed")
    @invoice4= @jimbob.invoices.create!(status: "Completed")
    @invoice5 = @casey.invoices.create!(status: "Completed")

    @order1 = @bracelet.invoice_items.create!(quantity: 1, unit_price: 1001, status: "Pending", invoice_id: @invoice1.id)
    @order2 = @mood.invoice_items.create!(quantity: 1, unit_price: 2002, status: "Packaged", invoice_id: @invoice1.id)
    @order3 = @mood.invoice_items.create!(quantity: 3, unit_price: 2002, status: "Pending", invoice_id: @invoice2.id)
    @order4 = @beard.invoice_items.create!(quantity: 5, unit_price: 5099, status: "Shipped", invoice_id: @invoice5.id)
    @order5 = @balm.invoice_items.create!(quantity: 3, unit_price: 4599, status: "Shipped", invoice_id: @invoice3.id)
    @order6 = @necklace.invoice_items.create!(quantity: 1, unit_price: 3045, status: "Pending", invoice_id: @invoice3.id)
    @order7 = @beard.invoice_items.create!(quantity: 1, unit_price: 5099, status: "Packaged", invoice_id: @invoice4.id)
  end

  it 'shows all invoices that a particular merchant appears on', :vcr do

    visit "/merchants/#{@billman.id}/invoices"

    expect(page).to have_content(@invoice1.id)
    expect(page).to have_content(@invoice2.id)
    expect(page).to have_content(@invoice3.id)
  end

  it 'has the invoice ids as links to that invoices show page', :vcr do
    visit "/merchants/#{@billman.id}/invoices"

    click_link("#{@invoice1.id}")

    expect(page).to have_current_path("/merchants/#{@billman.id}/invoices/#{@invoice1.id}")
  end
end
