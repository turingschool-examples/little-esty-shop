require 'rails_helper'

RSpec.describe '/admin/merchants', type: :feature do
  before(:each) do
    @merchant_1 = Merchant.create!(name: 'Etsy', status: 0)
    @merchant_2 = Merchant.create!(name: 'Build-a-Bear', status: 0)
    @merchant_3 = Merchant.create!(name: 'Target', status: 1)
    @merchant_4 = Merchant.create!(name: 'Toys-R-Us', status: 1)
    @merchant_5 = Merchant.create!(name: 'Dicks')
    @merchant_6 = Merchant.create!(name: 'Costco')
    @item_1 = @merchant_1.items.create!(name: 'Axe', description: 'Chop stuff', unit_price: 1000)
    @item_2 = @merchant_1.items.create!(name: 'Hammer', description: 'Hit stuff', unit_price: 1500)
    @item_3 = @merchant_1.items.create!(name: 'Drill', description: 'Drill stuff', unit_price: 5000)
    @item_4 = @merchant_2.items.create!(name: 'Wrench', description: 'Turn stuff', unit_price: 900)
    @item_5 = @merchant_2.items.create!(name: 'Flashlight', description: 'Shine stuff', unit_price: 1550)
    @item_6 = @merchant_3.items.create!(name: 'Shovel', description: 'Dig stuff', unit_price: 2550)
    @item_7 = @merchant_4.items.create!(name: 'Helmet', description: 'Head stuff', unit_price: 3550)
    @item_8 = @merchant_5.items.create!(name: 'Nail Gun', description: 'Nail stuff', unit_price: 4550)
    @item_9 = @merchant_6.items.create!(name: 'Saw', description: 'Saw stuff', unit_price: 5550)
    @customer_1 = Customer.create!(first_name: 'Jon', last_name: 'Jones')
    @customer_2 = Customer.create!(first_name: 'Jan', last_name: 'Jones')
    @customer_3 = Customer.create!(first_name: 'Jin', last_name: 'Jones')
    @customer_4 = Customer.create!(first_name: 'Joon', last_name: 'Jones')
    @customer_5 = Customer.create!(first_name: 'Joc', last_name: 'Jones')
    @customer_6 = Customer.create!(first_name: 'JakJak', last_name: 'Jones')
    @invoice_1 = @customer_1.invoices.create!(status: 1, created_at: '2012-03-25 09:54:09 UTC')
    @transaction_1 = @invoice_1.transactions.create!(credit_card_number: 4654405418249632, credit_card_expiration_date: '2012-03-27', result: 1)
    @invoice_2 = @customer_2.invoices.create!(status: 1, created_at: '2012-03-26')
    @transaction_2 = @invoice_2.transactions.create!(credit_card_number: 4654405418249632, credit_card_expiration_date: '2012-03-27', result: 1)
    @invoice_3 = @customer_2.invoices.create!(status: 1, created_at: '2012-03-27')
    @transaction_3 = @invoice_3.transactions.create!(credit_card_number: 4654405418249632, credit_card_expiration_date: '2012-03-27', result: 1)
    @invoice_4 = @customer_3.invoices.create!(status: 1, created_at: '2012-03-28')
    @transaction_4 = @invoice_4.transactions.create!(credit_card_number: 4654405418249632, credit_card_expiration_date: '2012-03-27', result: 1)
    @invoice_5 = @customer_3.invoices.create!(status: 1, created_at: '2012-03-29')
    @transaction_5 = @invoice_5.transactions.create!(credit_card_number: 4654405418249632, credit_card_expiration_date: '2012-03-27', result: 1)
    @invoice_6 = @customer_6.invoices.create!(status: 1, created_at: '2012-03-30')
    @transaction_6 = @invoice_6.transactions.create!(credit_card_number: 4654405418249632, credit_card_expiration_date: '2012-03-27', result: 1)
    @invoice_7 = @customer_5.invoices.create!(status: 1, created_at: '2012-03-31')
    @transaction_7 = @invoice_7.transactions.create!(credit_card_number: 4654405418249632, credit_card_expiration_date: '2012-03-27', result: 1)
    @invoice_8 = @customer_4.invoices.create!(status: 1, created_at: '2012-04-01')
    @transaction_8 = @invoice_8.transactions.create!(credit_card_number: 4654405418249632, credit_card_expiration_date: '2012-03-27', result: 1)
    @invoice_9 = @customer_4.invoices.create!(status: 1, created_at:'2012-04-02')
    @transaction_9 = @invoice_9.transactions.create!(credit_card_number: 4654405418249632, credit_card_expiration_date: '2012-03-27', result: 1)
    @invoice_10 = @customer_5.invoices.create!(status: 1, created_at: '2012-04-03')
    @transaction_10 = @invoice_10.transactions.create!(credit_card_number: 4654405418249632, credit_card_expiration_date: '2012-03-27', result: 1)
    @invoice_11 = @customer_6.invoices.create!(status: 1, created_at: '2012-04-04')
    @transaction_11 = @invoice_11.transactions.create!(credit_card_number: 4654405418249632, credit_card_expiration_date: '2012-03-27', result: 1)
    @invoice_12 = @customer_6.invoices.create!(status: 1, created_at: '2012-04-04')
    @transaction_12 = @invoice_12.transactions.create!(credit_card_number: 4654405418249632, credit_card_expiration_date: '2012-03-27', result: 1)
    @invoice_13 = @customer_6.invoices.create!(status: 1, created_at: '2012-04-04')
    @transaction_13 = @invoice_13.transactions.create!(credit_card_number: 4654405418249632, credit_card_expiration_date: '2012-03-27', result: 1)
    @invoice_14 = @customer_6.invoices.create!(status: 1, created_at: '2012-04-04')
    @transaction_14 = @invoice_14.transactions.create!(credit_card_number: 4654405418249632, credit_card_expiration_date: '2012-03-27', result: 1)
    @invoice_15 = @customer_6.invoices.create!(status: 1, created_at: '2012-04-04')
    @transaction_15 = @invoice_15.transactions.create!(credit_card_number: 4654405418249632, credit_card_expiration_date: '2012-03-27', result: 1)
    @invoice_16 = @customer_6.invoices.create!(status: 1, created_at: '2012-04-04')
    @transaction_16 = @invoice_16.transactions.create!(credit_card_number: 4654405418249632, credit_card_expiration_date: '2012-03-27', result: 1)
    @invoice_17 = @customer_6.invoices.create!(status: 1, created_at: '2012-04-04')
    @transaction_17 = @invoice_17.transactions.create!(credit_card_number: 4654405418249632, credit_card_expiration_date: '2012-03-27', result: 1)
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
    InvoiceItem.create!(item_id: @item_6.id, invoice_id: @invoice_12.id) 
    InvoiceItem.create!(item_id: @item_7.id, invoice_id: @invoice_13.id) 
    InvoiceItem.create!(item_id: @item_8.id, invoice_id: @invoice_14.id) 
    InvoiceItem.create!(item_id: @item_9.id, invoice_id: @invoice_15.id) 
    InvoiceItem.create!(item_id: @item_9.id, invoice_id: @invoice_16.id) 
    InvoiceItem.create!(item_id: @item_9.id, invoice_id: @invoice_17.id)
     
    visit "/admin/merchants"
  end

  it 'I see the name of each merchant in the system' do
    expect(page).to have_content(@merchant_1.name)
    expect(page).to have_content(@merchant_2.name)    
  end

  it 'I can click on the name of the merchant' do
    expect(page).to have_link(@merchant_1.name)
  end


  it 'has merchant status and update buttons' do
    within "##{@merchant_1.id}" do
      expect(page).to have_content(@merchant_1.status)
      expect(page).to have_button('Enable')
      expect(page).to have_button('Disable')
    end
    within "##{@merchant_2.id}" do
    expect(page).to have_content(@merchant_2.status)
      expect(page).to have_button('Enable')
      expect(page).to have_button('Disable')
    end
  end

  it 'can update status with buttons' do 
    within "##{@merchant_1.id}" do
      click_button "Enable"
      @merchant_1.reload
      expect(@merchant_1.status).to eq("enabled")
      click_button "Disable"
      @merchant_1.reload
      expect(@merchant_1.status).to eq("disabled")
      expect(page).to have_current_path("/admin/merchants")
    end
  end

  it 'has Enabled and Disabled sections with appropriate merchants' do 
    expect(page).to have_content("Enabled Merchants")
    expect(page).to have_content("Disabled Merchants")
    within "#Enabled" do
      expect(page).to have_content(@merchant_3.name)  
      expect(page).to have_content(@merchant_4.name)  
    end
    within "#Disabled" do
      expect(page).to have_content(@merchant_1.name)  
      expect(page).to have_content(@merchant_2.name)  
    end
  end

  it 'has link for new merchant' do
    expect(page).to have_link("New Merchant")
    click_on "New Merchant"
    expect(current_path).to eq("/admin/merchants/new")
  end

  it 'has top 5 merchants' do
    expect(page).to have_content("Top 5 Merchants by Revenue")
    within '#top_merchants' do
      expect(page).to have_content("#{@merchant_1.name}, 30000")
      expect(page).to have_content("#{@merchant_6.name}, 16650")
      expect(page).to have_content("#{@merchant_2.name}, 12900")
      expect(page).to have_content("#{@merchant_5.name}, 4550")
      expect(page).to have_content("#{@merchant_4.name}, 3550")
      expect(page).to have_no_content(@merchant_3.name)
    end
  end

  it 'I see the date with the most revenue for each merchant' do
    within "#top_merchants" do
      expect(page).to have_content("Top selling date for #{@merchant_1.name} was 2012-03-30")
      expect(page).to have_content("Top selling date for #{@merchant_6.name} was 2012-04-04")
    end
  end
end

