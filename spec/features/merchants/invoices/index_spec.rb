require 'rails_helper'

RSpec.describe 'Merchant Invoice Index' do
  before :each do
    @merchant_1 = create(:merchant)
    @merchant_2 = create(:merchant)
    @merchant_3 = create(:merchant)

    @items_1 = create_list(:item, 10, merchant: @merchant_1)
    @items_2 = create_list(:item, 10, merchant: @merchant_1)
    @items_3 = create_list(:item, 10, merchant: @merchant_2)
    @items_4 = create_list(:item, 10, merchant: @merchant_2)
    @items_5 = create_list(:item, 10, merchant: @merchant_2)
    @items_6 = create_list(:item, 10, merchant: @merchant_2)
    @items_7 = create_list(:item, 10, merchant: @merchant_2)
    @items_8 = create_list(:item, 10, merchant: @merchant_3)

    @invoice_1 = create(:invoice)
    @invoice_2 = create(:invoice)
    @invoice_3 = create(:invoice)
    @invoice_4 = create(:invoice)

    @items_1.each { |item| create(:invoice_items, item: item, invoice: @invoice_1) }
    @items_2.each { |item| create(:invoice_items, item: item, invoice: @invoice_2) }
    @items_3.each { |item| create(:invoice_items, item: item, invoice: @invoice_3) }
    @items_4.each { |item| create(:invoice_items, item: item, invoice: @invoice_4) }
    @items_5.each { |item| create(:invoice_items, item: item, invoice: @invoice_1) }
    @items_6.each { |item| create(:invoice_items, item: item, invoice: @invoice_2) }
    @items_7.each { |item| create(:invoice_items, item: item, invoice: @invoice_3) }
    @items_8.each { |item| create(:invoice_items, item: item, invoice: @invoice_4) }
  end
  # As a merchant,
  # When I visit my merchant's invoices index (/merchants/merchant_id/invoices)
  # Then I see all of the invoices that include at least one of my merchant's items
  # And for each invoice I see its id
  # And each id links to the merchant invoice show page

  describe 'User Story 14 - visit my merchants invoices index (/merchants/merchant_id/invoices)'do
    it 'Then I see all of the invoices that include at least one of my merchants items' do
      visit merchant_invoices_path(@merchant_1)

      within "#merchant-invoices" do
        expect(page).to have_content(@invoice_1.id)
        expect(page).to have_content(@invoice_2.id)
        expect(page).to_not have_content(@invoice_3.id)
        expect(page).to_not have_content(@invoice_4.id)
      end

      visit merchant_invoices_path(@merchant_2)

      within "#merchant-invoices" do
        expect(page).to have_content(@invoice_1.id)
        expect(page).to have_content(@invoice_2.id)
        expect(page).to have_content(@invoice_3.id)
        expect(page).to have_content(@invoice_4.id)
      end

      visit merchant_invoices_path(@merchant_3)

      within "#merchant-invoices" do
        expect(page).to_not have_content(@invoice_1.id)
        expect(page).to_not have_content(@invoice_2.id)
        expect(page).to_not have_content(@invoice_3.id)
        expect(page).to have_content(@invoice_4.id)
      end
    end

    it 'And each id links to the merchant invoice show page' do
      visit merchant_invoices_path(@merchant_1)
      within "#merchant-invoices" do
        click_on "#{@invoice_1.id}"
        expect(current_path).to eq(merchant_invoice_path(@merchant_1, @invoice_1))
      end

      visit merchant_invoices_path(@merchant_2)
      within "#merchant-invoices" do
        click_on "#{@invoice_3.id}"
        expect(current_path).to eq(merchant_invoice_path(@merchant_2, @invoice_3))
      end

      visit merchant_invoices_path(@merchant_3)
      within "#merchant-invoices" do
        click_on "#{@invoice_4.id}"
        expect(current_path).to eq(merchant_invoice_path(@merchant_3, @invoice_4))
      end
    end
  end
end