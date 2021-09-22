require 'rails_helper'

RSpec.describe 'Merchant Items Index Page' do

  it 'shows the names of all items of that merchant' do
    merchant = Merchant.create!(name: "Tony")
    item_1 = merchant.items.create!(name: "Shirt", description: "A blue shirt", unit_price: 30)
    item_2 = merchant.items.create!(name: "Pants", description: "Black pants", unit_price: 50)

    visit(merchant_items_path(merchant))

    expect(current_path).to eq("/merchants/#{merchant.id}/items")
    expect(page).to have_content(item_1.name)
    expect(page).to have_content(item_2.name)
  end

  it 'has a link to take you to the merchant items show page' do
    merchant = Merchant.create!(name: "Tony")
    item_1 = merchant.items.create!(name: "Shirt", description: "A blue shirt", unit_price: 30)
    item_2 = merchant.items.create!(name: "Pants", description: "Black pants", unit_price: 50)

    visit(merchant_items_path(merchant))
    click_on "#{item_1.name}"

    expect(current_path).to eq(merchant_item_path(merchant, item_1))
    expect(page).to have_content(item_1.name)
    expect(page).to have_content(item_1.description)
    expect(page).to have_content(item_1.unit_price)
  end

  describe 'enabled disabled items list' do

    it 'has a button to enable the item status' do
      merchant = Merchant.create!(name: "Tony")
      item_1 = merchant.items.create!(name: "Shirt", description: "A blue shirt", unit_price: 30, status: 'disabled' )
      item_2 = merchant.items.create!(name: "Pants", description: "Black pants", unit_price: 50, status: 'enabled')
  
      visit(merchant_items_path(merchant))
      
      expect(page).to have_button("Enable Item")
      within("#Item-#{item_1.id}") do
        click_on("Enable Item")
        expect(current_path).to eq("/merchants/#{merchant.id}/items")    
      end
      within("#Enabled") do
        expect(page).to have_content(item_1.name)
      end

    end

    it 'has a button to disable the item status' do
      merchant = Merchant.create!(name: "Tony")
      item_1 = merchant.items.create!(name: "Pants", description: "Black pants", unit_price: 50, status: 'enabled')
      item_2 = merchant.items.create!(name: "Shirt", description: "A blue shirt", unit_price: 30, status: 'disabled')
  
      visit(merchant_items_path(merchant))
      
      expect(page).to have_button("Enable Item")

      within("#Item-#{item_1.id}") do
        click_on("Disable Item")
        expect(current_path).to eq("/merchants/#{merchant.id}/items")    
      end
      within("#Disabled") do
        expect(page).to have_content(item_1.name)
      end
    end
  end

  describe 'Top 5 Items per revenue' do
    before :each do
      @merchant_1 = Merchant.create!(name: "Cool Shirts")

      # Item 1 produced 2400 revenue
      @item_1 = @merchant_1.items.create!(name: "Dog", description: "Dog shirt", unit_price: 1400)
      @customer_1 = Customer.create(first_name: 'Bob', last_name: 'Johnson')
      @invoice_1 = @customer_1.invoices.create!(status: 'completed', created_at: "2012-03-25 09:54:09 UTC")
      @invoice_item_1a = @invoice_1.invoice_items.create!(item: @item_1, quantity: 1, unit_price: 1400, status: "pending")
      @invoice_item_1b = @invoice_1.invoice_items.create!(item: @item_1, quantity: 1, unit_price: 1000, status: "packaged")
      @transaction_1 = @invoice_1.transactions.create!(result: "success")

      # Item 2 produced 5400 revenue the quantity of invoice_item_2b is 4 to demonstrate the revenue calculation
      @item_2 = @merchant_1.items.create!(name: "burger", description: "burger shirt", unit_price: 1400)
      @customer_1 = Customer.create(first_name: 'Bob', last_name: 'Johnson')
      @invoice_2 = @customer_1.invoices.create!(status: 'completed', created_at: "2012-03-25 09:54:09 UTC")
      @invoice_item_2a = @invoice_2.invoice_items.create!(item: @item_2, quantity: 1, unit_price: 1400, status: "pending")
      @invoice_item_2b = @invoice_2.invoice_items.create!(item: @item_2, quantity: 4, unit_price: 1000, status: "packaged")
      @transaction_2 = @invoice_2.transactions.create!(result: "success")

      # Item 3 produced 4000 revenue. Transaction 3 failed but because there is a success for invoice 3 it will be counted towards total revenue
      @item_3 = @merchant_1.items.create!(name: "Omg", description: "Omg shirt", unit_price: 1400)
      @customer_1 = Customer.create(first_name: 'Bob', last_name: 'Johnson')
      @invoice_3 = @customer_1.invoices.create!(status: 'completed', created_at: "2012-03-25 09:54:09 UTC")
      @invoice_item_3a = @invoice_3.invoice_items.create!(item: @item_3, quantity: 2, unit_price: 1000, status: "pending")
      @invoice_item_3b = @invoice_3.invoice_items.create!(item: @item_3, quantity: 2, unit_price: 1000, status: "packaged")
      @transaction_3 = @invoice_3.transactions.create!(result: "failed")
      @transaction_4 = @invoice_3.transactions.create!(result: "success")

      # Item 4 produced 6000 revenue. This set is ment to demonstrate that multiple invoices will be counted towards the item revenue
      @item_4 = @merchant_1.items.create!(name: "suck", description: "suck shirt", unit_price: 1400)
      @customer_1 = Customer.create(first_name: 'Bob', last_name: 'Johnson')
      @invoice_4 = @customer_1.invoices.create!(status: 'completed', created_at: "2012-03-25 09:54:09 UTC")
      @invoice_item_4a = @invoice_4.invoice_items.create!(item: @item_4, quantity: 2, unit_price: 1000, status: "pending")
      @invoice_item_4b = @invoice_4.invoice_items.create!(item: @item_4, quantity: 2, unit_price: 1000, status: "packaged")
      @transaction_5 = @invoice_4.transactions.create!(result: "success")
      @invoice_5 = @customer_1.invoices.create!(status: 'completed', created_at: "2012-03-25 09:54:09 UTC")
      @invoice_item_5a = @invoice_5.invoice_items.create!(item: @item_4, quantity: 1, unit_price: 1000, status: "pending")
      @invoice_item_5b = @invoice_5.invoice_items.create!(item: @item_4, quantity: 1, unit_price: 1000, status: "packaged")
      @transaction_6 = @invoice_5.transactions.create!(result: "success")

      # Item 5 produced 2000 revenue. The set is to demonstrate that if the trasaction failed for that invoice then it will not count towards the item revenue
      @item_5 = @merchant_1.items.create!(name: "gobble", description: "turkey shirt", unit_price: 1400)
      @customer_1 = Customer.create(first_name: 'Bob', last_name: 'Johnson')
      @invoice_6 = @customer_1.invoices.create!(status: 'completed', created_at: "2012-03-25 09:54:09 UTC")
      @invoice_item_6a = @invoice_6.invoice_items.create!(item: @item_5, quantity: 2, unit_price: 1000, status: "pending")
      @invoice_item_6b = @invoice_6.invoice_items.create!(item: @item_5, quantity: 2, unit_price: 1000, status: "packaged")
      @transaction_7 = @invoice_6.transactions.create!(result: "failed")
      @invoice_7 = @customer_1.invoices.create!(status: 'completed', created_at: "2012-03-25 09:54:09 UTC")
      @invoice_item_7a = @invoice_7.invoice_items.create!(item: @item_5, quantity: 1, unit_price: 1000, status: "pending")
      @invoice_item_7b = @invoice_7.invoice_items.create!(item: @item_5, quantity: 1, unit_price: 1000, status: "packaged")
      @transaction_8 = @invoice_7.transactions.create!(result: "success")  
      
      visit(merchant_items_path(@merchant_1))
    end

    it 'can display the top 5 items in order of how much revenue an item generated' do
      expect(@item_4.name).to appear_before(@item_2.name)
      expect(@item_2.name).to appear_before(@item_3.name)
      expect(@item_3.name).to appear_before(@item_1.name)
      expect(@item_1.name).to appear_before(@item_5.name)
    end

    it 'can display the dollars that the item generated' do
      within("#Top-Item-#{@item_4.id}") do
        expect(page).to have_content("$60 In Sales")
      end
    end
  end

end
