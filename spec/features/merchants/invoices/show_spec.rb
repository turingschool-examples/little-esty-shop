require 'rails_helper'

RSpec.describe "Merchant_Invoices#Show", type: :feature do
  before(:each) do
    @merchant = create(:merchant)
    @merchant_2 = create(:merchant)

    @customer_1 = create(:customer)
    @customer_2 = create(:customer)
    @customer_3 = create(:customer)
    @customer_4 = create(:customer)
    @customer_5 = create(:customer)
    @customer_6 = create(:customer)

    @invoice_1 = create(:invoice, customer_id: @customer_1.id, created_at: Date.new(2023,1,1), status: "in progress")
    @invoice_2 = create(:invoice, customer_id: @customer_1.id, created_at: Date.new(2023,2,1), status: "cancelled")
    @invoice_3 = create(:invoice, customer_id: @customer_1.id, created_at: Date.new(2023,3,1), status: "completed")

    @item_1 = create(:item, merchant: @merchant)
    @item_2 = create(:item, merchant: @merchant)
    @item_3 = create(:item, merchant: @merchant)
    @item_4 = create(:item, merchant: @merchant)
    @item_5 = create(:item, merchant: @merchant)
    @item_6 = create(:item, merchant: @merchant_2)

    @invoice_item_1 = create(:invoice_item, item: @item_1, invoice: @invoice_1, quantity: 1, status: "packaged", created_at: Date.new(2023,1,1))
    @invoice_item_2 = create(:invoice_item, item: @item_2, invoice: @invoice_1, quantity: 2, status: "packaged", created_at: Date.new(2023,1,2))
    @invoice_item_3 = create(:invoice_item, item: @item_3, invoice: @invoice_1, quantity: 3, status: "packaged", created_at: Date.new(2023,1,3))
    @invoice_item_4 = create(:invoice_item, item: @item_4, invoice: @invoice_1, quantity: 4, status: "packaged", created_at: Date.new(2023,1,4))
    @invoice_item_5 = create(:invoice_item, item: @item_5, invoice: @invoice_1, quantity: 5, status: "packaged", created_at: Date.new(2023,1,5))
    @invoice_item_6 = create(:invoice_item, item: @item_6, invoice: @invoice_2, quantity: 100000, status: "shipped", created_at: Date.new(2023,1,6))

    create(:transaction, invoice_id: @invoice_1.id, result: 0)
    create(:transaction, invoice_id: @invoice_1.id, result: 0)
    create(:transaction, invoice_id: @invoice_1.id, result: 0)
    create(:transaction, invoice_id: @invoice_1.id, result: 0)
    create(:transaction, invoice_id: @invoice_1.id, result: 0)
    create(:transaction, invoice_id: @invoice_2.id, result: 0)
    
    visit "/merchants/#{@merchant.id}/invoices/#{@invoice_1.id}"
  end

  describe "User Story 15" do
    context "As a merchant, when I visit my merchant's invoices show" do
      it "I see the attribute information related to that invoice" do
        expect(page).to have_content(@invoice_1.id)
        expect(page).to_not have_content(@invoice_2.id)

        within("#merchant_invoice_information") do
          expect(page).to have_content(@invoice_1.status)
          expect(page).to have_content(@invoice_1.created_at.strftime("%A, %B %-d, %Y"))
          expect(page).to_not have_content(@invoice_2.status)
          expect(page).to_not have_content(@invoice_2.created_at.strftime("%A, %B %-d, %Y"))
        end
      end

      it "I see the attribute information related to_not that invoice" do
        
        within("#merchant_invoice_customer_info") do
          expect(page).to have_content(@customer_1.first_name)
          expect(page).to have_content(@customer_1.last_name)
          expect(page).to_not have_content(@customer_2.first_name)
          expect(page).to_not have_content(@customer_2.last_name)
        end
      end
    end
  end

  describe "User Story 16" do
    context "As a merchant, when I visit my merchant's invoices show" do
      it " I see all of my items on the invoice" do
        
        save_and_open_page
        within("#invoice_item_#{@invoice_item_1.id}") do
          expect(page).to have_content(@item_1.name)
          expect(page).to have_content(@invoice_item_1.quantity)
          expect(page).to have_content(@invoice_item_1.unit_price)
          expect(page).to have_content(@invoice_item_1.status)
          expect(page).to_not have_content(@item_6.name)
          expect(page).to_not have_content(@invoice_item_6.quantity)
          expect(page).to_not have_content(@invoice_item_6.unit_price)
          expect(page).to_not have_content(@invoice_item_6.status)
        end
      end
    end
  end
end