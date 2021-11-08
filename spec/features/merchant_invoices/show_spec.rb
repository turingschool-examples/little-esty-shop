require "rails_helper"

RSpec.describe "merchant's invoice show page", type: :feature do
  describe "when I visit my merchant's invoice show page" do
    before(:each) do

      @merchant = Merchant.create(name: "Friendly Traveling Merchant")

      @item_1 = @merchant.items.create(name: 'YoYo', description: 'its on a string', unit_price: 1000)
      @item_2 = @merchant.items.create(name: 'raisin', description: 'dried grape', unit_price: 100)
      @item_3 = @merchant.items.create(name: 'apple', description: 'nice and crisp', unit_price: 500)
      @item_4 = @merchant.items.create(name: 'banana', description: 'mushy but good', unit_price: 200)
      @item_5 = @merchant.items.create(name: 'pear', description: 'refreshing treat', unit_price: 600)

      @customer = Customer.create(first_name: 'George', last_name: 'Washington')

      @invoice_1 = @customer.invoices.create(status: 'Completed')
      @invoice_2 = @customer.invoices.create(status: 'Completed')

      # @invoice_item_1 = @invoice_1.invoice_items.create(item_id: @item_1.id, quantity: 3, unit_price: 1000, status: 'shipped')
      # @invoice_item_2 = @invoice_1.invoice_items.create(item_id: @item_2.id, quantity: 1, unit_price: 100, status: 'shipped')
      # @invoice_item_3 = @invoice_1.invoice_items.create(item_id: @item_3.id, quantity: 1, unit_price: 400, status: 'shipped')
      # @invoice_item_4 = @invoice_1.invoice_items.create(item_id: @item_4.id, quantity: 1, unit_price: 200, status: 'shipped')
      # @invoice_item_5 = @invoice_1.invoice_items.create(item_id: @item_5.id, quantity: 1, unit_price: 600, status: 'shipped')

      # transaction_1 = invoice_1.transactions.create(credit_card_number: 1234123412341234, credit_card_expiration_date: '2012-03-27', result: 'failed')
      # transaction_2 = invoice_1.transactions.create(credit_card_number: 1234123412341234, credit_card_expiration_date: '2012-03-27', result: 'success')
      # transaction_3 = invoice_2.transactions.create(credit_card_number: 1234123412341234, credit_card_expiration_date: '2012-03-27', result: 'success')
      # transaction_4 = invoice_3.transactions.create(credit_card_number: 1234123412341234, credit_card_expiration_date: '2012-03-27', result: 'failed')
      # transaction_4 = invoice_3.transactions.create(credit_card_number: 1234123412341234, credit_card_expiration_date: '2012-03-27', result: 'success')

      visit "/merchants/#{@merchant.id}/invoice/#{@invoice_1.id}"

    end

    it "I see invoice's id, status and created_at date" do
      expect(page).to have_content("Invoice ID: #{@invoice_1.id}")
      expect(page).to_not have_content("Invoice ID: #{@invoice_2.id}")

      expect(page).to have_content("Invoice Status: #{@invoice_1.status}")
      expect(page).to have_content("Created At: ")



      #date in the format "Monday, July 18, 2019"
    end

    it "I see customer's first and last name" do
    end
  end
end
