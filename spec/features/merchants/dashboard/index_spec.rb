require 'rails_helper'

RSpec.describe 'Merchant Dashboard' do
  before(:each) do
    @merchant = Merchant.create!(name: "Parker")
    @merchant2 = Merchant.create!(name: "Joel")

    @item = @merchant.items.create!(name: "Small Thing", description: "Its a thing that is small.", unit_price: 400)
    @item2 = @merchant.items.create!(name: "Large Thing", description: "Its a thing that is large.", unit_price: 800)
    @item3 = @merchant.items.create!(name: "Medium Thing", description: "Its a thing that is medium.", unit_price: 800)
    @item4 = @merchant.items.create!(name: "smallish Thing", description: "Its a thing that is smallish.", unit_price: 800)
    @item5 = @merchant.items.create!(name: "cute Thing", description: "Its a thing that is cute.", unit_price: 800)
    # edge case
    @item6 = @merchant2.items.create!(name: "Thing that shouldn't be there", description: "Its the thing that shouldn't be there.", unit_price: 10)

    @customer_1 = Customer.create!(first_name: "Fred", last_name: "Rogers")
    @customer_2 = Customer.create!(first_name: "Big", last_name: "Bird")
    @customer_3 = Customer.create!(first_name: "Oscar", last_name: "Grouch")
    @customer_4 = Customer.create!(first_name: "Miss", last_name: "Piggy")
    @customer_5 = Customer.create!(first_name: "Kermit", last_name: "Frog")
    @customer_6 = Customer.create!(first_name: "Fred", last_name: "Flinstone")

    @invoice_1 = @customer_1.invoices.create!(status: "in progress")
    @transaction_1  = @invoice_1.transactions.create!(credit_card_number: "1234 2345 3456 4567", credit_card_expiration_date: Date.new, result: "success")
    @transaction_2  = @invoice_1.transactions.create!(credit_card_number: "1234 2345 3456 4567", credit_card_expiration_date: Date.new, result: "success")
    @transaction_3  = @invoice_1.transactions.create!(credit_card_number: "1234 2345 3456 4567", credit_card_expiration_date: Date.new, result: "success")

    @invoice_2 = @customer_2.invoices.create!(status: "in progress")
    @transaction_4  = @invoice_2.transactions.create!(credit_card_number: "1234 2345 3456 4567", credit_card_expiration_date: Date.new, result: "success")
    @transaction_5  = @invoice_2.transactions.create!(credit_card_number: "1234 2345 3456 4567", credit_card_expiration_date: Date.new, result: "success")
    @transaction_6  = @invoice_2.transactions.create!(credit_card_number: "1234 2345 3456 4567", credit_card_expiration_date: Date.new, result: "success")
    @transaction_7  = @invoice_2.transactions.create!(credit_card_number: "1234 2345 3456 4567", credit_card_expiration_date: Date.new, result: "success")
    @transaction_8  = @invoice_2.transactions.create!(credit_card_number: "1234 2345 3456 4567", credit_card_expiration_date: Date.new, result: "success")

    @invoice_3 = @customer_3.invoices.create!(status: "in progress")
    @transaction_9  = @invoice_3.transactions.create!(credit_card_number: "1234 2345 3456 4567", credit_card_expiration_date: Date.new, result: "success")

    @invoice_4 = @customer_4.invoices.create!(status: "in progress")
    @transaction_10  = @invoice_4.transactions.create!(credit_card_number: "1234 2345 3456 4567", credit_card_expiration_date: Date.new, result: "success")
    @transaction_11  = @invoice_4.transactions.create!(credit_card_number: "1234 2345 3456 4567", credit_card_expiration_date: Date.new, result: "success")
    @transaction_12  = @invoice_4.transactions.create!(credit_card_number: "1234 2345 3456 4567", credit_card_expiration_date: Date.new, result: "success")
    @transaction_13  = @invoice_4.transactions.create!(credit_card_number: "1234 2345 3456 4567", credit_card_expiration_date: Date.new, result: "success")

    @invoice_5 = @customer_5.invoices.create!(status: "in progress")
    @transaction_14  = @invoice_5.transactions.create!(credit_card_number: "1234 2345 3456 4567", credit_card_expiration_date: Date.new, result: "success")
    @transaction_15  = @invoice_5.transactions.create!(credit_card_number: "1234 2345 3456 4567", credit_card_expiration_date: Date.new, result: "success")
    @transaction_16  = @invoice_5.transactions.create!(credit_card_number: "1234 2345 3456 4567", credit_card_expiration_date: Date.new, result: "failed")

    @invoice_item_1 = InvoiceItem.create!(invoice: @invoice_1, item: @item, quantity: 20, unit_price: 400, status: "pending")
    @invoice_item_2 = InvoiceItem.create!(invoice: @invoice_2, item: @item2, quantity: 20, unit_price: 400, status: "pending")
    @invoice_item_3 = InvoiceItem.create!(invoice: @invoice_3, item: @item3, quantity: 20, unit_price: 400, status: "packaged")
    @invoice_item_4 = InvoiceItem.create!(invoice: @invoice_4, item: @item4, quantity: 20, unit_price: 400, status: "packaged")
    @invoice_item_5 = InvoiceItem.create!(invoice: @invoice_5, item: @item5, quantity: 20, unit_price: 400, status: "packaged")

    visit "/merchants/#{@merchant.id}/dashboard"
  end

  it 'shows the merchants name' do
    expect(page).to have_content("Parker")
  end

  it 'links to merchant items index' do
    click_link("Items")
    expect(current_path).to eq("/merchants/#{@merchant.id}/items")
  end

  it 'links to merchant invoices index' do
    click_link("Invoices")
    expect(current_path).to eq("/merchants/#{@merchant.id}/invoices")
  end

  it 'shows the names of the top 5 customers' do
    expect(@customer_2.first_name).to appear_before(@customer_4.first_name)
    expect(@customer_4.first_name).to appear_before(@customer_1.first_name)
    expect(@customer_1.first_name).to appear_before(@customer_5.first_name)
    expect(@customer_5.first_name).to appear_before(@customer_3.first_name)

    expect(page).to_not have_content(@customer_6.last_name)
  end

  it 'shows the number of successful transactions they have conducted with the merchant' do
    within "#customer-#{@customer_2.first_name}" do
      expect(page).to have_content(5)
    end

    within "#customer-#{@customer_4.first_name}" do
      expect(page).to have_content(4)
    end

    within "#customer-#{@customer_1.first_name}" do
      expect(page).to have_content(3)
    end

    within "#customer-#{@customer_5.first_name}" do
      expect(page).to have_content(3)
    end

    within "#customer-#{@customer_3.first_name}" do
      expect(page).to have_content(1)
    end
  end

  it 'has a section for Items Ready to Ship' do
    expect(page).to have_content("Items Ready To Ship")
  end

  it 'lists the items that have been ordered but not shipped with the invoice id, as a link, next to them' do
    within "#merchant-items" do
      expect(page).to have_content(@item3.name)
      expect(page).to have_content(@item3.invoices.first.id)

      expect(page).to have_content(@item4.name)
      expect(page).to have_content(@item4.invoices.first.id)

      expect(page).to have_content(@item5.name)
      expect(page).to have_content(@item5.invoices.first.id)
      # edge cases
      expect(page).to_not have_content(@item.name)
      expect(page).to_not have_content(@item2.name)
      expect(page).to_not have_content(@item6.name)
    end
  end


end
