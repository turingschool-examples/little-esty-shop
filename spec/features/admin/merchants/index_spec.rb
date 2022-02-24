require 'rails_helper'

RSpec.describe 'Admin Merchants Index' do
  describe 'user story #17' do
    it "when visiting /admin/merchants I see the name of each merchant" do
      merchant_1 = Merchant.create!(name: "LT's Tee Shirts LLC")
      merchant_2 = Merchant.create!(name: 'Handmade in CO Co.', status: 1)
      merchant_3 = Merchant.create!(name: 'Moss Box Inc')

      visit "/admin/merchants"

      expect(page).to have_content("LT's Tee Shirts LLC")
      expect(page).to have_content('Handmade in CO Co.')
      expect(page).to have_content('Moss Box Inc')
    end
  end

  describe 'user story #14 and User story #13' do
    before :each do
      @merchant_1 = Merchant.create!(name: "LT's Tee Shirts LLC")
      @merchant_2 = Merchant.create!(name: 'Handmade in CO Co.', status: 1)

      visit "/admin/merchants"
    end

    it "enable/disable button next to each merchant - toggles status" do
      within("#enabled") do
        click_button("Disable")
        expect(current_path).to eq("/admin/merchants")
      end

      within("#disabled") do
        expect(page).to have_content(@merchant_1.name)
      end

      within("#disabled_merchant-#{@merchant_1.id}") do
        click_button("Enable")
        expect(current_path).to eq("/admin/merchants")
      end

      within("#enabled") do
        expect(page).to have_content(@merchant_1.name)
      end
    end
  end

  # describe 'user story #11' do
  #   before :each do
  #     @merchant_1 = Merchant.create!(name: "LT's Tee Shirts LLC", status: 0)
  #     @merchant_2 = Merchant.create!(name: 'Handmade in CO Co.', status: 1)
  #     @merchant_3 = Merchant.create!(name: 'Happy Crafts', status: 1)
  #
  #     @item_1 = @merchant_1.items.create!(name: "Green Shirt", description: "A shirt what's green", unit_price: 25)
  #     @item_2 = @merchant_1.items.create!(name: "Red Shirt", description: "A shirt what's red", unit_price: 25)
  #     @item_3 = @merchant_1.items.create!(name: "Blue Shirt", description: "A shirt what's blue", unit_price: 25)
  #     @item_4 = @merchant_2.items.create!(name: "CO Flag Art", description: "Sculpture", unit_price: 1000)
  #     @item_5 = @merchant_2.items.create!(name: "John Denver Portrait", description: "Painting", unit_price: 3000)
  #
  #     @customer_1 = Customer.create!(first_name: "Paul", last_name: "Atreides")
  #     @customer_2 = Customer.create!(first_name: "Baron", last_name: "Harkonnen")
  #     @customer_3 = Customer.create!(first_name: "Reverend", last_name: "Mother")
  #
  #     @invoice_1 = @customer_1.invoices.create!(status: 1, created_at: '2012-03-25 09:54:09')
  #     @invoice_2 = @customer_2.invoices.create!(status: 1, created_at: '2012-03-25 09:54:09')
  #     @invoice_3 = @customer_3.invoices.create!(status: 1, created_at: '2012-03-25 09:54:09')
  #
  #     @invoice_item_1 = InvoiceItem.create!(item_id: @item_1.id, invoice_id: @invoice_1.id, unit_price: 25, quantity: 5, status: 0)
  #     @invoice_item_2 = InvoiceItem.create!(item_id: @item_2.id, invoice_id: @invoice_1.id, unit_price: 25, quantity: 2, status: 0)
  #     @invoice_item_3 = InvoiceItem.create!(item_id: @item_3.id, invoice_id: @invoice_2.id, unit_price: 25, quantity: 2, status: 0)
  #     @invoice_item_4 = InvoiceItem.create!(item_id: @item_4.id, invoice_id: @invoice_2.id, unit_price: 1000, quantity: 1, status: 0)
  #     @invoice_item_5 = InvoiceItem.create!(item_id: @item_5.id, invoice_id: @invoice_3.id, unit_price: 3000, quantity: 1, status: 0)
  #
  #     @transaction_1 = @invoice_1.transactions.create!(credit_card_number: 4654405418249632, result: 'success')
  #     @transaction_1 = @invoice_2.transactions.create!(credit_card_number: 4654405418249633, result: 'success')
  #     @transaction_1 = @invoice_3.transactions.create!(credit_card_number: 4654405418249633, result: 'success' )
  #   end
  #
  #   it 'visitor sees list of top 5 merchants ordered by total revenue' do
  #
  #     first = find("#top_merchant-#{@merchant_2.id}")
  #     second = find("#top_merchant-#{@merchant_1.id}")
  #     third = find("#top_merchant-#{@merchant_3.id}")
  #     expect(first).to appear_before(second)
  #     expect(second).to appear_before(third)
  #   end
  #
  #   it 'top 5 merchant names as links to their show pages' do
  #
  #     within "#top_merchant-#{@merchant_1.id}" do
  #       expect(page).to have_link("#{@merchant_1.name}", href: admin_merchant_path(@merchant_1.id))
  #     end
  #
  #     within "#top_merchant-#{@merchant_2.id}" do
  #       expect(page).to have_link("#{@merchant_2.name}", href: admin_merchant_path(@merchant_2.id))
  #     end
  #
  #     within "#top_merchant-#{@merchant_3.id}" do
  #       expect(page).to have_link("#{@merchant_3.name}", href: admin_merchant_path(@merchant_3.id))
  #     end
  #   end
  # end
end
