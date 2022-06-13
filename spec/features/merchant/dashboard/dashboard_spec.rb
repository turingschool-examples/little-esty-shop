require 'rails_helper'

RSpec.describe 'The Merchant Dashboard' do
  before :each do
    @katz = Merchant.create!(name: 'Katz Kreations')
    @mrpickles = Customer.create!(first_name: 'Mr', last_name: 'Pickles')
    @sashimi = Customer.create!(first_name: 'Sashimi', last_name: 'Kity')
    @invoice1 = Invoice.create!(status: 0, customer_id: @mrpickles.id)
    @invoice2 = Invoice.create!(status: 0, customer_id: @mrpickles.id)
    @invoice3 = Invoice.create!(status: 0, customer_id: @mrpickles.id)
    @item1 = Item.create!(name: 'food', description: 'delicious', unit_price: '2000', merchant_id: @katz.id)
    @item2 = Item.create!(name: 'toy', description: 'fun', unit_price: '5000', merchant_id: @katz.id)
    @item3 = Item.create!(name: 'cat nip', description: 'drugs', unit_price: '30000', merchant_id: @katz.id)
    @invoice_item1 = InvoiceItem.create!(item_id: @item1.id, invoice_id: @invoice1.id, quantity: 2, unit_price: 100,
                                         status: 1)
    @invoice_item2 = InvoiceItem.create!(item_id: @item2.id, invoice_id: @invoice1.id, quantity: 2, unit_price: 100,
                                         status: 2)
    @invoice_item3 = InvoiceItem.create!(item_id: @item3.id, invoice_id: @invoice3.id, quantity: 4, unit_price: 100,
                                         status: 1)
  end

  it "displays the merchant's name" do
    visit merchant_dashboard_index_path(@katz)
    expect(page).to have_content(@katz.name)
  end

  it 'has links to merchant items and invoices' do
    visit merchant_dashboard_index_path(@katz)
    click_on "#{@katz.name}'s items"
    expect(current_path).to eq("/merchants/#{@katz.id}/items")
    visit merchant_dashboard_index_path(@katz)
    click_on "#{@katz.name}'s invoices"
    expect(current_path).to eq("/merchants/#{@katz.id}/invoices")
  end

  it 'has a section not shipped with names of items that are oredered but not shipped' do
    visit merchant_dashboard_index_path(@katz)
    within '#not_shipped-0' do
      expect(page).to have_content(@item1.name)
      expect(page).to_not have_content(@item2.name)
    end
  end

  it 'not shipped has the item ids of the invoices that ordered the items' do
    visit merchant_dashboard_index_path(@katz)
    within '#not_shipped-0' do
      expect(page).to have_content(@invoice1.id)
      expect(page).to_not have_content(@invoice2.id)
    end
  end

  it 'in not shipped the item ids are links to merchant_invoices' do
    visit merchant_dashboard_index_path(@katz)
    within '#not_shipped-0' do
      click_on "#{@invoice1.id}"
      expect(current_path).to eq("/merchants/#{@katz.id}/invoices")
    end
  end

  it 'in not shipped the invoice dates are present' do
    visit merchant_dashboard_index_path(@katz)
    within '#not_shipped-0' do
      expect(page).to have_content(@invoice_item1.format_created_at(@invoice_item1.created_at))
    end
  end

  it 'in not shipped the invoice ids apear from least to most recent' do
    visit merchant_dashboard_index_path(@katz)

    within '#not_shipped-0' do
      expect(page).to have_content("Invoice ID: #{@invoice1.id}")
    end
    within '#not_shipped-1' do
      expect(page).to have_content("Invoice ID: #{@invoice3.id}")
    end
  end

  it 'displays the top_five_customers names and number of orders' do
    @customer1 = Customer.create!(first_name: 'Fred', last_name: 'Dunce')
    @customer2 = Customer.create!(first_name: 'Sal', last_name: 'Dali')
    @customer3 = Customer.create!(first_name: 'Earny', last_name: 'Hemi')
    @customer4 = Customer.create!(first_name: 'Jack', last_name: 'Wack')
    @customer5 = Customer.create!(first_name: 'Mack', last_name: 'Aurther')
    @customer6 = Customer.create!(first_name: 'Charly', last_name: 'Dicky')

    @invoice1 = Invoice.create!(status: 0, customer_id: @customer1.id)
    @invoice2 = Invoice.create!(status: 0, customer_id: @customer1.id)
    @invoice3 = Invoice.create!(status: 0, customer_id: @customer2.id)
    @invoice4 = Invoice.create!(status: 0, customer_id: @customer3.id)
    @invoice5 = Invoice.create!(status: 0, customer_id: @customer4.id)
    @invoice6 = Invoice.create!(status: 0, customer_id: @customer5.id)
    @invoice7 = Invoice.create!(status: 0, customer_id: @customer6.id)

    @item1 = Item.create!(name: 'food', description: 'delicious', unit_price: '2000', merchant_id: @katz.id)
    @item2 = Item.create!(name: 'more food', description: 'even more delicious', unit_price: '3000',
                          merchant_id: @katz.id)

    @invoice_item1 = InvoiceItem.create!(item_id: @item1.id, invoice_id: @invoice1.id, quantity: 2, unit_price: 100,
                                         status: 1)
    @invoice_item2 = InvoiceItem.create!(item_id: @item2.id, invoice_id: @invoice2.id, quantity: 2, unit_price: 400,
                                         status: 0)
    @invoice_item3 = InvoiceItem.create!(item_id: @item1.id, invoice_id: @invoice3.id, quantity: 2, unit_price: 200,
                                         status: 2)
    @invoice_item4 = InvoiceItem.create!(item_id: @item2.id, invoice_id: @invoice1.id, quantity: 2, unit_price: 100,
                                         status: 2)
    @invoice_item5 = InvoiceItem.create!(item_id: @item1.id, invoice_id: @invoice4.id, quantity: 2, unit_price: 100,
                                         status: 2)
    @invoice_item6 = InvoiceItem.create!(item_id: @item2.id, invoice_id: @invoice5.id, quantity: 2, unit_price: 400,
                                         status: 2)
    @invoice_item7 = InvoiceItem.create!(item_id: @item1.id, invoice_id: @invoice6.id, quantity: 2, unit_price: 200,
                                         status: 2)
    @invoice_item8 = InvoiceItem.create!(item_id: @item2.id, invoice_id: @invoice7.id, quantity: 2, unit_price: 100,
                                         status: 2)

    @transaction1 = Transaction.create!(result: 0, invoice_id: @invoice1.id)
    @transaction2 = Transaction.create!(result: 0, invoice_id: @invoice3.id)
    @transaction3 = Transaction.create!(result: 0, invoice_id: @invoice4.id)
    @transaction4 = Transaction.create!(result: 1, invoice_id: @invoice5.id)
    @transaction5 = Transaction.create!(result: 0, invoice_id: @invoice6.id)
    @transaction6 = Transaction.create!(result: 0, invoice_id: @invoice7.id)
    @transaction7 = Transaction.create!(result: 0, invoice_id: @invoice2.id)
    visit merchant_dashboard_index_path(@katz)

    within '#stats' do
      expect(page).to have_content(@customer1.first_name)
      expect(page).to have_content(@customer1.last_name)
      expect(page).to have_content(@customer2.first_name)
      expect(page).to have_content(@customer2.last_name)
      expect(page).to have_content(@katz.top_five_customers.first.transaction_count)
      expect(page).to have_content(@katz.top_five_customers.last.transaction_count)
    end
  end
end
