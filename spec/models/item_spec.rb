require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'relationships' do
    it {should belong_to :merchant}
    it {should have_many :invoice_items}
    it {should have_many(:invoices).through(:invoice_items)}
  end

  describe 'validations' do
    it {should validate_presence_of(:name)}
    it {should validate_presence_of(:description)}
    it {should validate_presence_of(:unit_price)}
  end

  describe "instance variable" do
    it "#change_status will change the status of the item" do
      @merchant1 = Merchant.create!(name: 'Merchant1')
      @item1 = @merchant1.items.create!(name: 'Item1', description: 'Description1', unit_price: 111)
      visit "/merchants/#{@merchant1.id}/items"

      expect(@item1.status).to eq("enabled")
      click_on "Disable"
      binding.pry
      expect(@item1.status).to eq("disabled")
      click_on "Enable"
      binding.pry
      expect(@item1.status).to eq("enabled")
    end
  end

end
