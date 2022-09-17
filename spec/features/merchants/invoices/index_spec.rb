require 'rails_helper'

RSpec.describe 'Merchant Invoice Index' do
  before :each do
    @merchant_1 = create(:merchant)
    @merchant_2 = create(:merchant)

    @items_1 = create_list(:item, 10, merchant: @merchant_1)
    @items_2 = create_list(:item, 5, merchant: @merchant_1)
    @items_3 = create_list(:item, 10, merchant: @merchant_2)
    @items_4 = create_list(:item, 5, merchant: @merchant_2)

    @invoice_1 = create(:invoice)
    @invoice_2 = create(:invoice)
    @invoice_3 = create(:invoice)
    @invoice_4 = create(:invoice)

    @items_1.each { |item|  @invoice_1.items << item }
    @items_2.each { |item|  @invoice_2.items << item }
    @items_3.each { |item|  @invoice_3.items << item }
    @items_4.each { |item|  @invoice_4.items << item }
  end
  # As a merchant,
  # When I visit my merchant's invoices index (/merchants/merchant_id/invoices)
  # Then I see all of the invoices that include at least one of my merchant's items
  # And for each invoice I see its id
  # And each id links to the merchant invoice show page

  describe 'User Story 14 - visit my merchants invoices index (/merchants/merchant_id/invoices)'do
    it 'Then I see all of the invoices that include at least one of my merchants items' do
      visit merchant_invoices_path(@merchant_1)

      expect(page).to have_content(@invoice_1.id)
      expect(page).to have_content(@invoice_2.id)
      
    end

    it 'And for each invoice I see its id' do

    end

    it 'And each id links to the merchant invoice show page' do

    end
  end
end