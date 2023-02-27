require 'rails_helper'

RSpec.describe Item, type: :model do
  it { should belong_to :merchant } 
  it { should have_many :invoice_items }
  it { should have_many :invoices }
  it { should validate_presence_of :name}
  it { should validate_presence_of :description}
  it { should validate_presence_of :unit_price }

  before do
    @cool_dude = Merchant.create!(name: "Cool Dude's Trippy Emporium")
  end
  
  describe '#create_new_item()' do
    it "creates a new item in the database assigned to a specific merchant" do 
      item_params = {
        name: "Marijuana Tapestry",
        description: "Crushed velvet, 51.2 x 59.1 inches",
        unit_price: 7110,
        merchant_id: @cool_dude.id
      }
      expect(Item.create_new_item(item_params)).to eq(@cool_dude.items.last)
    end
  end
end
