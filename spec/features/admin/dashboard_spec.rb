require 'rails_helper'

RSpec.describe 'the admin dashboard', type: :feature do

  before(:each)do
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

    @invoice1 = @brenda.invoices.create!(status: "In Progress", created_at: Time.now - 1.days)
    @invoice2 = @brenda.invoices.create!(status: "Completed", created_at: Time.now - 2.days)
    @invoice3 = @jimbob.invoices.create!(status: "Completed", created_at: Time.now - 3.days)
    @invoice4 = @jimbob.invoices.create!(status: "Completed", created_at: Time.now - 4.days)
    @invoice5 = @casey.invoices.create!(status: "Completed", created_at: Time.now - 5.days)

    @order1 = @bracelet.invoice_items.create!(quantity: 1, unit_price: 1001, status: "pending", invoice_id: @invoice1.id)
    @order2 = @mood.invoice_items.create!(quantity: 1, unit_price: 2002, status: "packaged", invoice_id: @invoice1.id)
    @order3 = @mood.invoice_items.create!(quantity: 3, unit_price: 2002, status: "pending", invoice_id: @invoice2.id)
    @order4 = @beard.invoice_items.create!(quantity: 5, unit_price: 5099, status: "shipped", invoice_id: @invoice5.id)
    @order5 = @balm.invoice_items.create!(quantity: 3, unit_price: 4599, status: "shipped", invoice_id: @invoice3.id)
    @order6 = @necklace.invoice_items.create!(quantity: 1, unit_price: 3045, status: "pending", invoice_id: @invoice3.id)
    @order7 = @beard.invoice_items.create!(quantity: 1, unit_price: 5099, status: "packaged", invoice_id: @invoice4.id)
  end

  it 'has a header indicating I am on the admin dashboard', :vcr do

    visit '/admin'

    expect(page).to have_content("Admin Dashboard")
  end

  it 'has link to admin merchants', :vcr do
    visit '/admin'

    expect(page).to have_link("Merchants")

    click_link("Merchants")

    expect(current_path).to eq("/admin/merchants")
  end

  it 'has link to admin invoices', :vcr do
    visit '/admin'

    expect(page).to have_link("Invoices")

    click_link("Invoices")

    expect(current_path).to eq("/admin/invoices")
  end

  it 'has a section for incomplete invoices', :vcr do
    visit '/admin'

    expect(page).to have_content("Incomplete Invoices")

    within '#incompleteInvoices' do
      expect(page).to have_content(@invoice1.id)
      expect(page).to have_content(@invoice2.id)
      expect(page).to have_content(@invoice3.id)
      expect(page).to have_content(@invoice4.id)
    end
  end

  it 'each incomplete invoice links to invoice admin show page', :vcr do
    visit '/admin'

    within '#incompleteInvoices' do
      expect(page).to have_content(@invoice1.id)

      click_link "#{@invoice1.id}"

      expect(current_path).to eq(admin_invoice_path(@invoice1))
    end
  end

  describe 'Top 5 customers' do
    it 'can display the names of the top five customers with the most sucessful transactions, as well as the count', :vcr do
      billman = Merchant.create!(name: "Billman")
      parker = Merchant.create!(name: "Parker's Perfection Pagoda")

      brenda = Customer.create!(first_name: "Brenda", last_name: "Bhoddavista")
      jimbob = Customer.create!(first_name: "Jimbob", last_name: "Dudeguy")
      casey = Customer.create!(first_name: "Casey", last_name: "Zafio")
      nick = Customer.create!(first_name: "Nick", last_name: "Jocabs")
      chris = Customer.create!(first_name: "Chris", last_name: "Kjolheed")
      mike = Customer.create!(first_name: "Mike", last_name: "Ado")

      bracelet = billman.items.create!(name: "Bracelet", description: "shiny", unit_price: 1001)
      beard = parker.items.create!(name: "beard oil", description: "oily", unit_price: 2002)

      invoice1 = chris.invoices.create!(status: "In Progress")
      invoice2 = chris.invoices.create!(status: "Completed")
      transaction1 = invoice1.transactions.create!(credit_card_number: 4654405418249632, result: "success")
      transaction2 = invoice2.transactions.create!(credit_card_number: 4654405418249632, result: "failed")

      invoice3 = jimbob.invoices.create!(status: "Completed")
      invoice4 = jimbob.invoices.create!(status: "Completed")
      transaction3 = invoice3.transactions.create!(credit_card_number: 4654405418249632, result: "success")
      transaction4 = invoice4.transactions.create!(credit_card_number: 4654405418249632, result: "success")

      invoice5 = casey.invoices.create!(status: "In Progress")
      transaction5 = invoice5.transactions.create!(credit_card_number: 4654405418249632, result: "success")

      invoice6 = mike.invoices.create!(status: "Completed")
      invoice7 = mike.invoices.create!(status: "Completed")
      invoice8 = mike.invoices.create!(status: "Completed")
      transaction6 = invoice6.transactions.create!(credit_card_number: 4654405418249632, result: "success")
      transaction7 = invoice7.transactions.create!(credit_card_number: 4654405418249632, result: "success")
      transaction8 = invoice8.transactions.create!(credit_card_number: 4654405418249632, result: "success")

      invoice9 = nick.invoices.create!(status: "Completed")
      invoice11 = nick.invoices.create!(status: "Completed")
      transaction9 = invoice9.transactions.create!(credit_card_number: 4654405418249632, result: "success")
      transaction11 = invoice11.transactions.create!(credit_card_number: 4654405418249632, result: "success")

      invoice10 = brenda.invoices.create!(status: "Completed")
      transaction10 = invoice10.transactions.create!(credit_card_number: 4654405418249632, result: "failed")


      InvoiceItem.create!(item_id: beard.id, invoice_id: invoice1.id, quantity: 1, unit_price: 1000, status: "Shipped")
      InvoiceItem.create!(item_id: bracelet.id, invoice_id: invoice2.id, quantity: 2, unit_price: 1000, status: "Shipped")
      InvoiceItem.create!(item_id: bracelet.id, invoice_id: invoice3.id, quantity: 3, unit_price: 1000, status: "Shipped")
      InvoiceItem.create!(item_id: bracelet.id, invoice_id: invoice4.id, quantity: 4, unit_price: 1000, status: "Shipped")
      InvoiceItem.create!(item_id: bracelet.id, invoice_id: invoice5.id, quantity: 5, unit_price: 1000, status: "Shipped")
      InvoiceItem.create!(item_id: bracelet.id, invoice_id: invoice6.id, quantity: 1, unit_price: 1000, status: "Shipped")
      InvoiceItem.create!(item_id: bracelet.id, invoice_id: invoice7.id, quantity: 2, unit_price: 1000, status: "Shipped")
      InvoiceItem.create!(item_id: bracelet.id, invoice_id: invoice8.id, quantity: 3, unit_price: 1000, status: "Shipped")
      InvoiceItem.create!(item_id: bracelet.id, invoice_id: invoice9.id, quantity: 4, unit_price: 1000, status: "Shipped")
      InvoiceItem.create!(item_id: bracelet.id, invoice_id: invoice10.id, quantity: 5, unit_price: 1000, status: "Shipped")

      visit "/admin"
      within "#topCustomers" do
        expect(page.all('.topCustomer')[0]).to have_content("Mike Ado- 3 purchases")
        expect(page.all('.topCustomer')[1]).to have_content("Jimbob Dudeguy- 2 purchases")
        expect(page.all('.topCustomer')[2]).to have_content("Nick Jocabs- 2 purchases")
        expect(page.all('.topCustomer')[3]).to have_content("Casey Zafio- 1 purchases")
        expect(page.all('.topCustomer')[4]).to have_content("Chris Kjolheed- 1 purchases")
        expect(page.all('.topCustomer')[5]).to eq(nil)
      end
    end
  end
end
