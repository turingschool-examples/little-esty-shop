require 'rails_helper'

RSpec.describe 'Admin::Invoice Index' do
  before(:each) do
    @customer1 = create(:customer)
    @customer2 = create(:customer)
    @customer3 = create(:customer)
    @customer4 = create(:customer)
    @customer5 = create(:customer)
    @customer6 = create(:customer)
    
    @invoice1 = create(:invoice, customer_id: @customer1.id)
    @invoice2 = create(:invoice, customer_id: @customer2.id)
    @invoice3 = create(:invoice, customer_id: @customer3.id)
    @invoice4 = create(:invoice, customer_id: @customer4.id)
    @invoice5 = create(:invoice, customer_id: @customer5.id)
    @invoice6 = create(:invoice, customer_id: @customer6.id)

    @merchant = create(:merchant)

    @item1 = create(:item, merchant_id: @merchant.id)
    @item2 = create(:item, merchant_id: @merchant.id)

    @invoice_item1 = create(:invoice_item, item_id: @item1.id, invoice_id: @invoice1.id, status: 0)
    @invoice_item2 = create(:invoice_item, item_id: @item1.id, invoice_id: @invoice2.id, status: 0)
    @invoice_item3 = create(:invoice_item, item_id: @item1.id, invoice_id: @invoice3.id, status: 1)
    @invoice_item4 = create(:invoice_item, item_id: @item2.id, invoice_id: @invoice4.id, status: 1)
    @invoice_item5 = create(:invoice_item, item_id: @item2.id, invoice_id: @invoice5.id, status: 2)
    @invoice_item6 = create(:invoice_item, item_id: @item2.id, invoice_id: @invoice6.id, status: 0)


    @transaction1 = create(:transaction, invoice_id: @invoice1.id)
    @transaction2 = create(:transaction, invoice_id: @invoice1.id)
    @transaction3 = create(:transaction, invoice_id: @invoice2.id)
    @transaction4 = create(:transaction, invoice_id: @invoice3.id)
    @transaction5 = create(:transaction, invoice_id: @invoice4.id)
    @transaction6 = create(:transaction, invoice_id: @invoice5.id)
    @transaction7 = create(:transaction, invoice_id: @invoice6.id)

    visit '/admin/invoices'
  end

  describe 'Admin Invoices Index Page' do

    #     As an admin,
    # When I visit the admin Invoices index ("/admin/invoices")
    # Then I see a list of all Invoice ids in the system
    # Each id links to the admin invoice show page
    it 'has a list of all invoice ids' do

      expect(page).to have_content(@invoices1.id)
      expect(page).to have_content(@invoices2.id)
      expect(page).to have_content(@invoices3.id)
      expect(page).to have_content(@invoices4.id)
      expect(page).to have_content(@invoices5.id)
      expect(page).to have_content(@invoices6.id)
     
    end
  end
end