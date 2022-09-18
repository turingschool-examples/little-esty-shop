require 'rails_helper'

RSpec.describe 'Merchant Invoice Show Page' do 
  before :each do
    @merchant_1 = create(:merchant)
    @merchant_2 = create(:merchant)

    @items_1 = create_list(:item, 5, merchant: @merchant_1)
    @items_2 = create_list(:item, 5, merchant: @merchant_2)

    @invoice_1 = create(:invoice)
    @invoice_2 = create(:invoice)

    @items_1.each { |item|  @invoice_1.items << item }
    @items_2.each { |item|  @invoice_2.items << item }
  end

  # As a merchant
  # When I visit my merchant's invoice show page(/merchants/merchant_id/invoices/invoice_id)
  # Then I see information related to that invoice including:

  # Invoice id
  # Invoice status
  # Invoice created_at date in the format "Monday, July 18, 2019"
  # Customer first and last name

  describe 'User Story 15 - When I visit my merchants invoice show page' do 
    it 'Then I see information related to that invoice' do
      visit merchant_invoice_path(@merchant_1, @invoice_1)

      within("#invoice-info") do
        expect(page).to have_content(@invoice_1.id)
        expect(page).to have_content(@invoice_1.status)
        expect(page).to have_content(@invoice_1.created_at.strftime("%A, %B %d, %Y"))
        expect(page).to have_content(@invoice_1.customer.first_name)
        expect(page).to have_content(@invoice_1.customer.last_name )
        expect(page).to_not have_content(@invoice_2.id)
        expect(page).to_not have_content(@invoice_2.customer.first_name)
        expect(page).to_not have_content(@invoice_2.customer.last_name )
      end

      visit merchant_invoice_path(@merchant_2, @invoice_2)

      within("#invoice-info") do
        expect(page).to have_content(@invoice_2.id)
        expect(page).to have_content(@invoice_2.status)
        expect(page).to have_content(@invoice_2.created_at.strftime("%A, %B %d, %Y"))
        expect(page).to have_content(@invoice_2.customer.first_name)
        expect(page).to have_content(@invoice_2.customer.last_name )
        expect(page).to_not have_content(@invoice_1.id)
        expect(page).to_not have_content(@invoice_1.customer.first_name)
        expect(page).to_not have_content(@invoice_1.customer.last_name )
      end
    end

    it '' do
      
    end
  end
end