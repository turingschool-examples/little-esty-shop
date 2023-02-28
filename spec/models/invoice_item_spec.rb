require 'rails_helper'

RSpec.describe InvoiceItem, type: :model do
  before(:each) do
    @merchant = Merchant.create!(name: "Cabbage Merchant")
    @dis_gai_ovah_hea = Customer.create!(first_name: "Dis", last_name: "Gai")
    
    @item1 = @merchant.items.create!(name: "Ramen Noodles", description: "A dang good pack-a ramen", unit_price: 99)
    @item2 = @merchant.items.create!(name: "Cabbages", description: "NOT MY CABBAGES!!!", unit_price: 500)
    @item3 = @merchant.items.create!(name: "Freesh Avacadoo", description: "Cream Freesh", unit_price: 200)
    
    @invoice1 = Invoice.create!(customer_id: @dis_gai_ovah_hea.id, status: 0 )
    @invoice2 = Invoice.create!(customer_id: @dis_gai_ovah_hea.id, status: 0 )
    @invoice3 = Invoice.create!(customer_id: @dis_gai_ovah_hea.id, status: 2 ) 
    
    @inv_it_1 = InvoiceItem.create!(item_id: @item1.id, invoice_id: @invoice1.id, quantity: 100, unit_price: 100, status: 0 )
    @inv_it_2 = InvoiceItem.create!(item_id: @item2.id, invoice_id: @invoice2.id, quantity: 100, unit_price: 475, status: 1 )
    @inv_it_3 = InvoiceItem.create!(item_id: @item3.id, invoice_id: @invoice3.id, quantity: 100, unit_price: 225, status: 2 )
  end

  describe "Relationships" do
    it { should belong_to :invoice }
    it { should belong_to :item }
  end
end
