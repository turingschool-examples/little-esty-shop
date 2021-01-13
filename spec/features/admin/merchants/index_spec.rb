require 'rails_helper'

describe 'Admin Merchant Index' do
  before :each do
    @m1 = Merchant.create!(name: 'Merchant 1')
    @m2 = Merchant.create!(name: 'Merchant 2')
    @m3 = Merchant.create!(name: 'Merchant 3', status: 1)
    @m4 = Merchant.create!(name: 'Merchant 4')
    @m5 = Merchant.create!(name: 'Merchant 5')
    @m6 = Merchant.create!(name: 'Merchant 6')

    @c1 = Customer.create!(first_name: 'Yo', last_name: 'Yoz')
    @c2 = Customer.create!(first_name: 'Hey', last_name: 'Heyz')

    @i1 = Invoice.create!(merchant_id: @m1.id, customer_id: @c1.id, status: 2)
    @i2 = Invoice.create!(merchant_id: @m1.id, customer_id: @c1.id, status: 2)
    @i3 = Invoice.create!(merchant_id: @m1.id, customer_id: @c2.id, status: 2)
    @i4 = Invoice.create!(merchant_id: @m1.id, customer_id: @c2.id, status: 2)
    @i5 = Invoice.create!(merchant_id: @m2.id, customer_id: @c2.id, status: 2)
    @i6 = Invoice.create!(merchant_id: @m2.id, customer_id: @c2.id, status: 2)
    @i7 = Invoice.create!(merchant_id: @m3.id, customer_id: @c1.id, status: 2)
    @i8 = Invoice.create!(merchant_id: @m3.id, customer_id: @c1.id, status: 2)
    @i9 = Invoice.create!(merchant_id: @m3.id, customer_id: @c1.id, status: 2)
    @i10 = Invoice.create!(merchant_id: @m4.id, customer_id: @c2.id, status: 2)
    @i11 = Invoice.create!(merchant_id: @m4.id, customer_id: @c2.id, status: 2)
    @i12 = Invoice.create!(merchant_id: @m5.id, customer_id: @c2.id, status: 2)
    
    @item_1 = Item.create!(name: 'Shampoo', description: 'This washes your hair', unit_price: 10, merchant_id: @m1.id)
    @item_2 = Item.create!(name: 'Conditioner', description: 'This makes your hair shiny', unit_price: 8, merchant_id: @m2.id)
    @item_3 = Item.create!(name: 'Brush', description: 'This takes out tangles', unit_price: 5, merchant_id: @m3.id)
    @item_4 = Item.create!(name: 'test', description: 'lalala', unit_price: 6, merchant_id: @m4.id)
    @item_5 = Item.create!(name: 'rest', description: 'dont test me', unit_price: 12, merchant_id: @m5.id)

    @ii_1 = InvoiceItem.create!(invoice_id: @i1.id, item_id: @item_1.id, quantity: 12, unit_price: 10, status: 0)
    @ii_2 = InvoiceItem.create!(invoice_id: @i2.id, item_id: @item_2.id, quantity: 6, unit_price: 8, status: 1)
    @ii_3 = InvoiceItem.create!(invoice_id: @i3.id, item_id: @item_3.id, quantity: 16, unit_price: 5, status: 2)
    @ii_4 = InvoiceItem.create!(invoice_id: @i4.id, item_id: @item_3.id, quantity: 2, unit_price: 5, status: 2)
    @ii_5 = InvoiceItem.create!(invoice_id: @i5.id, item_id: @item_3.id, quantity: 10, unit_price: 5, status: 2)
    @ii_6 = InvoiceItem.create!(invoice_id: @i1.id, item_id: @item_3.id, quantity: 7, unit_price: 5, status: 2)
    @ii_7 = InvoiceItem.create!(invoice_id: @i2.id, item_id: @item_3.id, quantity: 1, unit_price: 5, status: 2)

    @t1 = Transaction.create!(credit_card_number: 203942, result: 1, invoice_id: @i1.id)
    @t2 = Transaction.create!(credit_card_number: 230948, result: 1, invoice_id: @i2.id)
    @t3 = Transaction.create!(credit_card_number: 234092, result: 1, invoice_id: @i3.id)
    @t4 = Transaction.create!(credit_card_number: 230429, result: 1, invoice_id: @i5.id)
    @t5 = Transaction.create!(credit_card_number: 102938, result: 1, invoice_id: @i6.id)
    @t6 = Transaction.create!(credit_card_number: 102938, result: 1, invoice_id: @i1.id)

    visit admin_merchants_path
  end

  it 'should display all the merchants' do
    expect(page).to have_content(@m1.name)
    expect(page).to have_content(@m2.name)
    expect(page).to have_content(@m3.name)
  end

  it 'should have rerouting links on all merchants names to their admin show page' do
    within("#toppy-#{@m1.id}") do
      click_link "#{@m1.name}"
      expect(current_path).to eq(admin_merchant_path(@m1))
    end
  end

  it 'should have set merchants to disabled by default' do
      expect(@m1.status).to eq('disabled')
  end

  it 'should have button to disable merchants' do
    within("#merchant-#{@m1.id}") do
      click_button 'Enable'
      
      @merchant = Merchant.find(@m1.id)
      expect(@merchant.status).to eq('enabled')
    end
  end

  it 'should group by enabled/disabled' do 
    expect(@m1.name).to appear_before(@m3.name)
  end

  it 'should have a link to create a new merchant' do
    expect(page).to have_link('Create Merchant')
    click_link 'Create Merchant'

    expect(current_path).to eq(new_admin_merchant_path)
    fill_in :name, with: 'Dingley Doo'
    click_button

    expect(current_path).to eq(admin_merchants_path)
    expect(page).to have_content('Dingley Doo')
  end

  it 'should list merchant total revenue next to name' do
    expect(page).to have_content(@m1.total_revenue)
    expect(@m1.total_revenue).to eq(120)
  end

  it 'should display the best day for each top 5 merchant' do
    within("#top-#{@m1.id}") do
      expect(page).to have_content("Top Selling Date for #{@m1.name} was on#{@m1.best_day.strftime("%_m/%d/%Y")}")
    end
  end

end
