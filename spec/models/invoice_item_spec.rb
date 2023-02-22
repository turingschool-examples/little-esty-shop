require 'rails_helper'

RSpec.describe InvoiceItem, type: :model do
  describe 'relationships' do 
    it { should belong_to :item }
    it { should belong_to :invoice }
  end

  describe 'enums tests' do
    before do 
      @customer1 = Customer.create!(first_name: "Joe", last_name: "Shmow", uuid: 55)
      @invoice1 = @customer1.invoices.create!(uuid: 1)

      @merchant1 = Merchant.create!(name: "Frisbees Galore", uuid: 2)
      @item1 = @merchant1.items.create!(name: "Golf Disc", description: "A hole in one every time!", unit_price: 1000, uuid: 3 )

      @inv_item1 = InvoiceItem.create!(item_id: @item1.id, invoice_id: @invoice1.id, quantity: 1, unit_price: 1500, uuid: 4)
    end

    it "can return a status of 'pending' by default and can change" do 
      expect(@inv_item1.status).to eq("pending")

      @inv_item1.status = 1
      expect(@inv_item1.status).to eq("packaged")
    
      @inv_item1.status = 2
      expect(@inv_item1.status).to eq("shipped")
    end
  end
end
