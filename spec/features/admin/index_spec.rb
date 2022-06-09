require 'rails_helper'

describe "Admin Dashboad" do
  let!(:merchant_1) {Merchant.create!(name: "REI")}
  let!(:merchant_2) {Merchant.create!(name: "Target")}

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
  let!(:invoice5) { customer5.invoices.create!(status: 2, created_at: '2012-03-26 14:53:59') }
  let!(:invoice6) { customer6.invoices.create!(status: 2, created_at: '2012-03-27 14:53:59') }
  let!(:invoice7) { customer2.invoices.create!(status: 2) }
  let!(:invoice8) { customer2.invoices.create!(status: 2) }
  let!(:invoice9) { customer3.invoices.create!(status: 2) }
  let!(:invoice10) { customer5.invoices.create!(status: 2) }
  let!(:invoice11) { customer6.invoices.create!(status: 2) }
  let!(:invoice12) { customer6.invoices.create!(status: 2) }
  let!(:invoice13) { customer4.invoices.create!(status: 2) }
  let!(:invoice14) { customer4.invoices.create!(status: 2) }
  let!(:invoice15) { customer4.invoices.create!(status: 2) }
  let!(:invoice16) { customer5.invoices.create!(status: 2) }
  let!(:invoice17) { customer5.invoices.create!(status: 2) }
  let!(:invoice18) { customer4.invoices.create!(status: 2) }
  let!(:invoice19) { customer1.invoices.create!(status: 2) }
  let!(:invoice20) { customer1.invoices.create!(status: 2) }
  let!(:invoice21) { customer5.invoices.create!(status: 2) }
  let!(:invoice22) { customer4.invoices.create!(status: 2) }

  let!(:item1) { merchant_1.items.create!(name: "Boots", description: "Never get blisters again!", unit_price: 135) }
  let!(:item2) { merchant_1.items.create!(name: "Tent", description: "Will survive any storm", unit_price: 219.99) }
  let!(:item3) { merchant_1.items.create!(name: "Backpack", description: "Can carry all your hiking snacks", unit_price: 99) }

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
    visit admin_index_path
  end

  it "displays a header indicating that the user is on the admin dashboard" do
    expect(page).to have_content("Welcome to the Admin Dashboard")
  end

  it "displays links to the admin merchants index and admin invoices index" do
    click_link("Merchants Index")
    expect(current_path).to eq(admin_merchants_path)

    visit admin_index_path
    click_link("Invoices Index")
    expect(current_path).to eq(admin_invoices_path)
  end

  it "displays incomplete invoices and links to that invoices admin show page" do
    within ".incomplete-invoices" do
      expect(page).to have_link("#{invoice1.id}")
      expect(page).to have_link("#{invoice2.id}")
      expect(page).to have_link("#{invoice4.id}")
      expect(page).to_not have_link("#{invoice3.id}")

      click_link("#{invoice1.id}")
      expect(current_path).to eq(admin_invoice_path(invoice1))
    end
  end

  it "orders incomplete invoices by oldest to newest" do
    within ".incomplete-invoices" do
      expect("#{invoice1.id}").to appear_before("#{invoice2.id}")
      expect("#{invoice2.id}").to appear_before("#{invoice4.id}")
      expect("#{invoice4.id}").to appear_before("#{invoice5.id}")
      expect("#{invoice5.id}").to appear_before("#{invoice6.id}")
    end
  end

  it "lists the names of the top 5 customers with the largest number of successful transactions" do
    within ".top-five-customers" do
      expect("Leanne Braun").to appear_before("Mariah Toy")
      expect("Mariah Toy").to appear_before("Carl Junior")
      expect("Carl Junior").to appear_before("Tony Bologna")
      expect("Tony Bologna").to appear_before("Sylvester Nader")

      expect(page).to have_content("Leanne Braun - 6 purchases")
      expect(page).to have_content("Mariah Toy - 5 purchases")
      expect(page).to have_content("Carl Junior - 4 purchases")
      expect(page).to have_content("Tony Bologna - 3 purchases")
      expect(page).to have_content("Sylvester Nader - 2 purchases")
    end
  end
end
