require "rails_helper"

RSpec.describe "Merchants Discount Index", type: :feature do
  describe "as merchant" do
    before(:each) do
      # @merchant = Merchant.create(name: "Friendly Traveling Merchant")
      #
      # @discount1 = @merchant.discounts.create!(discount_percentage: 20, threshhold_quantity: 10)
      # @discount2 = @merchant.discounts.create!(discount_percentage: 15, threshhold_quantity: 8)
      # @discount3 = @merchant.discounts.create!(discount_percentage: 10, threshhold_quantity: 5)

      # @item = @merchant.items.create(name: 'YoYo', description: 'its on a string')

      # @customer_1 = Customer.create(first_name: 'George', last_name: 'Washington')
      # @customer_2 = Customer.create(first_name: 'John', last_name: 'Adams')
      # @customer_3 = Customer.create(first_name: 'Thomas', last_name: 'Jefferson')
      # @customer_4 = Customer.create(first_name: 'James', last_name: 'Madison')
      # @customer_5 = Customer.create(first_name: 'James', last_name: 'Monroe')
      # @customer_6 = Customer.create(first_name: 'John Quincy', last_name: 'Adams')
      #
      # @invoice_1 = @customer_1.invoices.create(status: 2)
      # @invoice_2 = @customer_2.invoices.create(status: 2)
      # @invoice_3 = @customer_3.invoices.create(status: 2)
      # @invoice_4 = @customer_4.invoices.create(status: 2)
      # @invoice_5 = @customer_5.invoices.create(status: 2)
      # @invoice_6 = @customer_6.invoices.create(status: 2)
      # @invoice_7 = @customer_6.invoices.create(status: 2)
      #
      # @invoice_item_1 = @invoice_1.invoice_items.create(item_id: @item.id, quantity: 1, unit_price: 1000, status: 'shipped')
      # @invoice_item_2 = @invoice_2.invoice_items.create(item_id: @item.id, quantity: 1, unit_price: 1000, status: 'shipped')
      # @invoice_item_3 = @invoice_3.invoice_items.create(item_id: @item.id, quantity: 1, unit_price: 1000, status: 'shipped')
      # @invoice_item_4 = @invoice_4.invoice_items.create(item_id: @item.id, quantity: 1, unit_price: 1000, status: 'shipped')
      # @invoice_item_5 = @invoice_5.invoice_items.create(item_id: @item.id, quantity: 1, unit_price: 1000, status: 'shipped')
      # @invoice_item_6 = @invoice_6.invoice_items.create(item_id: @item.id, quantity: 1, unit_price: 1000, status: 'packaged')
      # @invoice_item_7 = @invoice_7.invoice_items.create(item_id: @item.id, quantity: 1, unit_price: 1000, status: 'pending')
      #
      # @transaction_1 = @invoice_1.transactions.create(credit_card_number: 1234123412341234, credit_card_expiration_date: '2012-03-27', result: 'success')
      # @transaction_2 = @invoice_1.transactions.create(credit_card_number: 1234123412341234, credit_card_expiration_date: '2012-03-27', result: 'success')
      # @transaction_3 = @invoice_2.transactions.create(credit_card_number: 1234123412341234, credit_card_expiration_date: '2012-03-27', result: 'success')
      # @transaction_4 = @invoice_2.transactions.create(credit_card_number: 1234123412341234, credit_card_expiration_date: '2012-03-27', result: 'success')
      # @transaction_5 = @invoice_3.transactions.create(credit_card_number: 1234123412341234, credit_card_expiration_date: '2012-03-27', result: 'success')
      # @transaction_6 = @invoice_4.transactions.create(credit_card_number: 1234123412341234, credit_card_expiration_date: '2012-03-27', result: 'success')
      # @transaction_7 = @invoice_4.transactions.create(credit_card_number: 1234123412341234, credit_card_expiration_date: '2012-03-27', result: 'success')
      # @transaction_8 = @invoice_5.transactions.create(credit_card_number: 1234123412341234, credit_card_expiration_date: '2012-03-27', result: 'success')
      # @transaction_9 = @invoice_5.transactions.create(credit_card_number: 1234123412341234, credit_card_expiration_date: '2012-03-27', result: 'success')
      # @transaction_10 = @invoice_5.transactions.create(credit_card_number: 1234123412341234, credit_card_expiration_date: '2012-03-27', result: 'success')
      # @transaction_11 = @invoice_6.transactions.create(credit_card_number: 1234123412341234, credit_card_expiration_date: '2012-03-27', result: 'failed')
      @merchant = Merchant.create(name: "Friendly Traveling Merchant")

      @discount1 = @merchant.discounts.create!(discount_percentage: 20, threshhold_quantity: 10)
      @discount2 = @merchant.discounts.create!(discount_percentage: 15, threshhold_quantity: 8)
      @discount3 = @merchant.discounts.create!(discount_percentage: 10, threshhold_quantity: 5)

      visit "/merchants/#{@merchant.id}/discounts"
    end

    it "I see all of my discounts, including percentage and quantity" do
      expect(page).to have_content("Discount #{@discount1.id} --- Quantity: #{@discount1.threshhold_quantity} units, Discount: #{@discount1.discount_percentage}%")
      expect(page).to have_content("Discount #{@discount2.id} --- Quantity: #{@discount2.threshhold_quantity} units, Discount: #{@discount2.discount_percentage}%")
    end

    it "I see each discount has a link to its show page" do

      click_on "Go to Discount #{@discount1.id}"
      expect(current_path).to eq("/merchants/#{@merchant.id}/discounts/#{@discount1.id}")
    end
#test for valid data inputs. also, refuse to create irrelevant discounts
    it "I can create a new discount" do
      click_on "Create a New Discount"

      expect(current_path).to eq("/merchants/#{@merchant.id}/discounts/new")

      fill_in "Threshhold quantity", with: "100"
      fill_in "Discount percentage", with: "30"
      click_on "Submit"
      expect(current_path).to eq("/merchants/#{@merchant.id}/discounts")
      expect(page).to have_content("Quantity: 100 units, Discount: 30%")

    end

    it "I can see a link to delete each discount, and delete that discount" do
      click_on "Delete Discount #{@discount1.id}"
      expect(current_path).to eq("/merchants/#{@merchant.id}/discounts")
      expect(page).to_not have_content("Discount #{@discount1.id}")
    end
  end
end
