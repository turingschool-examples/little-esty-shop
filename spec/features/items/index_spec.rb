require 'rails_helper'

RSpec.describe 'merchant items index' do
  before(:each) do
    @merchant_1 = Merchant.create!(name: 'Etsy')
    @merchant_2 = Merchant.create!(name: 'Build-a-Bear')
    @item_1 = @merchant_1.items.create!(name: 'Axe', description: 'Chop stuff', unit_price: 1000)
    @item_2 = @merchant_1.items.create!(name: 'Hammer', description: 'Hit stuff', unit_price: 1500)
    @item_3 = @merchant_1.items.create!(name: 'Drill', description: 'Drill stuff', unit_price: 5000)
    @item_4 = @merchant_2.items.create!(name: 'Wrench', description: 'Turn stuff', unit_price: 900)
    @item_5 = @merchant_2.items.create!(name: 'Nail', description: 'Nail stuff', unit_price: 50)
    @customer_1 = Customer.create!(first_name: 'Jon', last_name: 'Jones')
    @customer_2 = Customer.create!(first_name: 'Jan', last_name: 'Jones')
    @customer_3 = Customer.create!(first_name: 'Jin', last_name: 'Jones')
    @customer_4 = Customer.create!(first_name: 'Joon', last_name: 'Jones')
    @customer_5 = Customer.create!(first_name: 'Joc', last_name: 'Jones')
    @customer_6 = Customer.create!(first_name: 'JakJak', last_name: 'Jones')
    @invoice_1 = @customer_1.invoices.create!(status: 'completed')
    @transaction_1 = @invoice_1.transactions.create!(credit_card_number: '4654405418249632', credit_card_expiration_date: '2012-03-27', result: 'success')
    @invoice_2 = @customer_2.invoices.create!(status: 'completed')
    @transaction_2 = @invoice_2.transactions.create!(credit_card_number: '4654405418249632', credit_card_expiration_date: '2012-03-27', result: 'success')
    @invoice_3 = @customer_2.invoices.create!(status: 'completed')
    @transaction_3 = @invoice_3.transactions.create!(credit_card_number: '4654405418249632', credit_card_expiration_date: '2012-03-27', result: 'success')
    @invoice_4 = @customer_3.invoices.create!(status: 'completed')
    @transaction_4 = @invoice_4.transactions.create!(credit_card_number: '4654405418249632', credit_card_expiration_date: '2012-03-27', result: 'success')
    @invoice_5 = @customer_3.invoices.create!(status: 'completed')
    @transaction_5 = @invoice_5.transactions.create!(credit_card_number: '4654405418249632', credit_card_expiration_date: '2012-03-27', result: 'success')
    @invoice_6 = @customer_6.invoices.create!(status: 'completed')
    @transaction_6 = @invoice_6.transactions.create!(credit_card_number: '4654405418249632', credit_card_expiration_date: '2012-03-27', result: 'success')
    @invoice_7 = @customer_5.invoices.create!(status: 'completed')
    @transaction_7 = @invoice_7.transactions.create!(credit_card_number: '4654405418249632', credit_card_expiration_date: '2012-03-27', result: 'success')
    @invoice_8 = @customer_4.invoices.create!(status: 'completed')
    @transaction_8 = @invoice_8.transactions.create!(credit_card_number: '4654405418249632', credit_card_expiration_date: '2012-03-27', result: 'success')
    @invoice_9 = @customer_4.invoices.create!(status: 'completed')
    @transaction_9 = @invoice_9.transactions.create!(credit_card_number: '4654405418249632', credit_card_expiration_date: '2012-03-27', result: 'success')
    @invoice_10 = @customer_5.invoices.create!(status: 'completed')
    @transaction_10 = @invoice_10.transactions.create!(credit_card_number: '4654405418249632', credit_card_expiration_date: '2012-03-27', result: 'success')
    @invoice_11 = @customer_6.invoices.create!(status: 'completed')
    @transaction_11 = @invoice_11.transactions.create!(credit_card_number: '4654405418249632', credit_card_expiration_date: '2012-03-27', result: 'success')
    InvoiceItem.create!(item_id: @item_1.id, invoice_id: @invoice_1.id) 
    InvoiceItem.create!(item_id: @item_1.id, invoice_id: @invoice_2.id) 
    InvoiceItem.create!(item_id: @item_2.id, invoice_id: @invoice_3.id) 
    InvoiceItem.create!(item_id: @item_2.id, invoice_id: @invoice_4.id) 
    InvoiceItem.create!(item_id: @item_3.id, invoice_id: @invoice_5.id) 
    InvoiceItem.create!(item_id: @item_3.id, invoice_id: @invoice_6.id) 
    InvoiceItem.create!(item_id: @item_4.id, invoice_id: @invoice_7.id) 
    InvoiceItem.create!(item_id: @item_4.id, invoice_id: @invoice_8.id) 
    InvoiceItem.create!(item_id: @item_5.id, invoice_id: @invoice_9.id) 
    InvoiceItem.create!(item_id: @item_5.id, invoice_id: @invoice_10.id) 
    InvoiceItem.create!(item_id: @item_5.id, invoice_id: @invoice_11.id) 
    InvoiceItem.create!(item_id: @item_1.id, invoice_id: @invoice_11.id) 
    InvoiceItem.create!(item_id: @item_1.id, invoice_id: @invoice_10.id) 
    InvoiceItem.create!(item_id: @item_2.id, invoice_id: @invoice_9.id) 
    InvoiceItem.create!(item_id: @item_2.id, invoice_id: @invoice_8.id) 
    InvoiceItem.create!(item_id: @item_3.id, invoice_id: @invoice_7.id) 
    InvoiceItem.create!(item_id: @item_3.id, invoice_id: @invoice_6.id) 
    InvoiceItem.create!(item_id: @item_4.id, invoice_id: @invoice_5.id) 
    InvoiceItem.create!(item_id: @item_4.id, invoice_id: @invoice_4.id) 
    InvoiceItem.create!(item_id: @item_5.id, invoice_id: @invoice_3.id) 
    InvoiceItem.create!(item_id: @item_5.id, invoice_id: @invoice_2.id) 
    InvoiceItem.create!(item_id: @item_5.id, invoice_id: @invoice_1.id) 
  end

  it 'lists correct merchant items' do
    visit "/merchants/#{@merchant_1.id}/items"
    expect(page).to have_content(@item_1.name)
    expect(page).to have_content(@item_2.name)
    expect(page).to have_content(@item_3.name)
    expect(page).to have_no_content(@item_4.name)
    expect(page).to have_no_content(@item_5.name)
    visit "/merchants/#{@merchant_2.id}/items"
    expect(page).to have_no_content(@item_1.name)
    expect(page).to have_no_content(@item_2.name)
    expect(page).to have_no_content(@item_3.name)
    expect(page).to have_content(@item_4.name)
    expect(page).to have_content(@item_5.name)
  end

  it 'has a button to disable or enable item' do
    visit "/merchants/#{@merchant_1.id}/items"

    expect(page).to have_button("Disable")
    expect(page).to have_button("Enable")
  end

  it 'when I click this item I am redirected back to the items index and can see the the items status has changed' do
    visit "/merchants/#{@merchant_1.id}/items"
    within "##{@item_1.id}" do
      expect(page).to have_no_content("enabled")
      expect(page).to have_no_content("disabled")
      click_on('Enable')
      expect(page).to have_content("enabled")
      expect(page).to have_no_content("disabled")
      click_on('Disable')
      expect(page).to have_content("disabled")
      expect(page).to have_no_content("enabled")
      expect(page).to have_current_path("/merchants/#{@merchant_1.id}/items/")
    end
  
  end
end