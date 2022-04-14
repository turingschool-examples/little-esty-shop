require "rails_helper"
#   it "text" do
#     merchant = create(:merchant, enabled: false)  can control attributes by adding them in here after comma
#     merchants = create_list(:merchant, 5, merchant: merchant)
#     # item1 = create(:item, merchant: merchant)  to create one instance
#     # items = create_list(:item, 5, merchant: merchant) ==> creates multiple instances relationship for item belongs_to merchant.  Automatically assigns foreign key to that merchant
#     require "pry"; binding.pry
#   end
# end
RSpec.describe Merchant, type: :model do
  describe "relationships" do
    it { should have_many(:items) }
    it { should have_many(:invoice_items).through(:items) }
    it { should have_many(:invoices).through(:invoice_items) }
    it { should have_many(:customers).through(:invoices) }
    it { should have_many(:transactions).through(:invoices) }
  end

  describe "validations" do
    it { should validate_presence_of(:name) }
    it { should allow_value([true, false]).for(:enabled) }
    it { should_not allow_value(nil).for(:enabled) }
  end

  describe "methods" do
    it 'Finds all enabled or disabled merchants' do
      merchant_1 = create(:merchant)
      merchant_2 = Merchant.create!(name: "Doesn't matter", enabled: false)
      merchant_3 = create(:merchant)
      merchant_4 = create(:merchant)

      expect(Merchant.enabled_check(true)).to eq([merchant_1, merchant_3, merchant_4])
      expect(Merchant.enabled_check(false)).to eq([merchant_2])
    end
  end
      
end
