require 'rails_helper'

RSpec.describe 'merchant invoices show', type: :feature do
  before(:each) do
    @merchant_1 = Merchant.create!(name: 'Etsy')
    @merchant_2 = Merchant.create!(name: 'Build-a-Bear')
    @item_1 = @merchant_1.items.create!(name: 'Axe', description: 'Chop stuff', unit_price: 1000, status: 1)
    @item_2 = @merchant_1.items.create!(name: 'Hammer', description: 'Hit stuff', unit_price: 1500, status: 0)
    @item_3 = @merchant_1.items.create!(name: 'Drill', description: 'Drill stuff', unit_price: 5000, status: 1)
    @item_4 = @merchant_2.items.create!(name: 'Wrench', description: 'Turn stuff', unit_price: 900, status: 0)
    @item_5 = @merchant_2.items.create!(name: 'Nail', description: 'Nail stuff', unit_price: 50, status: 1)
    @customer_1 = Customer.create!(first_name: 'Jon', last_name: 'Jones')
    @customer_2 = Customer.create!(first_name: 'Jan', last_name: 'Jones')
    @customer_3 = Customer.create!(first_name: 'Jin', last_name: 'Jones')
    @customer_4 = Customer.create!(first_name: 'Joon', last_name: 'Jones')
    @customer_5 = Customer.create!(first_name: 'Joc', last_name: 'Jones')
    @customer_6 = Customer.create!(first_name: 'JakJak', last_name: 'Jones')
    @invoice_1 = @customer_1.invoices.create!(status: 1, created_at: '2012-03-25')
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
    InvoiceItem.create!(item_id: @item_3.id, invoice_id: @invoice_4.id) 
    InvoiceItem.create!(item_id: @item_1.id, invoice_id: @invoice_4.id)
    InvoiceItem.create!(item_id: @item_1.id, invoice_id: @invoice_4.id) 
    InvoiceItem.create!(item_id: @item_1.id, invoice_id: @invoice_4.id)

    visit "/merchants/#{@merchant_1.id}/invoices/#{@invoice_1.id}"
  end

  describe "Then I see information related to that invoice including:" do
    it "displays the invoice id" do
      expect(page).to have_content(@invoice_1.id)
      expect(page).to_not have_content(@invoice_4.id)
      expect(page).to_not have_content(@invoice_11.id)
    end

    it "displays the invoice status" do
      expect(page).to have_content(@invoice_1.status)
    end

    it "displays the invoice created at" do
      expect(page).to have_content(@invoice_1.custom_date)
    end

    it "displays the customer's first and last name" do
      expect(page).to have_content(@customer_1.first_name)
      expect(page).to have_content(@customer_1.last_name)
      expect(page).to_not have_content(@customer_2.first_name)
      expect(page).to_not have_content(@customer_3.first_name)
    end
  end

  describe "I see all of my items on the invoice including:" do
    before(:each) do
      visit "/merchants/#{@merchant_1.id}/invoices/#{@invoice_4.id}"
    end
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
        expect(page).to have_content("Quantity: 5")
        expect(page).to_not have_content("Quantity: 1")
        expect(page).to_not have_content("Quantity: 2")
      end

      within "#item-#{@item_2.id}" do
        expect(page).to have_content("Quantity: 2")
        expect(page).to_not have_content("Quantity: 3")
        expect(page).to_not have_content("Quantity: 4")
      end

      within "#item-#{@item_3.id}" do
        expect(page).to have_content("Quantity: 3")
        expect(page).to_not have_content("Quantity: 6")
        expect(page).to_not have_content("Quantity: 5")
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

    it "displays invoice item status" do
      within "#item-#{@item_1.id}" do
        expect(page).to have_content(@item_1.status)
        expect(page).to_not have_content("disabled")
      end

      within "#item-#{@item_2.id}" do
        expect(page).to have_content(@item_2.status)
        expect(page).to_not have_content("enabled")
      end

      within "#item-#{@item_3.id}" do
        expect(page).to have_content(@item_3.status)
        expect(page).to_not have_content("disabled")
      end
    end

    it "displays the total revenue that will be generated from all of my items on the invoice" do
      within "#items" do 
        expect(page).to have_content("Total Revenue: 9500")
        expect(page).to_not have_content("Total Revenue: 56500")
      end
    end
  

    describe 'update item status' do
      it "can change the current status of an item to another status" do
        within "#item-#{@item_1.id}" do
          expect(page).to have_button("Update Item Status")

          click_button("Update Item Status")

          expect(current_path).to eq("/merchants/#{@merchant_1.id}/invoices/#{@invoice_4.id}/edit")
          # expect(page).to have_content(@item_1.status)
          # expect(page).to have_content("enabled")
        end

        within "#item-#{@item_2.id}" do
          expect(page).to have_button("Update Item Status")

          click_button("Update Item Status")

          expect(current_path).to eq("/merchants/#{@merchant_1.id}/invoices/#{@invoice_4.id}/edit")
          # expect(page).to have_content(@item_2.status)
          # expect(page).to have_content("disabled")
        end

        within "#item-#{@item_3.id}" do
          expect(page).to have_button("Update Item Status")

          click_button("Update Item Status")

          expect(current_path).to eq("/merchants/#{@merchant_1.id}/invoices/#{@invoice_4.id}/edit")
          # expect(page).to have_content(@item_3.status)
          # expect(page).to have_content("enabled")
        end
      end
    end 
  end
end