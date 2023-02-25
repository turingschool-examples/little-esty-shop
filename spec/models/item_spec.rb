require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'relationships' do
    it { should have_many :invoice_items }
    it { should have_many(:invoices).through(:invoice_items) }
    it { should belong_to :merchant }
  end
  let!(:merchant1) { create(:merchant)}
  let!(:merchant2) { create(:merchant)}

  let!(:customer1) { Customer.create!(first_name: "Britney", last_name: "Spears") }
	let!(:customer2) { Customer.create!(first_name: "Bob", last_name: "Smith") }

	let!(:invoice1) { customer1.invoices.create!(status: 2) }
  let!(:invoice2) { customer1.invoices.create!(status: 2) }
	let!(:invoice3) { customer2.invoices.create!(status: 2) }

  let!(:item1) {create(:item, merchant: merchant1)}  
  let!(:item2) {create(:item, merchant: merchant1, status: 'enabled')}
  let!(:item3) {create(:item, merchant: merchant1)}
  let!(:item4) {create(:item, merchant: merchant1)}
  let!(:item5) {create(:item, merchant: merchant2)}

  before do
  InvoiceItem.create!(item: item1, invoice: invoice1)
  InvoiceItem.create!(item: item3, invoice: invoice3)
  
  end 
  describe "::class methods" do

    it "::enabled_items" do
      expect(merchant1.items.enabled_items).to eq([item2])

      item3.update(status: 0)
      expect(merchant1.items.enabled_items).to eq([item2, item3])
    end

    it "::disabled_items" do
      expect(merchant1.items.disabled_items).to eq([item1, item3, item4])

      item2.update(status: 1)
      expect(merchant1.items.disabled_items).to eq([item1, item3, item4, item2])
    end
  end
end
