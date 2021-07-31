require 'rails_helper'

RSpec.describe 'Admin Invoice Show Page' do
  before(:each) do
    @customer = create(:customer)
    
    @invoice = create(:invoice, customer_id: @customer.id)

    @merchant = create(:merchant)

    @item1 = create(:item, merchant_id: @merchant.id)
    @item2 = create(:item, merchant_id: @merchant.id)

    @invoice_item1 = create(:invoice_item, item_id: @item1.id, invoice_id: @invoice.id, status: 0)
    @invoice_item2 = create(:invoice_item, item_id: @item1.id, invoice_id: @invoice.id, status: 0)
    @invoice_item3 = create(:invoice_item, item_id: @item1.id, invoice_id: @invoice.id, status: 1)
    @invoice_item4 = create(:invoice_item, item_id: @item2.id, invoice_id: @invoice.id, status: 1)
    @invoice_item5 = create(:invoice_item, item_id: @item2.id, invoice_id: @invoice.id, status: 2)
    @invoice_item6 = create(:invoice_item, item_id: @item2.id, invoice_id: @invoice.id, status: 0)


    @transaction1 = create(:transaction, invoice_id: @invoice.id)
    @transaction2 = create(:transaction, invoice_id: @invoice.id)
    @transaction3 = create(:transaction, invoice_id: @invoice.id)
    @transaction4 = create(:transaction, invoice_id: @invoice.id)
    @transaction5 = create(:transaction, invoice_id: @invoice.id)
    @transaction6 = create(:transaction, invoice_id: @invoice.id)
    @transaction7 = create(:transaction, invoice_id: @invoice.id)

    visit admin_invoice_path(@invoice.id)
  end 

  describe 'Admin Invoice Show Page' do
    it 'Displays an Invoice and its attributes' do

      expect(page).to have_content(@invoice.id)  
      expect(page).to have_content(@invoice.status)  
      expect(page).to have_content(@invoice.created_at.strftime("%A, %B, %d, %Y"))  
      expect(page).to have_content("#{@customer.first_name} #{@customer.last_name}")  
    end  
  end

  describe 'Admin Invoice Show Page: Invoice Item Information' do

    #     As an admin
    # When I visit an admin invoice show page
    # Then I see all of the items on the invoice including:

    # Item name
    # The quantity of the item ordered
    # The price the Item sold for
    # The Invoice Item status

    it 'It displays Invoice Item attributes' do

      expect(page).to have_content(@item1.name)
      expect(page).to have_content(@invoice_item1.quantity)
      expect(page).to have_content(@item1.unit_price)
      expect(page).to have_content(@invoice_item.status)
    end
  end
end