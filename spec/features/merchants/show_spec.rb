require 'rails_helper'

describe 'merchant dashboard page' do
  before do
    @merchant_1 = Merchant.create!(
      name: "Store Store",
      created_at: Date.current,
      updated_at: Date.current
    )
    @merchant_2 = Merchant.create!(
      name: "Erots",
      created_at: Date.current,
      updated_at: Date.current
    )

    @cup = @merchant_1.items.create!(
      name: "Cup",
      description: "What the **** is this thing?",
      unit_price: 10000,
      created_at: Date.current,
      updated_at: Date.current
    )
    @soccer = @merchant_1.items.create!(
      name: "Soccer Ball",
      description: "A ball of pure soccer.",
      unit_price: 32000,
      created_at: Date.current,
      updated_at: Date.current
    )

    @beer = @merchant_2.items.create!(
      name: "Beer",
      description: "Happiness <3",
      unit_price: 100,
      created_at: Date.current,
      updated_at: Date.current
    )

    @customer_1 = Customer.create!(
      first_name: "Malcolm",
      last_name: "Jordan",
      created_at: Date.current,
      updated_at: Date.current
    )
    @customer_2 = Customer.create!(
      first_name: "Jimmy",
      last_name: "Felony",
      created_at: Date.current,
      updated_at: Date.current
    )

    @invoice_1 = @customer_1.invoices.create!(
      status: 0,
      created_at: Date.current,
      updated_at: Date.current
    )
    @invoice_2 = @customer_1.invoices.create!(
      status: 1,
      created_at: Date.current,
      updated_at: Date.current
    )
    @invoice_3 = @customer_2.invoices.create!(
      status: 0,
      created_at: Date.current,
      updated_at: Date.current
    )

    @invoice_item_1 = InvoiceItem.create!(
      item_id: @soccer.id,
      invoice_id: @invoice_1.id,
      quantity: 2,
      unit_price: @soccer.unit_price * 2,
      status: 0,
      created_at: Date.current,
      updated_at: Date.current
    )
    @invoice_item_2 = InvoiceItem.create!(
      item_id: @cup.id,
      invoice_id: @invoice_1.id,
      quantity: 4,
      unit_price: @cup.unit_price * 4,
      status: 0,
      created_at: Date.current,
      updated_at: Date.current
    )
    @invoice_item_3 = InvoiceItem.create!(
      item_id: @soccer.id,
      invoice_id: @invoice_2.id,
      quantity: 4,
      unit_price: @soccer.unit_price * 4,
      status: 2,
      created_at: Date.current,
      updated_at: Date.current
    )

    @invoice_item_4 = InvoiceItem.create!(
      item_id: @beer.id,
      invoice_id: @invoice_3.id,
      quantity: 2,
      unit_price: @beer.unit_price * 2,
      status: 0,
      created_at: Date.current,
      updated_at: Date.current
    )

    visit "/merchants/#{@merchant_1.id}/dashboard"
  end

  it 'displays the merchants name' do
    expect(page).to have_content("Store Store")
  end

  it 'has links to the merchant item index' do
    click_link("Store Store's Items")
    expect(current_path).to eq("/merchants/#{@merchant_1.id}/items")

    expect(page).to have_content("Cup")
    expect(page).to have_content("Soccer Ball")
    expect(page).not_to have_content("Beer")
  end

  it 'has links to the merchant invoice index' do
    click_link("Invoices")
    expect(current_path).to eq("/merchants/#{@merchant_1.id}/invoices")
    # save_and_open_page
    expect(page).to have_content("Invoice ##{@invoice_1.id}")
    expect(page).to have_content("Invoice ##{@invoice_2.id}")
    expect(page).not_to have_content("Invoice ##{@invoice_3.id}")
  end

  it "finds shows top_5_customers names and displays the number of successful transactions for each" do
    merch_1 = Merchant.create!(name: "Two-Legs Fashion")

    item_1 = merch_1.items.create!(name: "Two-Leg Pantaloons", description: "pants built for people with two legs", unit_price: 5000)
    item_2 = merch_1.items.create!(name: "Two-Leg Shorts", description: "shorts built for people with two legs", unit_price: 3000)
    item_3 = merch_1.items.create!(name: "Hat", description: "hat built for people with two legs and one head", unit_price: 6000)

    cust_1 = Customer.create!(first_name: "Debbie", last_name: "Twolegs")
    cust_2 = Customer.create!(first_name: "Tommy", last_name: "Doubleleg")
    cust_3 = Customer.create!(first_name: "Brian", last_name: "Twinlegs")
    cust_4 = Customer.create!(first_name: "Jared", last_name: "Goffleg")
    cust_5 = Customer.create!(first_name: "Pistol", last_name: "Pete")
    cust_6 = Customer.create!(first_name: "Bronson", last_name: "Shmonson")

    invoice_1 = cust_1.invoices.create!(status: 1)
    invoice_2 = cust_1.invoices.create!(status: 1)
    invoice_3 = cust_1.invoices.create!(status: 1)
    invoice_4 = cust_2.invoices.create!(status: 1)
    invoice_5 = cust_2.invoices.create!(status: 1)
    invoice_6 = cust_2.invoices.create!(status: 1)
    invoice_7 = cust_3.invoices.create!(status: 1)
    invoice_8 = cust_3.invoices.create!(status: 1)
    invoice_9 = cust_4.invoices.create!(status: 1)
    invoice_10 = cust_4.invoices.create!(status: 1)
    invoice_11 = cust_5.invoices.create!(status: 1)
    invoice_12 = cust_5.invoices.create!(status: 1)
    invoice_13 = cust_6.invoices.create!(status: 1)

    ii_1 = InvoiceItem.create!(item_id: item_1.id, invoice_id: invoice_1.id, quantity: 1, unit_price: item_1.unit_price, status: 2)
    ii_2 = InvoiceItem.create!(item_id: item_1.id, invoice_id: invoice_2.id, quantity: 1, unit_price: item_1.unit_price, status: 2)
    ii_3 = InvoiceItem.create!(item_id: item_1.id, invoice_id: invoice_3.id, quantity: 1, unit_price: item_1.unit_price, status: 2)
    ii_4 = InvoiceItem.create!(item_id: item_1.id, invoice_id: invoice_4.id, quantity: 1, unit_price: item_1.unit_price, status: 2)
    ii_5 = InvoiceItem.create!(item_id: item_1.id, invoice_id: invoice_5.id, quantity: 1, unit_price: item_1.unit_price, status: 2)
    ii_6 = InvoiceItem.create!(item_id: item_1.id, invoice_id: invoice_6.id, quantity: 1, unit_price: item_1.unit_price, status: 2)
    ii_7 = InvoiceItem.create!(item_id: item_1.id, invoice_id: invoice_7.id, quantity: 1, unit_price: item_1.unit_price, status: 2)
    ii_8 = InvoiceItem.create!(item_id: item_1.id, invoice_id: invoice_8.id, quantity: 1, unit_price: item_1.unit_price, status: 2)
    ii_9 = InvoiceItem.create!(item_id: item_1.id, invoice_id: invoice_9.id, quantity: 1, unit_price: item_1.unit_price, status: 2)
    ii_10 = InvoiceItem.create!(item_id: item_1.id, invoice_id: invoice_10.id, quantity: 1, unit_price: item_1.unit_price, status: 2)
    ii_11 = InvoiceItem.create!(item_id: item_1.id, invoice_id: invoice_11.id, quantity: 1, unit_price: item_1.unit_price, status: 2)
    ii_12 = InvoiceItem.create!(item_id: item_1.id, invoice_id: invoice_12.id, quantity: 1, unit_price: item_1.unit_price, status: 2)
    ii_13 = InvoiceItem.create!(item_id: item_1.id, invoice_id: invoice_13.id, quantity: 1, unit_price: item_1.unit_price, status: 2)

    transaction_1 = invoice_1.transactions.create!(credit_card_number: 4039485738495837, result: "success")
    transaction_2 = invoice_2.transactions.create!(credit_card_number: 4039485738495837, result: "success")
    transaction_3 = invoice_3.transactions.create!(credit_card_number: 4039485738495837, result: "success")
    transaction_4 = invoice_4.transactions.create!(credit_card_number: 4847583748374837, result: "success")
    transaction_5 = invoice_5.transactions.create!(credit_card_number: 4847583748374837, result: "success")
    transaction_6 = invoice_6.transactions.create!(credit_card_number: 4847583748374837, result: "success")
    transaction_7 = invoice_7.transactions.create!(credit_card_number: 4364756374652636, result: "success")
    transaction_8 = invoice_8.transactions.create!(credit_card_number: 4364756374652636, result: "success")
    transaction_9 = invoice_9.transactions.create!(credit_card_number: 4928294837461125, result: "success")
    transaction_10 = invoice_10.transactions.create!(credit_card_number: 4928294837461125, result: "success")
    transaction_11 = invoice_11.transactions.create!(credit_card_number: 4738473664751832, result: "success")
    transaction_12 = invoice_12.transactions.create!(credit_card_number: 4738473664751832, result: "success")
    transaction_13 = invoice_13.transactions.create!(credit_card_number: 4023948573948293, result: "success")

    visit "/merchants/#{merch_1.id}/dashboard"
    # save_and_open_page
    expect("Name: Debbie Twolegs").to appear_before("Name: Tommy Doubleleg")
    expect("Name: Tommy Doubleleg").to appear_before("Name: Brian Twinlegs")
    expect("Name: Brian Twinlegs").to appear_before("Name: Jared Goffleg")
    expect("Name: Jared Goffleg").to appear_before("Name: Pistol Pete")

    within "##{cust_1.id}" do
      expect(page).to have_content("Successful Transactions: 9")
    end
    within "##{cust_3.id}" do
      expect(page).to have_content("Successful Transactions: 4")
    end
  end
end
