require 'rails_helper'

RSpec.describe 'the Merchant Invoices Index' do
  before :each do
    @merchants = create_list(:merchant, 2)
    
    @items_0 = create_list(:item, 10, merchant: @merchants[0]) #full call to customer @merchants[0].items[0].invoice_items[0].invoice.customer
    @items_1 = create_list(:item, 10, merchant: @merchants[1])

    @customers = create_list(:customer, 2)

    @invs_0 = create_list(:invoice, 3, customer: @customers[0]) #
    @invs_1 = create_list(:invoice, 2, customer: @customers[1])

    @inv_item_1 = create(:invoice_item, invoice: @invs_0[0], item: @items_0[0]) #this will always belong to @merchants[0]
    @inv_item_2 = create(:invoice_item, invoice: @invs_0[1], item: @items_0[1]) #this will always belong to @merchants[0]
    @inv_item_3 = create(:invoice_item, invoice: @invs_0[2], item: @items_0[2]) #this will always belong to @merchants[0]
    
    @inv_item_4 = create(:invoice_item, invoice: @invs_1[0], item: @items_1.sample) #this will always belong to @merchants[1]
    @inv_item_5 = create(:invoice_item, invoice: @invs_1[1], item: @items_1.sample) #this will always belong to @merchants[1]
    
    # visit "/merchants/#{@merchants[0].id}/invoices"
  end
  
  describe 'as a merchant' do
    xit 'shows all invoices that include the merchants items' do
      expect(page).to have_content(@invs_0[0].id)
      expect(page).to have_content(@invs_0[1].id)
      expect(page).to have_content(@invs_0[2].id)

      expect(page).to_not have_content(@invs_1[0].id)
      expect(page).to_not have_content(@invs_2[1].id)
    end
  end


end