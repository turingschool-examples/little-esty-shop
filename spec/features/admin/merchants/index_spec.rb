require 'rails_helper'

RSpec.describe "Admin Merchants Index Page" do
  let!(:merchant1) { Merchant.create!(name: "REI") }
  let!(:merchant2) { Merchant.create!(name: "Target") }
  let!(:merchant3) { Merchant.create!(name: "Walgreens") }
  let!(:merchant4) { Merchant.create!(name: "Hot Topic", status: 1) }
  let!(:merchant5) {Merchant.create!(name: "Kmart")}
  let!(:merchant6) {Merchant.create!(name: "Macys")}

  let!(:item1) { merchant1.items.create!(name: "Boots", description: "Never get blisters again!", unit_price: 135) }
  let!(:item2) { merchant1.items.create!(name: "Tent", description: "Will survive any storm", unit_price: 219.99) }
  let!(:item3) { merchant1.items.create!(name: "Backpack", description: "Can carry all your hiking snacks", unit_price: 99) }
  let!(:item4) { merchant2.items.create!(name: "Socks", description: "Oooooh, wool", unit_price: 15) }
  let!(:item5) { merchant3.items.create!(name: "Nalgene", description: "Put all your cool stickers here", unit_price: 12) }
  let!(:item6) { merchant4.items.create!(name: "Fanny Pack", description: "Forget what the haters say, they're stylish", unit_price: 25) }
  let!(:item7) { merchant6.items.create!(name: "Mountain Bike", description: "Shred the gnar!!", unit_price: 1199) }

  let!(:invoice_item1) { InvoiceItem.create!(item_id: item1.id, invoice_id: invoice1.id, quantity: 5, unit_price: 130, status: "shipped") }
  let!(:invoice_item2) { InvoiceItem.create!(item_id: item1.id, invoice_id: invoice1.id, quantity: 10, unit_price: 130, status: "pending") }
  let!(:invoice_item3) { InvoiceItem.create!(item_id: item2.id, invoice_id: invoice2.id, quantity: 8, unit_price: 220, status: "packaged") }
  let!(:invoice_item4) { InvoiceItem.create!(item_id: item3.id, invoice_id: invoice4.id, quantity: 1, unit_price: 100, status: "packaged") }
  let!(:invoice_item5) { InvoiceItem.create!(item_id: item3.id, invoice_id: invoice5.id, quantity: 2, unit_price: 15, status: "shipped") }
  let!(:invoice_item6) { InvoiceItem.create!(item_id: item3.id, invoice_id: invoice6.id, quantity: 3, unit_price: 12, status: "packaged") }
  let!(:invoice_item7) { InvoiceItem.create!(item_id: item2.id, invoice_id: invoice6.id, quantity: 1, unit_price: 16, status: "packaged") }
  let!(:invoice_item8) { InvoiceItem.create!(item_id: item2.id, invoice_id: invoice5.id, quantity: 2, unit_price: 12, status: "pending") }
  let!(:invoice_item9) { InvoiceItem.create!(item_id: item1.id, invoice_id: invoice1.id, quantity: 4, unit_price: 35, status: "packaged") }
  let!(:invoice_item10) { InvoiceItem.create!(item_id: item1.id, invoice_id: invoice4.id, quantity: 1, unit_price: 35, status: "packaged") }
  let!(:invoice_item11) { InvoiceItem.create!(item_id: item4.id, invoice_id: invoice6.id, quantity: 3, unit_price: 12, status: "packaged") }
  let!(:invoice_item12) { InvoiceItem.create!(item_id: item4.id, invoice_id: invoice6.id, quantity: 1, unit_price: 16, status: "packaged") }
  let!(:invoice_item13) { InvoiceItem.create!(item_id: item5.id, invoice_id: invoice5.id, quantity: 2, unit_price: 12, status: "pending") }
  let!(:invoice_item14) { InvoiceItem.create!(item_id: item6.id, invoice_id: invoice1.id, quantity: 4, unit_price: 35, status: "packaged") }
  let!(:invoice_item15) { InvoiceItem.create!(item_id: item7.id, invoice_id: invoice4.id, quantity: 1, unit_price: 35, status: "packaged") }

  let!(:customer1) { Customer.create!(first_name: "Leanne", last_name: "Braun") }
  let!(:customer2) { Customer.create!(first_name: "Sylvester", last_name: "Nader") }
  let!(:customer3) { Customer.create!(first_name: "Heber", last_name: "Kuhn") }
  let!(:customer4) { Customer.create!(first_name: "Mariah", last_name: "Toy") }
  let!(:customer5) { Customer.create!(first_name: "Carl", last_name: "Junior") }
  let!(:customer6) { Customer.create!(first_name: "Tony", last_name: "Bologna") }

  let!(:invoice1) { customer1.invoices.create!(status: 2, created_at: '2012-03-21 14:53:59') }
  let!(:invoice2) { customer1.invoices.create!(status: 2, created_at: '2012-03-23 14:53:59') }
  let!(:invoice3) { customer1.invoices.create!(status: 2, created_at: '2012-03-24 14:53:59') }
  let!(:invoice4) { customer1.invoices.create!(status: 2, created_at: '2012-03-25 14:53:59') }
  let!(:invoice5) { customer5.invoices.create!(status: 2, created_at: '2012-03-22 14:53:59') }
  let!(:invoice6) { customer6.invoices.create!(status: 2, created_at: '2012-03-22 14:53:59') }
  let!(:invoice7) { customer2.invoices.create!(status: 2, created_at: '2012-03-22 14:53:59') }
  let!(:invoice8) { customer2.invoices.create!(status: 2, created_at: '2012-03-22 14:53:59') }
  let!(:invoice9) { customer3.invoices.create!(status: 2, created_at: '2012-03-22 14:53:59') }
  let!(:invoice10) { customer5.invoices.create!(status: 2, created_at: '2012-03-22 14:53:59') }
  let!(:invoice11) { customer6.invoices.create!(status: 2, created_at: '2012-03-22 14:53:59') }
  let!(:invoice12) { customer6.invoices.create!(status: 2, created_at: '2012-03-22 14:53:59') }
  let!(:invoice13) { customer4.invoices.create!(status: 2, created_at: '2012-03-22 14:53:59') }
  let!(:invoice14) { customer4.invoices.create!(status: 2, created_at: '2012-03-22 14:53:59') }
  let!(:invoice15) { customer4.invoices.create!(status: 2, created_at: '2012-03-22 14:53:59') }
  let!(:invoice16) { customer5.invoices.create!(status: 2, created_at: '2012-03-22 14:53:59') }
  let!(:invoice17) { customer5.invoices.create!(status: 2, created_at: '2012-03-22 14:53:59') }
  let!(:invoice18) { customer4.invoices.create!(status: 2, created_at: '2012-03-22 14:53:59') }
  let!(:invoice19) { customer1.invoices.create!(status: 2, created_at: '2012-03-22 14:53:59') }
  let!(:invoice20) { customer1.invoices.create!(status: 2, created_at: '2012-03-22 14:53:59') }
  let!(:invoice21) { customer5.invoices.create!(status: 2, created_at: '2012-03-22 14:53:59') }
  let!(:invoice22) { customer4.invoices.create!(status: 2, created_at: '2012-03-22 14:53:59') }

  let!(:transaction1) { Transaction.create!(invoice_id: invoice1.id, credit_card_number: 4654405418249632, credit_card_expiration_date: "2/22", result: "success") }
  let!(:transaction2) { Transaction.create!(invoice_id: invoice2.id, credit_card_number: 4580251236515201, credit_card_expiration_date: "1/22", result: "success") }
  let!(:transaction3) { Transaction.create!(invoice_id: invoice3.id, credit_card_number: 4354495077693036, credit_card_expiration_date: "10/22", result: "success") }
  let!(:transaction4) { Transaction.create!(invoice_id: invoice4.id, credit_card_number: 4515551623735607, credit_card_expiration_date: "4/25", result: "success") }
  let!(:transaction5) { Transaction.create!(invoice_id: invoice5.id, credit_card_number: 4844518708741275, credit_card_expiration_date: "4/23", result: "success") }
  let!(:transaction6) { Transaction.create!(invoice_id: invoice6.id, credit_card_number: 4203696133194408, credit_card_expiration_date: "5/22", result: "success") }
  let!(:transaction7) { Transaction.create!(invoice_id: invoice7.id, credit_card_number: 4801647818676136, credit_card_expiration_date: "5/23", result: "success") }
  let!(:transaction8) { Transaction.create!(invoice_id: invoice8.id, credit_card_number: 4354495077693036, credit_card_expiration_date: "10/22", result: "success") }
  let!(:transaction9) { Transaction.create!(invoice_id: invoice9.id, credit_card_number: 4515551623735607, credit_card_expiration_date: "4/25", result: "success") }
  let!(:transaction10) { Transaction.create!(invoice_id: invoice10.id, credit_card_number: 4844518708741275, credit_card_expiration_date: "4/23", result: "success") }
  let!(:transaction11) { Transaction.create!(invoice_id: invoice11.id, credit_card_number: 4203696133194408, credit_card_expiration_date: "5/22", result: "success") }
  let!(:transaction12) { Transaction.create!(invoice_id: invoice12.id, credit_card_number: 4801647818676136, credit_card_expiration_date: "5/23", result: "success") }
  let!(:transaction13) { Transaction.create!(invoice_id: invoice13.id, credit_card_number: 4801647818676136, credit_card_expiration_date: "5/23", result: "success") }
  let!(:transaction14) { Transaction.create!(invoice_id: invoice14.id, credit_card_number: 4801647818676136, credit_card_expiration_date: "5/23", result: "success") }
  let!(:transaction15) { Transaction.create!(invoice_id: invoice15.id, credit_card_number: 4801647818676136, credit_card_expiration_date: "5/23", result: "success") }
  let!(:transaction16) { Transaction.create!(invoice_id: invoice16.id, credit_card_number: 4801647818676136, credit_card_expiration_date: "5/23", result: "success") }
  let!(:transaction17) { Transaction.create!(invoice_id: invoice17.id, credit_card_number: 4801647818676136, credit_card_expiration_date: "5/23", result: "failed") }
  let!(:transaction18) { Transaction.create!(invoice_id: invoice18.id, credit_card_number: 4801647818676136, credit_card_expiration_date: "5/23", result: "success") }
  let!(:transaction19) { Transaction.create!(invoice_id: invoice19.id, credit_card_number: 4801647818676136, credit_card_expiration_date: "5/23", result: "success") }
  let!(:transaction20) { Transaction.create!(invoice_id: invoice20.id, credit_card_number: 4801647818676136, credit_card_expiration_date: "5/23", result: "success") }
  let!(:transaction21) { Transaction.create!(invoice_id: invoice21.id, credit_card_number: 4801647818676136, credit_card_expiration_date: "5/23", result: "success") }
  let!(:transaction22) { Transaction.create!(invoice_id: invoice22.id, credit_card_number: 4801647818676136, credit_card_expiration_date: "5/23", result: "success") }

  before do
    visit admin_merchants_path
  end

  it "displays the name of each merchant in the system" do
    expect(page).to have_content("Welcome to the Admin Dashboard")

    within ".disabled-merchants" do
      expect(page).to have_content("REI")
      expect(page).to have_content("Target")
      expect(page).to have_content("Walgreens")
      expect(page).to_not have_content("Hot Topic")
    end

    within ".enabled-merchants" do
      expect(page).to have_content("Hot Topic")
      expect(page).to_not have_content("REI")
      expect(page).to_not have_content("Target")
      expect(page).to_not have_content("Walgreens")
    end
  end

  it "has a link to each Merchant's Admin Show page" do
    visit admin_merchants_path

    within "#enabled-merchants-#{merchant4.id}" do
      expect(page).to have_link("Hot Topic")
      expect(page).to_not have_link("Target")
      click_link ("Hot Topic")
    end

    expect(current_path).to eq(admin_merchant_path(merchant4))

    visit admin_merchants_path

    within "#disabled-merchants-#{merchant1.id}" do
      expect(page).to have_link("REI")
      expect(page).to_not have_link("Hot Topic")
      click_link ("REI")
    end

    expect(current_path).to eq(admin_merchant_path(merchant1))
  end

  it "has a button to enable/disable a merchant" do
    visit admin_merchants_path

    within "#enabled-merchants-#{merchant4.id}" do
      expect(page).to have_link("Hot Topic")
      expect(page).to_not have_link("Target")
      expect(page).to have_button("Disable")
      expect(page).to_not have_button("Enable")
      click_button ("Disable")
    end

    within "#disabled-merchants-#{merchant1.id}" do
      expect(page).to have_link("REI")
      expect(page).to_not have_link("Hot Topic")
      expect(page).to have_button("Enable")
      expect(page).to_not have_button("Disable")
      click_button ("Enable")
    end

    visit admin_merchants_path

    within ".enabled-merchants" do
      expect(page).to_not have_link("Hot Topic")
      expect(page).to have_link("REI")
    end

    within ".disabled-merchants" do
      expect(page).to_not have_link("REI")
      expect(page).to have_link("Hot Topic")
    end
  end

  it "can fill out a form to create a new merchant and display the default status of disabled" do
    expect(page).to_not have_content('Backcountry')

    click_link "Create a New Merchant"
    expect(current_path).to eq(new_admin_merchant_path)

    fill_in 'merchant[name]', with: 'Backcountry'
    click_on "Create Merchant"

    expect(current_path).to eq(admin_merchants_path)

    within ".disabled-merchants" do
      expect(page).to have_content('Backcountry')
      expect(page).to have_content('Status: Disabled')
    end
  end

  it "displays a link to create a new merchant" do
    expect(page).to have_link('New Merchant')
  end

  it "lists top 5 merchants by revenue" do
    within "#top-five-merchants" do
      expect(page).to have_content("REI Revenue: $409,100.00")
      expect(page).to have_content("Target Revenue: $208.00")
      expect(page).to have_content("Hot Topic Revenue: $140.00")
      expect(page).to have_content("Macys Revenue: $35.00")
      expect(page).to have_content("Walgreens Revenue: $24.00")
      expect(page).to_not have_content("Kmart")
    end
  end

  it "lists the top selling date for each of the top 5 merchants" do
    within "#top-five-merchants" do
      expect(page).to have_content("Top selling date for REI was Wednesday, Mar 21")
      expect(page).to have_content("Top selling date for Target was Thursday, Mar 22")
      expect(page).to have_content("Top selling date for Hot Topic was Wednesday, Mar 21")
      expect(page).to have_content("Top selling date for Macys was Sunday, Mar 25")
      expect(page).to have_content("Top selling date for Walgreens was Thursday, Mar 22")
    end
  end
end
