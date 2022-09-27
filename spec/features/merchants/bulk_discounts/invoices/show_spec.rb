require 'rails_helper'

RSpec.describe 'merchant invoice show page bulk discounts' do
  before :each do
    @merchant_1 = create(:merchant)
    @merchant_2 = create(:merchant)

    @item_1 = create(:item, merchant: @merchant_1)
    @item_2 = create(:item, merchant: @merchant_1)
    @item_3 = create(:item, merchant: @merchant_1)

    @item_4 = create(:item, merchant: @merchant_2)
    @item_5 = create(:item, merchant: @merchant_2)
    @item_6 = create(:item, merchant: @merchant_2)

    @invoice_1 = create(:invoice)
    @invoice_2 = create(:invoice)

    create(:transaction, invoice: @invoice_1, result: :success)

    @bulk_discount_1 = create(:bulk_discount, merchant: @merchant_1, discount: 0.25, threshold: 10)
    @bulk_discount_2 = create(:bulk_discount, merchant: @merchant_2, discount: 0.10, threshold: 5)

    create(:invoice_items, invoice_id: @invoice_1.id, item_id: @item_1.id, unit_price: 100, quantity: 10)
    create(:invoice_items, invoice_id: @invoice_1.id, item_id: @item_2.id, unit_price: 200, quantity: 20)
    create(:invoice_items, invoice_id: @invoice_1.id, item_id: @item_3.id, unit_price: 150, quantity: 5)

    create(:invoice_items, invoice_id: @invoice_2.id, item_id: @item_4.id, unit_price: 100, quantity: 10)
    create(:invoice_items, invoice_id: @invoice_2.id, item_id: @item_5.id, unit_price: 200, quantity: 20)
    create(:invoice_items, invoice_id: @invoice_2.id, item_id: @item_6.id, unit_price: 150, quantity: 5)
  end

  # As a merchant
  # When I visit my merchant invoice show page
  # Then I see the total revenue for my merchant from this invoice (not including discounts)
  # And I see the total discounted revenue for my merchant from this invoice which includes bulk discounts in the calculation

  describe 'User Story 6 - When I visit my merchant invoice show page' do
    it 'Then I see the total revenue for my merchant from this invoice (not including discounts)' do
      visit merchant_invoice_path(@merchant_1, @invoice_1)

      within "#invoice-revenue" do
        expect(page).to have_content(@invoice_1.items.total_revenue_of_all_items)
      end

      visit merchant_invoice_path(@merchant_2, @invoice_2)

      within "#invoice-revenue" do
        expect(page).to have_content(@invoice_2.items.total_revenue_of_all_items)
      end
    end

    it 'And I see the total discounted revenue for my merchant from this invoice which includes bulk discounts in the calculation' do
      visit merchant_invoice_path(@merchant_1, @invoice_1)

      within "#invoice-discounted-revenue" do
        expect(page).to have_content(@invoice_1.discount_revenue)
      end

      visit merchant_invoice_path(@merchant_2, @invoice_2)

      within "#invoice-discounted-revenue" do
        expect(page).to have_content(@invoice_2.discount_revenue)
      end
    end
  end
end