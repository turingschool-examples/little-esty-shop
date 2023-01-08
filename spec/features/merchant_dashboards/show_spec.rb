require 'rails_helper'

RSpec.describe 'Merchant Dashboard' do
  before(:each) do
    Transaction.delete_all
    InvoiceItem.delete_all
    Invoice.delete_all
    Item.delete_all
    Customer.delete_all
    Merchant.delete_all
    
    @customer_1 = create(:customer, first_name: "test customer 1")
    @customer_2 = create(:customer, first_name: "test customer 2")
    @customer_3 = create(:customer, first_name: "test customer 3")
    @customer_4 = create(:customer, first_name: "test customer 4")
    @customer_5 = create(:customer, first_name: "test customer 5")
    @customer_6 = create(:customer, first_name: "test customer 6")
    
    @invoice_1 = create(:invoice, customer: @customer_1)
    @invoice_2 = create(:invoice, customer: @customer_6)
    @invoice_3 = create(:invoice, customer: @customer_2)
    @invoice_4 = create(:invoice, customer: @customer_4)
    @invoice_5 = create(:invoice, customer: @customer_4)
    @invoice_6 = create(:invoice, customer: @customer_5)
    @invoice_7 = create(:invoice, customer: @customer_6)
    @invoice_8 = create(:invoice, customer: @customer_6)
    @invoice_9 = create(:invoice, customer: @customer_5)
    @invoice_10 = create(:invoice, customer: @customer_2)
    @invoice_11 = create(:invoice, customer: @customer_6)
    @invoice_12 = create(:invoice, customer: @customer_4)
    @invoice_13 = create(:invoice, customer: @customer_5)
    @invoice_14 = create(:invoice, customer: @customer_6)
    @invoice_15 = create(:invoice, customer: @customer_4)
    @invoice_16 = create(:invoice, customer: @customer_6)
    @invoice_17 = create(:invoice, customer: @customer_4)
    @invoice_18 = create(:invoice, customer: @customer_2)
    @invoice_19 = create(:invoice, customer: @customer_4)

    @transaction_1 = create(:transaction, invoice: @invoice_1, result: "success")
    @transaction_2 = create(:transaction, invoice: @invoice_2, result: "success")
    @transaction_3 = create(:transaction, invoice: @invoice_3, result: "success")
    @transaction_4 = create(:transaction, invoice: @invoice_4, result: "success")
    @transaction_5 = create(:transaction, invoice: @invoice_5, result: "success")
    @transaction_6 = create(:transaction, invoice: @invoice_6, result: "success")
    @transaction_7 = create(:transaction, invoice: @invoice_7, result: "success")
    @transaction_8 = create(:transaction, invoice: @invoice_8, result: "success")
    @transaction_9 = create(:transaction, invoice: @invoice_9, result: "success")
    @transaction_10 = create(:transaction, invoice: @invoice_10, result: "success")
    @transaction_11 = create(:transaction, invoice: @invoice_11, result: "success")
    @transaction_13 = create(:transaction, invoice: @invoice_13, result: "failed")
    @transaction_14 = create(:transaction, invoice: @invoice_14, result: "failed")
    @transaction_15 = create(:transaction, invoice: @invoice_15, result: "success")
    @transaction_16 = create(:transaction, invoice: @invoice_16, result: "success")
    @transaction_17 = create(:transaction, invoice: @invoice_13, result: "success") 
    @transaction_18 = create(:transaction, invoice: @invoice_17, result: "success") 
    @transaction_19 = create(:transaction, invoice: @invoice_18, result: "success") 
    @transaction_20 = create(:transaction, invoice: @invoice_19, result: "success")    

    @merchant_1 = create(:merchant, name: "merchant 1")
    @merchant_2 = create(:merchant)
    @merchant_3 = create(:merchant)
    @merchant_4 = create(:merchant, name: "test merchant 4")

    @item_1 = create(:item, name: "item 1", merchant: @merchant_1)
    @item_2 = create(:item, name: "item 2", merchant: @merchant_1)
    @item_3 = create(:item, name: "item 3",  merchant: @merchant_1)
    @item_4 = create(:item, name: "item 4",  merchant: @merchant_2)
    @item_5 = create(:item, name: "item 5",  merchant: @merchant_2)
    @item_6 = create(:item, name: "item 6",  merchant: @merchant_3)
    @item_7 = create(:item, name: "item 7",  merchant: @merchant_3)
    @item_8 = create(:item, name: "item 8",  merchant: @merchant_2)
    @item_9 = create(:item, name: "item 8",  merchant: @merchant_4)

    @invoice_item_1 = create(:invoice_item, item: @item_1, invoice: @invoice_1, status: "shipped")
    @invoice_item_2 = create(:invoice_item, item: @item_2, invoice: @invoice_6, status: "shipped" )
    @invoice_item_3 = create(:invoice_item, item: @item_2, invoice: @invoice_11, status: "pending" )
    @invoice_item_4 = create(:invoice_item, item: @item_5, invoice: @invoice_2, status: "packaged" )
    @invoice_item_5 = create(:invoice_item, item: @item_5, invoice: @invoice_2, status: "shipped" )
    @invoice_item_6 = create(:invoice_item, item: @item_3, invoice: @invoice_3, status: "pending" )
    @invoice_item_7 = create(:invoice_item, item: @item_1, invoice: @invoice_16, status: "shipped" )
    @invoice_item_8 = create(:invoice_item, item: @item_8, invoice: @invoice_3, status: "packaged" )
    @invoice_item_9 = create(:invoice_item, item: @item_3, invoice: @invoice_4, status: "pending" )
    @invoice_item_10 = create(:invoice_item, item: @item_2, invoice: @invoice_15, status: "packaged" )
    @invoice_item_11 = create(:invoice_item, item: @item_7, invoice: @invoice_5, status: "packaged" )
    @invoice_item_12 = create(:invoice_item, item: @item_3, invoice: @invoice_11, status: "pending" )
    @invoice_item_13 = create(:invoice_item, item: @item_2, invoice: @invoice_12, status: "packaged" )
    @invoice_item_14 = create(:invoice_item, item: @item_8, invoice: @invoice_7, status: "packaged" )
    @invoice_item_15 = create(:invoice_item, item: @item_1, invoice: @invoice_8, status: "pending" )
    @invoice_item_16 = create(:invoice_item, item: @item_6, invoice: @invoice_9, status: "packaged" )
    @invoice_item_17 = create(:invoice_item, item: @item_7, invoice: @invoice_10, status: "pending" )
    @invoice_item_18 = create(:invoice_item, item: @item_2, invoice: @invoice_11, status: "packaged" )
    @invoice_item_19 = create(:invoice_item, item: @item_2, invoice: @invoice_13, status: "packaged" )
    @invoice_item_20 = create(:invoice_item, item: @item_2, invoice: @invoice_18, status: "packaged" )
    @invoice_item_21 = create(:invoice_item, item: @item_9, invoice: @invoice_1, status: "shipped" )
    @invoice_item_22 = create(:invoice_item, item: @item_9, invoice: @invoice_4, status: "packaged" )
    @invoice_item_23 = create(:invoice_item, item: @item_9, invoice: @invoice_4, status: "packaged" )
    @invoice_item_24 = create(:invoice_item, item: @item_9, invoice: @invoice_4, status: "packaged" )
    @invoice_item_26 = create(:invoice_item, item: @item_9, invoice: @invoice_9, status: "pending" )
    @invoice_item_27 = create(:invoice_item, item: @item_9, invoice: @invoice_9, status: "pending" )
    @invoice_item_28 = create(:invoice_item, item: @item_9, invoice: @invoice_9, status: "pending" )
    @invoice_item_29 = create(:invoice_item, item: @item_9, invoice: @invoice_9, status: "pending" )
    @invoice_item_25 = create(:invoice_item, item: @item_9, invoice: @invoice_1, status: "packaged" )
    @invoice_item_30 = create(:invoice_item, item: @item_9, invoice: @invoice_8, status: "pending" )
    @invoice_item_31 = create(:invoice_item, item: @item_9, invoice: @invoice_14, status: "pending" )
    @invoice_item_32 = create(:invoice_item, item: @item_9, invoice: @invoice_10, status: "pending" )
    @invoice_item_33 = create(:invoice_item, item: @item_2, invoice: @invoice_15, status: "shipped" )

    visit merchants_merchantid_dashboard_path(@merchant_1)
  end

  describe 'Story 1 - merchant dashboard Page' do
    it 'displays the name of name of my merchant' do  
      expect(page).to have_content(@merchant_1.name)
    end
  end

  describe 'Story 2 - Page has links to items and invoices index' do
    it 'sends user to the appropriate URI when they click the links' do
     
      click_link ("See #{@merchant_1.name}'s Items")
      
      expect(current_path).to eq("/merchants/#{@merchant_1.id}/items")

      visit merchants_merchantid_dashboard_path(@merchant_1)
      click_link ("See #{@merchant_1.name}'s Invoices")
      
      expect(current_path).to eq("/merchants/#{@merchant_1.id}/invoices")
    end
  end

  describe "Story 3 - merchant's top 5 customers by successful transactions" do
    it "displays the customer's complete name and with their transaction count" do
      within("#customer_info-#{@customer_6.id}") do
        expect(page).to have_content(@customer_6.complete_name)
        expect(page).to have_content(@merchant_1.top_customers.first.trans_count)
      end 
      
      within("#customer_info-#{@customer_4.id}") do
        expect(page).to have_content(@customer_4.complete_name)
        expect(page).to have_content(@merchant_1.top_customers.second.trans_count)
      end 

      within("#customer_info-#{@customer_2.id}") do
        expect(page).to have_content(@customer_2.complete_name)
        expect(page).to have_content(@merchant_1.top_customers.third.trans_count)
      end 
      within("#customer_info-#{@customer_5.id}") do
        expect(page).to have_content(@customer_5.complete_name)
        expect(page).to have_content(@merchant_1.top_customers.fourth.trans_count)
      end 

      within("#customer_info-#{@customer_1.id}") do
        expect(page).to have_content(@customer_1.complete_name)
        expect(page).to have_content(@merchant_1.top_customers.last.trans_count)      
      end 
    end

    it 'lists the customers ordered from most to least transactions count' do
      expect(@customer_6.complete_name).to appear_before(@customer_4.complete_name)
      expect(@customer_4.complete_name).to appear_before(@customer_2.complete_name)
      expect(@customer_2.complete_name).to appear_before(@customer_1.complete_name)
      expect(@customer_5.complete_name).to appear_before(@customer_1.complete_name)
    end

    it 'when multiple customers have the same number of successful transactions, customer.id determins order' do 
      expect(@merchant_1.top_customers.third.trans_count).to eq(2)
      expect(@merchant_1.top_customers.fourth.trans_count).to eq(2)
      
      expect(@merchant_1.top_customers.third).to eq(@customer_2)
      expect(@merchant_1.top_customers.fourth).to eq(@customer_5)
      
      expect(@customer_2.complete_name).to appear_before(@customer_5.complete_name)
        
      visit merchants_merchantid_dashboard_path(@merchant_4)
      expect(@merchant_4.top_customers.fourth.trans_count).to eq(1)
      expect(@merchant_4.top_customers.last.trans_count).to eq(1)
      
      expect(@merchant_4.top_customers.fourth).to eq(@customer_2)
      expect(@merchant_4.top_customers.last).to eq(@customer_6)
      
      expect(@customer_2.complete_name).to appear_before(@customer_6.complete_name)
    end
  end
end