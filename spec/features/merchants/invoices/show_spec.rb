require 'rails_helper'

RSpec.describe 'Merchant invoices show page', type: :feature do

  before(:each) do
    @billman = Merchant.create!(name: "Billman")
    @parker = Merchant.create!(name: "Parker's Perfection Pagoda")

    @bracelet = @billman.items.create!(name: "Bracelet", description: "shiny", unit_price: 1001)
    @mood = @billman.items.create!(name: "Mood Ring", description: "Moody", unit_price: 2002)
    @necklace = @billman.items.create!(name: "Necklace", description: "Sparkly", unit_price: 3045)

    @beard = @parker.items.create!(name: "Beard Oil", description: "Lavender Scented", unit_price: 5099)
    @balm = @parker.items.create!(name: "Shaving Balm", description: "Balmy", unit_price: 4599)

    @brenda = Customer.create!(first_name: "Brenda", last_name: "Bhoddavista")
    @jimbob = Customer.create!(first_name: "Jimbob", last_name: "Dudeguy")
    @casey = Customer.create!(first_name: "Casey", last_name: "Zafio")

    @invoice1 = @brenda.invoices.create!(status: "In Progress")
    @invoice2 = @brenda.invoices.create!(status: "Completed")
    @invoice3 = @jimbob.invoices.create!(status: "Completed")
    @invoice4= @jimbob.invoices.create!(status: "Completed")
    @invoice5 = @casey.invoices.create!(status: "Completed")

    @order1 = @bracelet.invoice_items.create!(quantity: 1, unit_price: 1001, status: "Pending", invoice_id: @invoice1.id)
    @order2 = @mood.invoice_items.create!(quantity: 5, unit_price: 2002, status: "Packaged", invoice_id: @invoice1.id)
    @order3 = @mood.invoice_items.create!(quantity: 3, unit_price: 2002, status: "Pending", invoice_id: @invoice2.id)
    @order4 = @beard.invoice_items.create!(quantity: 5, unit_price: 5099, status: "Shipped", invoice_id: @invoice5.id)
    @order5 = @balm.invoice_items.create!(quantity: 3, unit_price: 4599, status: "Shipped", invoice_id: @invoice3.id)
    @order6 = @necklace.invoice_items.create!(quantity: 1, unit_price: 3045, status: "Pending", invoice_id: @invoice3.id)
    @order7 = @beard.invoice_items.create!(quantity: 1, unit_price: 5099, status: "Packaged", invoice_id: @invoice4.id)
  end

  it 'displays all the information pertaining to an invoice' do
    visit "/merchants/#{@billman.id}/invoices/#{@invoice1.id}"

    expect(page).to have_content(@invoice1.id)
    expect(page).to_not have_content(@invoice2.id)
    expect(page).to_not have_content(@invoice3.id)
    expect(page).to_not have_content(@invoice4.id)
    expect(page).to_not have_content(@invoice5.id)

    testdate = @invoice1.created_at.strftime('%A, %B %-e, %Y') #test is rendering with an extra space between month and day, modified in test to be one space only

    within "#invoiceDetails" do
      expect(page).to have_content(@invoice1.status)
      expect(page).to have_content("Created on: #{testdate}")
      expect(page).to have_content("Brenda Bhoddavista")
    end
  end

  it 'lists all the items on the invoice' do
    visit "/merchants/#{@billman.id}/invoices/#{@invoice1.id}"

    expect(page).to have_content(@bracelet.name)
    expect(page).to have_content(@mood.name)
    expect(page).to_not have_content(@beard.name)

    within "#invoiceItem-#{@order1.id}" do
      expect(page).to have_content(@bracelet.name)
      expect(page).to have_content("Quantity: #{@order1.quantity}")
      expect(page).to have_content("Price: #{@bracelet.unit_price}")
      expect(page.has_select?(:status, selected: "Pending")).to eq(true)
    end

    within "#invoiceItem-#{@order2.id}" do
      expect(page).to have_content(@mood.name)
      expect(page).to have_content("Quantity: #{@order2.quantity}")
      expect(page).to have_content("Price: #{@mood.unit_price}")
      expect(page.has_select?(:status, selected: "Packaged")).to eq(true)
    end
  end

  it 'lists all the items on the invoice from just the designated merchant' do
    visit "/merchants/#{@billman.id}/invoices/#{@invoice3.id}"

    expect(page).to have_content(@necklace.name)
    expect(page).to_not have_content(@balm.name)
    expect(page).to_not have_content(@beard.name)

    within "#invoiceItem-#{@order6.id}" do
      expect(page).to have_content(@necklace.name)
      expect(page).to have_content("Quantity: #{@order6.quantity}")
      expect(page).to have_content("Price: #{@necklace.unit_price}")
      expect(page.has_select?(:status, selected: "Pending")).to eq(true)
      expect(page).to_not have_content(@balm.name)
      expect(page).to_not have_content("Price: #{@balm.unit_price}")
    end
  end

  it 'can list total revenue for this merchant generated from the invoice' do
    visit "/merchants/#{@billman.id}/invoices/#{@invoice3.id}"
    expect(page).to have_content("Total Revenue: 30.45")

    expect(page).to_not have_content("Total Revenue: 168.42")
  end

  it 'has a drop down box for invoice item status that contains the current status' do
    visit "/merchants/#{@parker.id}/invoices/#{@invoice5.id}"

    expect(page).to have_select(:status, :with_options => ["Pending", "Packaged", "Shipped"])

    expect(page.has_select?(:status, selected: "Shipped")).to eq(true)
    expect(page.has_select?(:status, selected: "Pending")).to eq(false)
  end

  it 'can update the items status to selected status when entered' do
    visit "/merchants/#{@billman.id}/invoices/#{@invoice1.id}"

    within "#invoiceItem-#{@order1.id}" do
      select("Packaged", from: :status)
      click_button "Update Item Status"
    end
  end
end
