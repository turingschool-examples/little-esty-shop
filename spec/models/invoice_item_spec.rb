require "rails_helper"

RSpec.describe InvoiceItem, type: :model do
  before :each do
    @customer1 = Customer.create(first_name: "Joe", last_name: "Smith")
    @merchant1 = Merchant.create(name: "Pawtrait Designs")
    @item1 = @merchant1.items.create(name: "Puppy Portrait",
                                     description: "Wall art of your favorite pup",
                                     unit_price: 10.99)
    @item2 = @merchant1.items.create(name: "Kitty Portrait",
                                     description: "5x7 of your favorite cat",
                                     unit_price: 6.99)
    @item3 = @merchant1.items.create(name: "Pet Portrait",
                                     description: "8x10 of all your favorite pets",
                                     unit_price: 8.99)
    @invoice1 = @customer1.invoices.create(status: 0)
    @invoice2 = @customer1.invoices.create(status: 1)
    @invoice3 = @customer1.invoices.create(status: 2)
    @invoice_item1 = InvoiceItem.create(item_id: @item1.id,
                                        invoice_id: @invoice1.id,
                                        quantity: 100,
                                        unit_price: 10.99,
                                        status: 0)
    @invoice_item2 = InvoiceItem.create(item_id: @item1.id,
                                        invoice_id: @invoice1.id,
                                        quantity: 100,
                                        unit_price: 10.99,
                                        status: 2)
    @invoice_item3 = InvoiceItem.create(item_id: @item2.id,
                                        invoice_id: @invoice2.id,
                                        quantity: 500,
                                        unit_price: 6.99,
                                        status: 1)
  end

  describe "relationships" do
    it {should belong_to :invoice}
    it {should belong_to :item}
  end

  describe "different invoice item statuses" do
    it 'can display in pending' do
      expect(@invoice_item1.status).to eq("pending")
      expect(@invoice_item1.status).to_not eq("packaged")
      expect(@invoice_item1.status).to_not eq("shipped")
    end
    it 'can display packaged' do
      expect(@invoice_item3.status).to eq("packaged")
      expect(@invoice_item3.status).to_not eq("pending")
      expect(@invoice_item3.status).to_not eq("shipped")
    end
    it 'can display shipped' do
      expect(@invoice_item2.status).to eq("shipped")
      expect(@invoice_item2.status).to_not eq("packaged")
      expect(@invoice_item2.status).to_not eq("pending")
    end
  end
end
