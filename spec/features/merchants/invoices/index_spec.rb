require 'rails_helper'

RSpec.describe 'the Merchant Invoices Index' do
  before :each do
    @merchants = create_list(:merchant, 2)
    
    @items_0 = create_list(:item, 10, merchant: @merchants[0])
    @items_1 = create_list(:item, 10, merchant: @merchants[1])

    @customers = create_list(:customer, 2)

    @invs_0 = create_list(:invoice, 3, customer: @customers[0])
    @invs_1 = create_list(:invoice, 2, customer: @customers[1])

    @inv_item_1 = create(:invoice_item, invoice: @invs_0.sample, item: @items_0.sample) #this will always belong to @merchants[0]
    @inv_item_2 = create(:invoice_item, invoice: @invs_0.sample, item: @items_0.sample) #this will always belong to @merchants[0]
    @inv_item_3 = create(:invoice_item, invoice: @invs_0.sample, item: @items_0.sample) #this will always belong to @merchants[0]
    
    @inv_item_4 = create(:invoice_item, invoice: @invs_1.sample, item: @items_1.sample) #this will always belong to @merchants[1]
    @inv_item_5 = create(:invoice_item, invoice: @invs_1.sample, item: @items_1.sample) #this will always belong to @merchants[1]

    visit "/merchants/#{@merchants[0].id}/invoices"
  end
  
  it 'shows all invoices that include the merchants items' do
    
  end


end