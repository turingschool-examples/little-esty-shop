require 'rails_helper'

RSpec.describe 'merchant invoices show', type: :feature do
  before(:each) do
    @merchant_1 = Merchant.create!(name: 'Etsy')
    @item_1 = @merchant_1.items.create!(name: 'Ruby', description: 'red', unit_price: 1000, status: 0)
    @item_2 = @merchant_1.items.create!(name: 'Saphire', description: 'blue', unit_price: 1500, status: 1)
    @item_3 = @merchant_1.items.create!(name: 'Jade', description: 'green', unit_price: 3000, status: 1)
    @item_4 = @merchant_1.items.create!(name: 'Drill', description: 'Drill stuff', unit_price: 5000, status: 1)
    @customer_1 = Customer.create!(first_name: 'Will', last_name: 'Rogers')
    @customer_2 = Customer.create!(first_name: 'Carl', last_name: 'Weathers')
    @invoice_1 = @customer_1.invoices.create!(status: 1, created_at: '2012-03-25')
    @invoice_2 = @customer_2.invoices.create!(status: 0, created_at: '2012-03-24')
    InvoiceItem.create!(item_id: @item_1.id, invoice_id: @invoice_1.id)
    InvoiceItem.create!(item_id: @item_2.id, invoice_id: @invoice_1.id)
    InvoiceItem.create!(item_id: @item_2.id, invoice_id: @invoice_1.id)
    InvoiceItem.create!(item_id: @item_3.id, invoice_id: @invoice_1.id)
    InvoiceItem.create!(item_id: @item_3.id, invoice_id: @invoice_1.id)
    InvoiceItem.create!(item_id: @item_3.id, invoice_id: @invoice_1.id)
    InvoiceItem.create!(item_id: @item_4.id, invoice_id: @invoice_2.id) 

    visit "/merchants/#{@merchant_1.id}/invoices/#{@invoice_1.id}"
  end
  
  describe "Then I see information related to that invoice including:" do
    it "displays the invoice id" do
      expect(page).to have_content(@invoice_1.id)
      expect(page).to_not have_content(@invoice_2.id)
    end

    it "displays the invoice status" do
      expect(page).to have_content(@invoice_1.status)
      expect(page).to_not have_content(@invoice_2.status)
    end

    it "displays the invoice created at" do
      expect(page).to have_content(@invoice_1.custom_date)
      expect(page).to_not have_content(@invoice_2.custom_date)
    end

    it "displays the customer's first and last name" do
      expect(page).to have_content(@customer_1.full_name)
      expect(page).to_not have_content(@customer_2.full_name)
    end
  end

  describe "I see all of my items on the invoice including:" do
    it "displays item name" do
      within "#item-#{@item_1.id}" do
        expect(page).to have_content(@item_1.name)
        expect(page).to_not have_content(@item_2.name)
        expect(page).to_not have_content(@item_3.name)
      end
      within "#item-#{@item_2.id}" do
        expect(page).to have_content(@item_2.name)
        expect(page).to_not have_content(@item_1.name)
        expect(page).to_not have_content(@item_3.name)
      end
      within "#item-#{@item_3.id}" do
        expect(page).to have_content(@item_3.name)
        expect(page).to_not have_content(@item_1.name)
        expect(page).to_not have_content(@item_2.name)
      end
    end

    it "displays the quantity of the item ordered" do
      within "#item-#{@item_1.id}" do
        expect(page).to have_content("Quantity: 1")
        expect(page).to_not have_content("Quantity: 2")
        expect(page).to_not have_content("Quantity: 3")
      end

      within "#item-#{@item_2.id}" do
        expect(page).to have_content("Quantity: 2")
        expect(page).to_not have_content("Quantity: 3")
        expect(page).to_not have_content("Quantity: 1")
      end

      within "#item-#{@item_3.id}" do
        expect(page).to have_content("Quantity: 3")
        expect(page).to_not have_content("Quantity: 1")
        expect(page).to_not have_content("Quantity: 2")
      end
    end

    it "displays the price item sold for" do
      within "#item-#{@item_1.id}" do
        expect(page).to have_content(@item_1.unit_price)
        expect(page).to_not have_content(@item_2.unit_price)
        expect(page).to_not have_content(@item_3.unit_price)
      end

      within "#item-#{@item_2.id}" do
        expect(page).to have_content(@item_2.unit_price)
        expect(page).to_not have_content(@item_1.unit_price)
        expect(page).to_not have_content(@item_3.unit_price)
      end

      within "#item-#{@item_3.id}" do
        expect(page).to have_content(@item_3.unit_price)
        expect(page).to_not have_content(@item_1.unit_price)
        expect(page).to_not have_content(@item_2.unit_price)
      end
    end

    it "displays the total revenue that will be generated from all of my items on the invoice" do
      within "#items" do 
        expect(page).to have_content("Total Revenue: 13000")
        expect(page).to_not have_content("Total Revenue: 56500")
      end
    end
  end 

  describe 'update item status' do
    it "can change the current status of an item to another status" do
      within "#item-#{@item_1.id}" do
        expect(page).to have_content(@item_1.status)
        expect(@item_1.status).to eq("disabled")
        has_select?('status', with_options: ['enabled', 'disabled'])

        select('enabled', from: 'status')

        expect(current_path).to eq("/merchants/#{@merchant_1.id}/invoices/#{@invoice_1.id}")
        expect(@item_1.status).to eq("enabled")
      end

      within "#item-#{@item_2.id}" do
        expect(page).to have_content(@item_2.status)
        expect(@item_2.status).to eq("enabled")
        has_select?('status', with_options: ['enabled', 'disabled'])

        select('disabled', from: 'status')

        expect(current_path).to eq("/merchants/#{@merchant_1.id}/invoices/#{@invoice_1.id}")
        expect(@item_2.status).to eq("disabled")
      end 
    end 
  end
end