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
    
    @bulk_discount_1 = create(:bulk_discount, merchant: @merchant_1, discount: 0.25, threshold: 10)
    @bulk_discount_2 = create(:bulk_discount, merchant: @merchant_2, discount: 0.10, threshold: 5)

    create(:invoice_items, invoice_id: @invoice_1.id, item_id: @item_1.id, unit_price: 100, quantity: 10)
    create(:invoice_items, invoice_id: @invoice_1.id, item_id: @item_2.id, unit_price: 200, quantity: 20)
    create(:invoice_items, invoice_id: @invoice_1.id, item_id: @item_3.id, unit_price: 150, quantity: 5)

    create(:invoice_items, invoice_id: @invoice_1.id, item_id: @item_4.id, unit_price: 100, quantity: 10)
    create(:invoice_items, invoice_id: @invoice_1.id, item_id: @item_5.id, unit_price: 200, quantity: 20)
    create(:invoice_items, invoice_id: @invoice_1.id, item_id: @item_6.id, unit_price: 150, quantity: 5)
  end

  # As a merchant
  # When I visit my merchant invoice show page
  # Then I see the total revenue for my merchant from this invoice (not including discounts)
  # And I see the total discounted revenue for my merchant from this invoice which includes bulk discounts in the calculation

  describe 'User Story 6 - When I visit my merchant invoice show page' do
    it 'Then I see the total revenue for my merchant from this invoice (not including discounts)' do
      visit merchant_invoice_path(@merchant_1, @invoice_1)

      within "#invoice-merchant-revenue" do
        expect(page).to have_content(@invoice_1.total_revenue_merchant(@merchant_1.id))
      end

      visit merchant_invoice_path(@merchant_2, @invoice_1)
      
      within "#invoice-merchant-revenue"  do
        expect(page).to have_content(@invoice_1.total_revenue_merchant(@merchant_2.id))
      end
    end

    it 'And I see the total discounted revenue for my merchant from this invoice which includes bulk discounts in the calculation' do
      visit merchant_invoice_path(@merchant_1, @invoice_1)

      within "#invoice-discounted-revenue" do
        expect(page).to have_content(@invoice_1.revenue_with_discount(@merchant_1.id))
      end

      visit merchant_invoice_path(@merchant_2, @invoice_1)

      within "#invoice-discounted-revenue" do
        expect(page).to have_content(@invoice_1.revenue_with_discount(@merchant_2.id))
      end
    end
  end

  # As a merchant
  # When I visit my merchant invoice show page
  # Next to each invoice item I see a link to the show page for the bulk discount that was applied (if any)

  describe 'User Story 7 - When I visit my merchant invoice show page' do
    it 'Next to each invoice item I see a link to the show page for the bulk discount that was applied (if any)' do
      # visit merchant_invoice_path(@merchant_1, @invoice_1)

      # within "#invoice-items-info" do
      #   find_link({text: "#{@item_1.name} Bulk Discount Page", href: merchant_bulk_discount_path(@merchant_1, @bulk_discount_1)}).visible?
      #   find_link({text: "#{@item_2.name} Bulk Discount Page", href: merchant_bulk_discount_path(@merchant_1, @bulk_discount_1)}).visible?
      # end

      # visit merchant_invoice_path(@merchant_2, @invoice_2)

      # within "#invoice-items-info" do
      #   find_link({text: "#{@item_4.name} Bulk Discount Page", href: merchant_bulk_discount_path(@merchant_2, @bulk_discount_2)}).visible?
      #   find_link({text: "#{@item_5.name} Bulk Discount Page", href: merchant_bulk_discount_path(@merchant_2, @bulk_discount_2)}).visible?
      #   find_link({text: "#{@item_6.name} Bulk Discount Page", href: merchant_bulk_discount_path(@merchant_2, @bulk_discount_2)}).visible?
      # end
    end
  end
end