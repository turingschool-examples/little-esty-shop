require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe 'validations' do
		it { should validate_presence_of(:name) }
	end

  describe 'relationships' do
    it { should have_many :items }
    it { should have_many(:invoice_items).through(:items) }
    it { should have_many(:invoices).through(:invoice_items) }
    it { should have_many(:transactions).through(:invoices) }
    it { should have_many(:customers).through(:invoices) }
		it { should define_enum_for(:status).with_values(["disabled", "active"])}
  end

  let!(:merchant1) { create(:active_merchant)}
  let!(:merchant_2) { create(:active_merchant)}
  let!(:merchant_3) { create(:active_merchant)}
  let!(:merchant_4) { create(:merchant)}

	let!(:customer1) { create(:customer)}
	let!(:customer2) { create(:customer)}
	let!(:customer3) { create(:customer)}
	let!(:customer4) { create(:customer)}
	let!(:customer5) { create(:customer)}
	let!(:customer6) { create(:customer)}

	let!(:invoice1) { create(:completed_invoice, customer: customer1, created_at: Date.new(2014, 3, 1))}
	let!(:invoice2) { create(:completed_invoice, customer: customer1,  created_at: Date.new(2012, 3, 1))}
	let!(:invoice3) { create(:completed_invoice, customer: customer2)} 
	let!(:invoice4) { create(:completed_invoice, customer: customer2)}
	let!(:invoice5) { create(:completed_invoice, customer: customer3)}
	let!(:invoice6) { create(:completed_invoice, customer: customer3)}
	let!(:invoice7) { create(:completed_invoice, customer: customer4)}
	let!(:invoice8) { create(:completed_invoice, customer: customer5)}
	let!(:invoice9) { create(:completed_invoice, customer: customer5)}
	let!(:invoice10) { create(:completed_invoice, customer: customer6)}
	let!(:invoice11) { create(:completed_invoice, customer: customer6)}

	let!(:item1) {create(:item, merchant: merchant1, name: 'item1')}
	let!(:item2) {create(:item, merchant: merchant1, name: 'item2')}
	let!(:item3) {create(:item, merchant: merchant1, name: 'item3')}
	let!(:item4) {create(:item, merchant: merchant1, name: 'item4')}
	let!(:item5) {create(:item, merchant: merchant1, name: 'item5')}
	let!(:item6) {create(:item, merchant: merchant1, name: 'item6')}

	let!(:transaction1) {create(:transaction, invoice: invoice1) }
	let!(:transaction2) {create(:transaction, invoice: invoice2) }
	let!(:transaction3) {create(:transaction, invoice: invoice3) }
	let!(:transaction4) {create(:transaction, invoice: invoice4) }
	let!(:transaction5) {create(:transaction, invoice: invoice5) }
	let!(:transaction6) {create(:transaction, invoice: invoice6) }
	let!(:transaction7) {create(:transaction, invoice: invoice8) }
	let!(:transaction8) {create(:transaction, invoice: invoice9) }
	let!(:transaction9) {create(:failed_transaction, invoice: invoice10) }
	let!(:transaction10) {create(:transaction, invoice: invoice10) }
	let!(:transaction11) {create(:transaction, invoice: invoice11) }
	let!(:transaction14) {create(:failed_transaction, invoice: invoice7) }
	let!(:transaction15) {create(:transaction, invoice: invoice7) }
	
	before do
		create(:invoice_item, item: item1, invoice: invoice2, quantity: 1, unit_price: 6)
		create(:invoice_item, item: item1, invoice: invoice1, quantity: 3, unit_price: 6)
		create(:invoice_item, item: item1, invoice: invoice4, quantity: 1, unit_price: 6)
		create(:invoice_item, item: item1, invoice: invoice5, quantity: 1, unit_price: 6)
		create(:invoice_item, item: item1, invoice: invoice8, quantity: 1, unit_price: 6)
		create(:invoice_item, item: item1, invoice: invoice11, quantity: 1, unit_price: 6) # => 48

		create(:invoice_item, item: item2, invoice: invoice1, quantity: 2, unit_price: 6)
		create(:invoice_item, item: item2, invoice: invoice5, quantity: 2, unit_price: 6)
		create(:invoice_item, item: item2, invoice: invoice9, quantity: 2, unit_price: 6)
		create(:invoice_item, item: item2, invoice: invoice6, quantity: 1, unit_price: 6) # => 42

		create(:invoice_item, item: item3, invoice: invoice8, quantity: 412, unit_price: 6)
		create(:invoice_item, item: item3, invoice: invoice9, quantity: 4322, unit_price: 6)
		create(:invoice_item, item: item3, invoice: invoice10, quantity: 54, unit_price: 6) ###
		create(:invoice_item, item: item3, invoice: invoice3, quantity: 453, unit_price: 6)
		create(:invoice_item, item: item3, invoice: invoice6, quantity: 43, unit_price: 6)

		create(:invoice_item, item: item4, invoice: invoice10, quantity: 1, unit_price: 6) ###
		create(:invoice_item, item: item4, invoice: invoice11, quantity: 1, unit_price: 6)
		create(:invoice_item, item: item4, invoice: invoice2, quantity: 1, unit_price: 6)
		create(:invoice_item, item: item4, invoice: invoice3, quantity: 1, unit_price: 6)
		create(:invoice_item, item: item4, invoice: invoice4, quantity: 1, unit_price: 6) 

		create(:invoice_item, item: item5, invoice: invoice7, quantity: 3, unit_price: 6)###
		create(:invoice_item, item: item5, invoice: invoice3, quantity: 2, unit_price: 6)
	end

  describe '#instance methods' do
    it '#top_five_customers' do
      expect(merchant1.top_five_customers).to eq([customer1, customer2, customer3, customer5, customer6])
    end

    it '#customer_successful_transactions(customer_id)' do
      expect(merchant1.customer_successful_transactions(customer1.id)).to eq(2)
      expect(merchant1.customer_successful_transactions(customer4.id)).to eq(1)
    end
  end

	describe 'class methods' do
		it '::active_merchants' do
			expect(Merchant.active_merchants).to eq([merchant1, merchant_2, merchant_3])

			merchant_4.update status: 1

			expect(Merchant.active_merchants).to include(merchant1, merchant_2, merchant_3, merchant_4)
		end

		it '::disabled_merchants' do
			expect(Merchant.disabled_merchants).to eq([merchant_4])

			merchant_2.update status: 0

			expect(Merchant.disabled_merchants.sort).to eq([merchant_4, merchant_2].sort)
		end
	end
end
