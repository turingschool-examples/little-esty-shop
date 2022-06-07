require 'rails_helper'

RSpec.describe 'Merchant Show Dash' do
  before(:each) do
    @billman = Merchant.create!(name: "Billman")

    @bracelet = @billman.items.create!(name: "Bracelet", description: "shiny", unit_price: 1001)
    @mood = @billman.items.create!(name: "Mood Ring", description: "Moody", unit_price: 2002)
    @necklace = @billman.items.create!(name: "Necklace", description: "Sparkly", unit_price: 3045)
    @toe_ring = @billman.items.create!(name: "Toe Ring", description: "Saucy", unit_price: 1053)

    @brenda = Customer.create!(first_name: "Brenda", last_name: "Bhoddavista")
    @jimbob = Customer.create!(first_name: "Jimbob", last_name: "Dudeguy")
    @casey = Customer.create!(first_name: "Casey", last_name: "Zafio")
    @nick = Customer.create!(first_name: "Nick", last_name: "Jocabs")
    @chris = Customer.create!(first_name: "Chris", last_name: "Kjolheed")
    @mike = Customer.create!(first_name: "Mike", last_name: "Ado")

    @invoice1 = @brenda.invoices.create!(status: "In Progress")
    @invoice2 = @brenda.invoices.create!(status: "Completed")
    @invoice3 = @jimbob.invoices.create!(status: "Completed")
    @invoice4= @jimbob.invoices.create!(status: "Completed")
    @invoice5 = @jimbob.invoices.create!(status: "Completed")
    @invoice6 = @casey.invoices.create!(status: "Completed")
    @invoice7 = @nick.invoices.create!(status: "Completed")
    @invoice8 = @mike.invoices.create!(status: "Completed")
    @invoice9 = @mike.invoices.create!(status: "Completed")
    @invoice10 = @mike.invoices.create!(status: "Completed")

    @order1 = @bracelet.invoice_items.create!(quantity: 1, unit_price: 1001, status: "Pending", invoice_id: @invoice1.id)
    @order2 = @mood.invoice_items.create!(quantity: 1, unit_price: 2002, status: "Packaged", invoice_id: @invoice1.id)
    @order3 = @mood.invoice_items.create!(quantity: 3, unit_price: 2002, status: "Pending", invoice_id: @invoice2.id)

    @order4 = @toe_ring.invoice_items.create!(quantity: 5, unit_price: 1053, status: "Shipped", invoice_id: @invoice10.id)
    @order5 = @mood.invoice_items.create!(quantity: 3, unit_price: 2002, status: "Shipped", invoice_id: @invoice10.id)

    @order6 = @necklace.invoice_items.create!(quantity: 1, unit_price: 3045, status: "Pending", invoice_id: @invoice3.id)
    @order7 = @mood.invoice_items.create!(quantity: 1, unit_price: 2002, status: "Packaged", invoice_id: @invoice4.id)

    @order8 = @necklace.invoice_items.create!(quantity: 4, unit_price: 3045, status: "Shipped", invoice_id: @invoice5.id)

    @order9 = @toe_ring.invoice_items.create!(quantity: 2, unit_price: 1053, status: "Pending", invoice_id: @invoice6.id)

    @order10 = @toe_ring.invoice_items.create!(quantity: 1, unit_price: 1053, status: "Packaged", invoice_id: @invoice7.id)
    @order11 = @bracelet.invoice_items.create!(quantity: 1, unit_price: 1001, status: "Pending", invoice_id: @invoice7.id)

    @order12 = @necklace.invoice_items.create!(quantity: 2, unit_price: 3045, status: "Pending", invoice_id: @invoice8.id)

    @order13 = @mood.invoice_items.create!(quantity: 1, unit_price: 2002, status: "Shipped", invoice_id: @invoice9.id)

    @transaction1 = @invoice1.transactions.create!(credit_card_number: 4654405418249632, result: "success")
    @transaction2 = @invoice2.transactions.create!(credit_card_number: 4580251236515201, result: "success")
    @transaction3 = @invoice3.transactions.create!(credit_card_number: 4354495077693036, result: "success")
    @transaction4 = @invoice4.transactions.create!(credit_card_number: 4515551623735607, result: "success")
    @transaction5 = @invoice5.transactions.create!(credit_card_number: 4844518708741275, result: "success")
    @transaction6 = @invoice6.transactions.create!(credit_card_number: 4203696133194408, result: "success")
    @transaction7 = @invoice7.transactions.create!(credit_card_number: 4801647818676136, result: "success")
    @transaction8 = @invoice8.transactions.create!(credit_card_number: 4540842003561938, result: "success")
    @transaction9 = @invoice9.transactions.create!(credit_card_number: 4140149827486249, result: "success")
    @transaction10 = @invoice10.transactions.create!(credit_card_number: 4923661117104166, result: "success")
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

  it 'has a section for ready to ship items' do
    visit "/merchants/#{@billman.id}/dashboard"

    expect(page).to have_content("Items Ready to Ship")
    save_and_open_page
    within "#itemsReadyToShip" do
      expect(page).to have_content("Bracelet")
      expect(page).to have_link("#{@invoice1.id}")
      expect(page).to have_link("#{@invoice2.id}")
      expect(page).to have_link("#{@invoice6.id}")
      expect(page).to have_link("#{@invoice8.id}")
      expect(page).to_not have_link("#{@invoice5.id}")
      expect(page).to_not have_link("#{@invoice9.id}")
      expect(page).to_not have_link("#{@invoice10.id}")
    end
  end

end
