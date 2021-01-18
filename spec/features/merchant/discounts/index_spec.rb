require 'rails_helper'

RSpec.describe 'As a merchant', type: :feature do
  describe 'When I visit my bulk discounts index page' do
    before(:each) do
        @sally       = Customer.create!(first_name: 'Sally', last_name: 'Smith')
        @joel        = Customer.create!(first_name: 'Joel', last_name: 'Hansen')
        @john        = Customer.create!(first_name: 'John', last_name: 'Hansen')
        @travolta    = Customer.create!(first_name: 'Travolta', last_name: 'Hansen')
        @sal         = Customer.create!(first_name: 'Sal', last_name: 'Hansen')
        @tim         = Customer.create!(first_name: 'Tim', last_name: 'Hansen')
        @amazon      = Merchant.create!(name: 'Amazon')
        @max         = Merchant.create!(name: 'Merch Max')
        @alibaba     = Merchant.create!(name: 'Alibaba')
        @invoice1    = Invoice.create!(status: 1, customer_id: @sally.id, merchant_id: @amazon.id)
        @invoice2    = Invoice.create!(status: 1, customer_id: @sally.id, merchant_id: @amazon.id)
        @invoice3    = Invoice.create!(status: 1, customer_id: @joel.id, merchant_id: @amazon.id)
        @invoice4    = Invoice.create!(status: 1, customer_id: @joel.id, merchant_id: @amazon.id)
        @invoice5    = Invoice.create!(status: 1, customer_id: @john.id, merchant_id: @amazon.id)
        @invoice6    = Invoice.create!(status: 1, customer_id: @john.id, merchant_id: @amazon.id)
        @invoice7    = Invoice.create!(status: 1, customer_id: @travolta.id, merchant_id: @amazon.id)
        @invoice8    = Invoice.create!(status: 1, customer_id: @travolta.id, merchant_id: @amazon.id)
        @invoice9    = Invoice.create!(status: 1, customer_id: @sal.id, merchant_id: @amazon.id)
        @invoice10   = Invoice.create!(status: 1, customer_id: @sal.id, merchant_id: @amazon.id)
        @invoice11   = Invoice.create!(status: 1, customer_id: @tim.id, merchant_id: @amazon.id)
        @invoice13   = Invoice.create!(status: 0, customer_id: @sally.id, merchant_id: @amazon.id)
        @invoice14   = Invoice.create!(status: 0, customer_id: @sally.id, merchant_id: @alibaba.id)
        @tx1         = Transaction.create!(result: "success", credit_card_number: 010001001022, credit_card_expiration_date: 20251001, invoice_id: @invoice2.id,)
        @tx2         = Transaction.create!(result: "success", credit_card_number: 010001005555, credit_card_expiration_date: 20220101, invoice_id: @invoice1.id,)
        @tx3         = Transaction.create!(result: "success", credit_card_number: 010001005551, credit_card_expiration_date: 20220101, invoice_id: @invoice3.id,)
        @tx4         = Transaction.create!(result: "success", credit_card_number: 010001005552, credit_card_expiration_date: 20220101, invoice_id: @invoice4.id,)
        @tx5         = Transaction.create!(result: "success", credit_card_number: 010001005553, credit_card_expiration_date: 20220101, invoice_id: @invoice5.id,)
        @tx6         = Transaction.create!(result: "success", credit_card_number: 010001005554, credit_card_expiration_date: 20220101, invoice_id: @invoice6.id,)
        @tx7         = Transaction.create!(result: "success", credit_card_number: 010001005550, credit_card_expiration_date: 20220101, invoice_id: @invoice7.id,)
        @tx8         = Transaction.create!(result: "success", credit_card_number: 010001005556, credit_card_expiration_date: 20220101, invoice_id: @invoice8.id,)
        @tx9         = Transaction.create!(result: "success", credit_card_number: 010001005557, credit_card_expiration_date: 20220101, invoice_id: @invoice9.id,)
        @tx10        = Transaction.create!(result: "success", credit_card_number: 010001005523, credit_card_expiration_date: 20220101, invoice_id: @invoice10.id,)
        @tx11        = Transaction.create!(result: "success", credit_card_number: 0100010055, credit_card_expiration_date: 20220101, invoice_id: @invoice11.id,)
        @tx12        = Transaction.create!(result: "failure", credit_card_number: 0100010055, credit_card_expiration_date: 20220101, invoice_id: @invoice14.id,)
        @discount_1 = Discount.create!(discount_percentage: 5, quantity_threshold: 10, merchant_id: @amazon.id)
        @discount_2 = Discount.create!(discount_percentage: 10, quantity_threshold: 15, merchant_id: @amazon.id)
        @discount_3 = Discount.create!(discount_percentage: 25, quantity_threshold: 20, merchant_id: @amazon.id)
    end
    it "I see a link to create a new discount " do
      visit merchant_discounts_path(@alibaba)
      # Then I see a link to create a new discount
      # When I click this link
      expect(page).to have_link("Create New Discount")
      click_link "Create New Discount"

      expect(current_path).to eq(new_merchant_discount_path(@alibaba))
      # Then I am taken to a new page where I see a form to add a new bulk discount
      # When I fill in the form with valid data
      # Then I am redirected back to the bulk discount index
      fill_in :discount_percentage, with: 30
      fill_in :quantity_threshold, with: 75
      click_on :submit
      # And I see my new bulk discount listed
      new_discount = @alibaba.discounts.last
      new_discount.merchant_id = @alibaba.id
      
      expect(current_path).to eq(merchant_discounts_path(@alibaba))

      expect(page).to have_content("Discount Percentage: #{new_discount.discount_percentage}")
      expect(page).to have_content("Quantity Threshold: #{new_discount.quantity_threshold}")
      expect(page).to have_link("Discount #{new_discount.id}")
    end
  end
end
# visit merchant_discounts_path(all_birds.id)
#
#

#
#
# new_merchant_discount = all_birds.discounts.last
#
# expect(new_merchant_discount.merchant_id).to eq(all_birds.id)
#
# expect(current_path).to eq(merchant_discounts_path(all_birds.id))
# expect(page).to have_content("Discount Percentage 15")
# expect(page).to have_content("Discount Percentage 20")
