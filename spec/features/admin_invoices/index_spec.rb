require 'rails_helper'

RSpec.describe 'Admin Invoice Index Page' do
  before :each do
    @merchant_1 = Merchant.create!(name: 'Lydia Rodarte-Quayle')
    @item_1 = Item.create!(name: 'P2P', description: 'secret...', unit_price: 1000, merchant_id: @merchant_1.id)
    @item_2 = Item.create!(name: '10 Gallon Drum', description: 'for storage', unit_price: 100, merchant_id: @merchant_1.id)
    @item_3 = Item.create!(name: 'Dolley', description: 'for transportation', unit_price: 10, merchant_id: @merchant_1.id)

    @customer_1 = Customer.create!(first_name: 'Tuco', last_name: 'Salamanca')
    @customer_1.invoices.create!(status: 1)
    InvoiceItem.create!(invoice: @customer_1.invoices[0], item: @item_1, quantity: 1, unit_price: @item_1.unit_price, status: 1)
    @customer_1.invoices[0].transactions.create!(credit_card_number: '1234', credit_card_expiration_date: '', result: 0)
    @customer_1.invoices.create!(status: 1)
    InvoiceItem.create!(invoice: @customer_1.invoices[1], item: @item_2, quantity: 1, unit_price: @item_2.unit_price, status: 1)
    @customer_1.invoices[1].transactions.create!(credit_card_number: '1234', credit_card_expiration_date: '', result: 0)

    @customer_2 = Customer.create!(first_name: 'Gustavo', last_name: 'Fring')
    @customer_2.invoices.create!(status: 1)
    InvoiceItem.create!(invoice: @customer_2.invoices[0], item: @item_1, quantity: 2, unit_price: @item_1.unit_price, status: 1)
    @customer_2.invoices[0].transactions.create!(credit_card_number: '9012', credit_card_expiration_date: '', result: 0)
    @customer_2.invoices.create!(status: 1)
    InvoiceItem.create!(invoice: @customer_2.invoices[1], item: @item_2, quantity: 4, unit_price: @item_2.unit_price, status: 2)
    @customer_2.invoices[1].transactions.create!(credit_card_number: '9012', credit_card_expiration_date: '', result: 0)
    @customer_2.invoices.create!(status: 0)
    InvoiceItem.create!(invoice: @customer_2.invoices[2], item: @item_3, quantity: 1, unit_price: @item_3.unit_price, status: 1)
    @customer_2.invoices[2].transactions.create!(credit_card_number: '9012', credit_card_expiration_date: '', result: 0)

    @merchant_2 = Merchant.create!(name: 'Peter Schuler')
    @item_4 = Item.create!(name: 'P2P', description: 'secret...', unit_price: 800, merchant_id: @merchant_2.id)
    @item_5 = Item.create!(name: '100 Gallon Drum', description: 'for storage', unit_price: 250, merchant_id: @merchant_2.id)
    @item_6 = Item.create!(name: 'Fork Lift', description: 'for transportation', unit_price: 1000, merchant_id: @merchant_2.id)

    @customer_1.invoices.create!(status: 1)
    InvoiceItem.create!(invoice: @customer_1.invoices[2], item: @item_4, quantity: 1, unit_price: @item_4.unit_price, status: 1)
    @customer_1.invoices[2].transactions.create!(credit_card_number: '1234', credit_card_expiration_date: '', result: 0)
    @customer_1.invoices.create!(status: 1)
    InvoiceItem.create!(invoice: @customer_1.invoices[3], item: @item_5, quantity: 1, unit_price: @item_5.unit_price, status: 1)
    @customer_1.invoices[3].transactions.create!(credit_card_number: '1234', credit_card_expiration_date: '', result: 0)

    @customer_2.invoices.create!(status: 1)
    InvoiceItem.create!(invoice: @customer_2.invoices[3], item: @item_4, quantity: 2, unit_price: @item_4.unit_price, status: 1)
    @customer_2.invoices[3].transactions.create!(credit_card_number: '9012', credit_card_expiration_date: '', result: 0)
    @customer_2.invoices.create!(status: 1)
    InvoiceItem.create!(invoice: @customer_2.invoices[4], item: @item_5, quantity: 4, unit_price: @item_5.unit_price, status: 2)
    @customer_2.invoices[4].transactions.create!(credit_card_number: '9012', credit_card_expiration_date: '', result: 0)
    @customer_2.invoices.create!(status: 0)
    InvoiceItem.create!(invoice: @customer_2.invoices[5], item: @item_6, quantity: 1, unit_price: @item_6.unit_price, status: 1)
    @customer_2.invoices[5].transactions.create!(credit_card_number: '9012', credit_card_expiration_date: '', result: 0)

    visit '/admin/invoices'
  end

  it 'is on the correct page' do
    expect(current_path).to eq('/admin/invoices')
    expect(page).to have_content('Welcome Admin!')
    expect(page).to have_content('Invoices Dashboard')
  end

  it 'can take the user back to the dashboard' do
    click_on 'Return to Dashboard'
    expect(current_path).to eq('/admin')
  end

  # As an admin,
    # When I visit the admin dashboard
    # Then I see a section for "Incomplete Invoices"
    # In that section I see a list of the ids of all invoices
    # That have items that have not yet been shipped
    # And each invoice id links to that invoice's admin show page
  # Next to each invoice id I see the date that the invoice was created
  # And I see the date formatted like "Monday, July 18, 2019"
  # And I see that the list is ordered from oldest to newest
  it 'can display a section for incomplete invoices ordered oldest to newest' do
    expected = Item.items_ready_to_ship_by_ordered_date
    # save_and_open_page

    expect(page).to have_content("Incomplete Invoices:")
    expect("#{expected[0].invoice_id}").to appear_before("#{expected[1].invoice_id}")
    expect("#{expected[1].invoice_id}").to appear_before("#{expected[2].invoice_id}")
    expect("#{expected[3].invoice_id}").to appear_before("#{expected[4].invoice_id}")
    expect("#{expected[4].invoice_id}").to appear_before("#{expected[5].invoice_id}")

    within "#item-table-headers" do
      expect(page).to have_content("Item")
      expect(page).to have_content("Name")
      expect(page).to have_content("Invoice#")
      expect(page).to have_content("Invoice Date")
    end

    within "#item-#{expected[0].id}_#{expected[0].invoice_id}" do
      expect(page).to have_content("1")
      expect(page).to have_content("#{expected[0].name}")
      expect(page).to have_link("#{expected[0].invoice_id}")
      expect(page).to have_content("#{expected[0].format_date(expected[0].invoiced_date)}")
    end

    within "#item-#{expected[1].id}_#{expected[1].invoice_id}" do
      expect(page).to have_content("2")
      expect(page).to have_content("#{expected[1].name}")
      expect(page).to have_link("#{expected[1].invoice_id}")
      expect(page).to have_content("#{expected[1].format_date(expected[1].invoiced_date)}")
    end

    within "#item-#{expected[2].id}_#{expected[2].invoice_id}" do
      expect(page).to have_content("3")
      expect(page).to have_content("#{expected[2].name}")
      expect(page).to have_link("#{expected[2].invoice_id}")
      expect(page).to have_content("#{expected[2].format_date(expected[1].invoiced_date)}")
    end

    within "#item-#{expected[3].id}_#{expected[3].invoice_id}" do
      expect(page).to have_content("4")
      expect(page).to have_content("#{expected[3].name}")
      expect(page).to have_link("#{expected[3].invoice_id}")
      expect(page).to have_content("#{expected[3].format_date(expected[3].invoiced_date)}")
    end

    within "#item-#{expected[4].id}_#{expected[4].invoice_id}" do
      expect(page).to have_content("5")
      expect(page).to have_content("#{expected[4].name}")
      expect(page).to have_link("#{expected[4].invoice_id}")
      expect(page).to have_content("#{expected[4].format_date(expected[4].invoiced_date)}")
    end

    within "#item-#{expected[5].id}_#{expected[5].invoice_id}" do
      expect(page).to have_content("6")
      expect(page).to have_content("#{expected[5].name}")
      expect(page).to have_link("#{expected[5].invoice_id}")
      expect(page).to have_content("#{expected[5].format_date(expected[5].invoiced_date)}")
    end
  end
end
