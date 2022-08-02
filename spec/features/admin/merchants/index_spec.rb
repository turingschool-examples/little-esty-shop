require 'rails_helper'

RSpec.describe 'admin merchants index page' do
  it 'displays the names of each merchant in the system' do
    merchant1 = Merchant.create!(name: 'Trader Joes')
    merchant2 = Merchant.create!(name: 'Whole Foods')
    merchant3 = Merchant.create!(name: 'Yes Market')
    merchant4 = Merchant.create!(name: 'Pasta Emporium')

    visit admin_merchants_path

    within '#merchant-list' do
      expect(page).to have_content('Trader Joes')
      expect(page).to have_content('Whole Foods')
      expect(page).to have_content('Yes Market')
      expect(page).to have_content('Pasta Emporium')
    end
  end

  it 'when user clicks name of merchant, taken to that merchants admin show page, and shows the name of that merchant' do
    merchant1 = Merchant.create!(name: 'Trader Joes')
    merchant2 = Merchant.create!(name: 'Whole Foods')
    merchant3 = Merchant.create!(name: 'Yes Market')
    merchant4 = Merchant.create!(name: 'Pasta Emporium')

    visit admin_merchants_path

    within "#merchant-#{merchant1.id}" do
      click_link 'Trader Joes'
    end

    expect(current_path).to eq(admin_merchant_path(merchant1.id))

    expect(page).to have_content('Trader Joes')
  end
  
  it 'has names of the top 5 merchants by total revenue generated' do
    merchant1 = Merchant.create!(name: "Snake Shop")
    merchant2 = Merchant.create!(name: "Fish Foods")
    merchant3 = Merchant.create!(name: "Cat Cafe")
    merchant4 = Merchant.create!(name: "Dog Diner")
    merchant5 = Merchant.create!(name: "Aardvark Accessories")
    merchant6 = Merchant.create!(name: "Elephant Earmuffs")

    customer = Customer.create!(first_name: "Alep", last_name: "Bloyd")

    item1_merchant1 = Item.create!(name: "Snake Pants", description: "It is just a sock.", unit_price: 400, merchant_id: merchant1.id)
    item1_merchant2 = Item.create!(name: "Stinky Bits", description: "Nondescript floaty chunks.", unit_price: 200, merchant_id: merchant2.id)
    item1_merchant3 = Item.create!(name: "Fur Ball", description: "Ew pretty nasty!", unit_price: 1000, merchant_id: merchant3.id)
    item1_merchant4 = Item.create!(name: "Milkbone", description: "Is it dairy or is it meat?", unit_price: 50, merchant_id: merchant4.id)
    item1_merchant5 = Item.create!(name: "Library Card", description: "This should be free", unit_price: 5000, merchant_id: merchant5.id)
    item1_merchant6 = Item.create!(name: "Big Earmuffs", description: "You could wear one like a hat", unit_price: 1000, merchant_id: merchant6.id)

    invoice1 = Invoice.create!(customer_id: customer.id, status: 2)
      invoiceitem1_item1_invoice1 = InvoiceItem.create!(item_id: item1_merchant1.id, invoice_id: invoice1.id, quantity: 10, unit_price: 1, status: 0) # 10 revenue for merchant 1
      invoiceitem2_item1_invoice1 = InvoiceItem.create!(item_id: item1_merchant1.id, invoice_id: invoice1.id, quantity: 10, unit_price: 1, status: 0) # 10 revenue for merchant 1
      invoiceitem3_item1_invoice1 = InvoiceItem.create!(item_id: item1_merchant1.id, invoice_id: invoice1.id, quantity: 10, unit_price: 1, status: 0) # 10 revenue for merchant 1

      transaction1 = Transaction.create!(invoice_id: invoice1.id, credit_card_number: 2222_3333_4444_5555, credit_card_expiration_date: "05-19-1992", result: 1) # successful transaction
    # 30 revenue for merchant 1

    invoice2 = Invoice.create!(customer_id: customer.id, status: 2)
      invoiceitem1_item1_invoice2 = InvoiceItem.create!(item_id: item1_merchant1.id, invoice_id: invoice2.id, quantity: 100_000, unit_price: 1, status: 0) # 100_000 revenue for merchant 1 but it should not count

      transaction2 = Transaction.create!(invoice_id: invoice2.id, credit_card_number: 2222_3333_4444_5555, credit_card_expiration_date: "05-19-1992", result: 0) #failed transaction

    invoice3 = Invoice.create!(customer_id: customer.id, status: 2)
      invoiceitem1_item1_invoice3 = InvoiceItem.create!(item_id: item1_merchant2.id, invoice_id: invoice3.id, quantity: 10, unit_price: 1, status: 0) # 10 revenue for merchant 2
      invoiceitem2_item1_invoice3 = InvoiceItem.create!(item_id: item1_merchant2.id, invoice_id: invoice3.id, quantity: 10, unit_price: 1, status: 0) # 10 revenue for merchant 2

      transaction3 = Transaction.create!(invoice_id: invoice3.id, credit_card_number: 2222_3333_4444_5555, credit_card_expiration_date: "05-19-1992", result: 1) # successful transaction


    invoice4 = Invoice.create!(customer_id: customer.id, status: 2)
      invoiceitem1_item1_invoice4 = InvoiceItem.create!(item_id: item1_merchant3.id, invoice_id: invoice4.id, quantity: 50, unit_price: 1, status: 0) # 50 revenue for merchant 3

      transaction4 = Transaction.create!(invoice_id: invoice4.id, credit_card_number: 2222_3333_4444_5555, credit_card_expiration_date: "05-19-1992", result: 1) # successful transaction

    invoice5 = Invoice.create!(customer_id: customer.id, status: 2)
      invoiceitem1_item1_invoice5 = InvoiceItem.create!(item_id: item1_merchant4.id, invoice_id: invoice5.id, quantity: 3, unit_price: 1, status: 0) # 3 revenue for merchant 4
      invoiceitem2_item1_invoice5 = InvoiceItem.create!(item_id: item1_merchant4.id, invoice_id: invoice5.id, quantity: 2, unit_price: 1, status: 0) # 2 revenue for merchant 4

      transaction5 = Transaction.create!(invoice_id: invoice5.id, credit_card_number: 2222_3333_4444_5555, credit_card_expiration_date: "05-19-1992", result: 1) # successful transaction

    invoice6 = Invoice.create!(customer_id: customer.id, status: 2)
      invoiceitem1_item1_invoice6 = InvoiceItem.create!(item_id: item1_merchant5.id, invoice_id: invoice6.id, quantity: 555_555, unit_price: 1, status: 0) # 555_555 revenue for merchant 5 but should fail

      transaction6 = Transaction.create!(invoice_id: invoice6.id, credit_card_number: 2222_3333_4444_5555, credit_card_expiration_date: "05-19-1992", result: 0) # failed transaction

    invoice7 = Invoice.create!(customer_id: customer.id, status: 2)
      invoiceitem1_item1_invoice7 = InvoiceItem.create!(item_id: item1_merchant6.id, invoice_id: invoice7.id, quantity: 100, unit_price: 100, status: 0) # 10000 revenue for merchant 6
      invoiceitem2_item1_invoice7 = InvoiceItem.create!(item_id: item1_merchant6.id, invoice_id: invoice7.id, quantity: 100, unit_price: 100, status: 0) # 10000 revenue for merchant 6

      transaction7 = Transaction.create!(invoice_id: invoice7.id, credit_card_number: 1111_2222_3333_4444, credit_card_expiration_date: "12-12-1930", result: 1) # successful transaction

    visit admin_merchants_path

    within "#top-merchants" do
      expect(page).to_not have_content(merchant5.name)
    end

    within "#top-merchant-1" do
      expect(page).to have_content(merchant6.name)
      expect(page).to have_content("Total Revenue: 20000")
    end
    within "#top-merchant-2" do
      expect(page).to have_content(merchant3.name)
      expect(page).to have_content("Total Revenue: 50")
    end
    within "#top-merchant-3" do
      expect(page).to have_content(merchant1.name)
      expect(page).to have_content("Total Revenue: 30")
    end
    within "#top-merchant-4" do
      expect(page).to have_content(merchant2.name)
      expect(page).to have_content("Total Revenue: 20")
    end
    within "#top-merchant-5" do
      expect(page).to have_content(merchant4.name)
      expect(page).to have_content("Total Revenue: 5")
    end
  end

  it 'has a button to enable or disable each merchant' do
    merchant1 = Merchant.create!(name: 'Trader Joes')
    merchant2 = Merchant.create!(name: 'Whole Foods', status: 'Disabled')

    visit admin_merchants_path
    
    within "#enabled-merchant-#{merchant1.id}" do
      expect(page).to have_button('Disable')
    end
    within "#disabled-merchant-#{merchant2.id}" do
      expect(page).to have_button('Enable')
    end
  end

  it 'clicking on enable/disable will update the merchant status and redirect to admin/merchants status and button will change' do
    merchant1 = Merchant.create!(name: 'Trader Joes')
    merchant2 = Merchant.create!(name: 'Whole Foods', status: 'Disabled')

    visit admin_merchants_path
    
    within "#enabled-merchant-#{merchant1.id}" do
      expect(page).to have_content('Trader Joes')
      expect(page).to have_content('Enabled')
      expect(page).to have_button('Disable')
      click_on('Disable')
    end

    expect(current_path).to eq(admin_merchants_path) 

    within "#disabled-merchant-#{merchant1.id}" do
      expect(page).to have_content('Trader Joes')
      expect(page).to have_content('Disabled')
      expect(page).to have_button('Enable')
      click_on('Enable')
    end

    expect(current_path).to eq(admin_merchants_path)

    within "#enabled-merchant-#{merchant1.id}" do
      expect(page).to have_content('Trader Joes')
      expect(page).to have_content('Enabled')
      expect(page).to have_button('Disable')
    end
  end
  
  it 'Each merchant is listed in either the enabled or disabled section' do
    merchant1 = Merchant.create!(name: 'Trader Joes')
    merchant2 = Merchant.create!(name: 'Whole Foods', status: 'Disabled')
    merchant3 = Merchant.create!(name: 'New Seasons', status: 'Disabled')
    merchant4 = Merchant.create!(name: 'Peoples Co-op')

    visit admin_merchants_path

    within "#enabled-merchants" do
      expect(page).to have_content('Trader Joes')
      expect(page).to have_content('Peoples Co-op')
    end
    within "#disabled-merchants" do
      expect(page).to have_content('Whole Foods')
      expect(page).to have_content('New Seasons')
    end
  end

  it 'next to each of the top 5 merchants by revenue, it dsiplays the date with the most revenue for each merchant' do

    merchant1 = Merchant.create!(name: "Snake Shop")
    merchant2 = Merchant.create!(name: "Fish Foods")
    merchant3 = Merchant.create!(name: "Cat Cafe")
    merchant4 = Merchant.create!(name: "Dog Diner")
    merchant5 = Merchant.create!(name: "Aardvark Accessories")
    merchant6 = Merchant.create!(name: "Elephant Earmuffs")

    customer = Customer.create!(first_name: "Alep", last_name: "Bloyd")

    item1_merchant1 = Item.create!(name: "Snake Pants", description: "It is just a sock.", unit_price: 400, merchant_id: merchant1.id)
    item1_merchant2 = Item.create!(name: "Stinky Bits", description: "Nondescript floaty chunks.", unit_price: 200, merchant_id: merchant2.id)
    item1_merchant3 = Item.create!(name: "Fur Ball", description: "Ew pretty nasty!", unit_price: 1000, merchant_id: merchant3.id)
    item1_merchant4 = Item.create!(name: "Milkbone", description: "Is it dairy or is it meat?", unit_price: 50, merchant_id: merchant4.id)
    item1_merchant5 = Item.create!(name: "Library Card", description: "This should be free", unit_price: 5000, merchant_id: merchant5.id)
    item1_merchant6 = Item.create!(name: "Big Earmuffs", description: "You could wear one like a hat", unit_price: 1000, merchant_id: merchant6.id)
    
    customer = Customer.create!(first_name: "Alep", last_name: "Bloyd")


    # test - set up multiple transactions for each merchant
    # group the (successful) transactions by date - WHERE(transactions: {result: 1})
    # SELECT ('transactions.*', sum(invoice_items.quantity * invoice_items.unit_price) AS revenue) - need a date method in transactions maybe?
    # GROUP('transactions.date')
    # order by revenue descending - ORDER(revenue: :desc)
    # get the first one - LIMIT(1)

    # probably need some sort of max_by situation?

  end
# As an admin,
# When I visit the admin merchants index
# Then next to each of the 5 merchants by revenue I see the date with the most revenue for each merchant.
# And I see a label “Top selling date for was "

# Note: use the invoice date. If there are multiple days with equal number of sales, return the most recent day.
end

