require 'rails_helper'

RSpec.describe 'Merchant Show Dash' do
  before(:each) do
    @billman = Merchant.create!(name: "Billman", created_at: Time.now, updated_at: Time.now)

    @bracelet = @billman.items.create!(name: "Bracelet", description: "shiny", unit_price: 1001, created_at: Time.now, updated_at: Time.now)
    @mood = @billman.items.create!(name: "Mood Ring", description: "Moody", unit_price: 2002, created_at: Time.now, updated_at: Time.now)
    @necklace = @billman.items.create!(name: "Necklace", description: "Sparkly", unit_price: 3045, created_at: Time.now, updated_at: Time.now)
    @toe_ring = @billman.items.create!(name: "Toe Ring", description: "Saucy", unit_price: 1053, created_at: Time.now, updated_at: Time.now)

    @brenda = Customer.create!(first_name: "Brenda", last_name: "Bhoddavista", created_at: Time.now, updated_at: Time.now)
    @jimbob = Customer.create!(first_name: "Jimbob", last_name: "Dudeguy", created_at: Time.now, updated_at: Time.now)
    @casey = Customer.create!(first_name: "Casey", last_name: "Zafio", created_at: Time.now, updated_at: Time.now)
    @nick = Customer.create!(first_name: "Nick", last_name: "Jocabs", created_at: Time.now, updated_at: Time.now)
    @chris = Customer.create!(first_name: "Chris", last_name: "Kjolheed", created_at: Time.now, updated_at: Time.now)
    @mike = Customer.create!(first_name: "Mike", last_name: "Ado", created_at: Time.now, updated_at: Time.now)

    @invoice1 = @brenda.invoices.create!(status: "In Progress", created_at: Time.now, updated_at: Time.now)
    @invoice2 = @brenda.invoices.create!(status: "Completed", created_at: Time.now, updated_at: Time.now)
    @invoice3 = @jimbob.invoices.create!(status: "Completed", created_at: Time.now, updated_at: Time.now)
    @invoice4= @jimbob.invoices.create!(status: "Completed", created_at: Time.now, updated_at: Time.now)
    @invoice5 = @jimbob.invoices.create!(status: "Completed", created_at: Time.now, updated_at: Time.now)
    @invoice6 = @casey.invoices.create!(status: "Completed", created_at: Time.now, updated_at: Time.now)
    @invoice7 = @nick.invoices.create!(status: "Completed", created_at: Time.now, updated_at: Time.now)
    @invoice8 = @mike.invoices.create!(status: "Completed", created_at: Time.now, updated_at: Time.now)
    @invoice9 = @mike.invoices.create!(status: "Completed", created_at: Time.now, updated_at: Time.now)
    @invoice10 = @mike.invoices.create!(status: "Completed", created_at: Time.now, updated_at: Time.now)

    @order1 = @bracelet.invoice_items.create!(quantity: 1, unit_price: 1001, status: "Pending", invoice_id: @invoice1.id, created_at: Time.now, updated_at: Time.now)
    @order2 = @mood.invoice_items.create!(quantity: 1, unit_price: 2002, status: "Pending", invoice_id: @invoice1.id, created_at: Time.now, updated_at: Time.now)
    @order3 = @mood.invoice_items.create!(quantity: 3, unit_price: 2002, status: "Pending", invoice_id: @invoice2.id, created_at: Time.now, updated_at: Time.now)

    @order4 = @toe_ring.invoice_items.create!(quantity: 5, unit_price: 1053, status: "Pending", invoice_id: @invoice10.id, created_at: Time.now, updated_at: Time.now)
    @order5 = @mood.invoice_items.create!(quantity: 3, unit_price: 2002, status: "Pending", invoice_id: @invoice10.id, created_at: Time.now, updated_at: Time.now)

    @order6 = @necklace.invoice_items.create!(quantity: 1, unit_price: 3045, status: "Pending", invoice_id: @invoice3.id, created_at: Time.now, updated_at: Time.now)
    @order7 = @mood.invoice_items.create!(quantity: 1, unit_price: 2002, status: "Pending", invoice_id: @invoice4.id, created_at: Time.now, updated_at: Time.now)

    @order8 = @necklace.invoice_items.create!(quantity: 4, unit_price: 3045, status: "Pending", invoice_id: @invoice5.id, created_at: Time.now, updated_at: Time.now)

    @order9 = @toe_ring.invoice_items.create!(quantity: 2, unit_price: 1053, status: "Pending", invoice_id: @invoice6.id, created_at: Time.now, updated_at: Time.now)

    @order10 = @toe_ring.invoice_items.create!(quantity: 1, unit_price: 1053, status: "Pending", invoice_id: @invoice7.id, created_at: Time.now, updated_at: Time.now)
    @order11 = @bracelet.invoice_items.create!(quantity: 1, unit_price: 1001, status: "Pending", invoice_id: @invoice7.id, created_at: Time.now, updated_at: Time.now)

    @order12 = @necklace.invoice_items.create!(quantity: 2, unit_price: 3045, status: "Pending", invoice_id: @invoice8.id, created_at: Time.now, updated_at: Time.now)

    @order13 = @mood.invoice_items.create!(quantity: 1, unit_price: 2002, status: "Pending", invoice_id: @invoice9.id, created_at: Time.now, updated_at: Time.now)

    @transaction1 = @invoice1.transactions.create!(credit_card_number: 4654405418249632, result: "success", created_at: Time.now, updated_at: Time.now)
    @transaction2 = @invoice2.transactions.create!(credit_card_number: 4580251236515201, result: "success", created_at: Time.now, updated_at: Time.now)
    @transaction3 = @invoice3.transactions.create!(credit_card_number: 4354495077693036, result: "success", created_at: Time.now, updated_at: Time.now)
    @transaction4 = @invoice4.transactions.create!(credit_card_number: 4515551623735607, result: "success", created_at: Time.now, updated_at: Time.now)
    @transaction5 = @invoice5.transactions.create!(credit_card_number: 4844518708741275, result: "success", created_at: Time.now, updated_at: Time.now)
    @transaction6 = @invoice6.transactions.create!(credit_card_number: 4203696133194408, result: "success", created_at: Time.now, updated_at: Time.now)
    @transaction7 = @invoice7.transactions.create!(credit_card_number: 4801647818676136, result: "success", created_at: Time.now, updated_at: Time.now)
    @transaction8 = @invoice8.transactions.create!(credit_card_number: 4540842003561938, result: "success", created_at: Time.now, updated_at: Time.now)
    @transaction9 = @invoice9.transactions.create!(credit_card_number: 4140149827486249, result: "success", created_at: Time.now, updated_at: Time.now)
    @transaction10 = @invoice10.transactions.create!(credit_card_number: 4923661117104166, result: "success", created_at: Time.now, updated_at: Time.now)
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

  # it "displays the names of top 5 customers" do
  #
  # end

end
