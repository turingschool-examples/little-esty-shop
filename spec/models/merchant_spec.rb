require "rails_helper"

RSpec.describe Merchant, type: :model do
  describe "relationships" do
    it { should have_many :items }
  end

  describe "validations" do
    it { should validate_presence_of(:name) }
  end


  describe 'instance methods' do 
    describe '.items_ready_to_ship' do 
      it 'returns invoice_items of a merchant with status other than shipped' do 
        @merchant1 = Merchant.create!(name: "Schroeder-Jerde")
        @item1 = @merchant1.items.create!(name: "Item Qui Esse", description: "Nihil autem sit odio inventore deleniti. Est lauda...", unit_price: 75107)
        @item2 = @merchant1.items.create!(name: "Item Autem Minima", description: "Cumque consequuntur ad. Fuga tenetur illo molestia...", unit_price: 67076)
        @item3 = @merchant1.items.create!(name: "Item Ea Voluptatum", description: "Sunt officia eum qui molestiae. Nesciunt quidem cu...", unit_price: 32301)
        @customer1 = Customer.create!(first_name: "Joey", last_name: "Ondricka")
        @invoice1 = Invoice.create!(customer_id: @customer1.id, status: "cancelled")
        @invoice2 = Invoice.create!(customer_id: @customer1.id, status: "in progress")
        @invoice_item1 = InvoiceItem.create!(item_id: @item1.id, invoice_id: @invoice1.id, quantity: 1, unit_price: 75100, status: "shipped",)
        @invoice_item2 = InvoiceItem.create!(item_id: @item2.id, invoice_id: @invoice2.id, quantity: 3, unit_price: 200000, status: "packaged",)
        @invoice_item3 = InvoiceItem.create!(item_id: @item3.id, invoice_id: @invoice2.id, quantity: 1, unit_price: 32301, status: "pending",)


        expect(@merchant1.items_ready_to_ship).to eq([@invoice_item2, @invoice_item3])
      end 
    end
  end
end
