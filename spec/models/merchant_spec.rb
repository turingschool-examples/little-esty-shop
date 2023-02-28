require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe 'validations' do
		it { should validate_presence_of(:name) }
	end

  describe 'relationships' do
    it { should have_many :items }
		it { should define_enum_for(:status).with_values(["active", "disabled"])}
  end

  let!(:merchant1) { create(:merchant)}
  let!(:merchant_2) { create(:merchant)}
  let!(:merchant_3) { create(:merchant)}
  let!(:merchant_4) { create(:merchant, status: 'disabled')}

	let!(:customer1) { create(:customer)}
	let!(:customer2) { create(:customer)}
	let!(:customer3) { create(:customer)}
	let!(:customer4) { create(:customer)}
	let!(:customer5) { create(:customer)}
	let!(:customer6) { create(:customer)}

	let!(:invoice1) { create(:completed_invoice, customer: customer1, created_at: Date.new(2014, 3, 1))}
	let!(:invoice2) { create(:completed_invoice, customer: customer1,  created_at: Date.new(2012, 3, 1))}
	let!(:invoice3) { create(:completed_invoice, customer: customer2, created_at: Date.new(2013, 3, 1))} 
	let!(:invoice4) { create(:completed_invoice, customer: customer2, created_at: Date.new(2014, 3, 1))}
	let!(:invoice5) { create(:completed_invoice, customer: customer3, created_at: Date.new(2010, 3, 1))}
	let!(:invoice6) { create(:completed_invoice, customer: customer3, created_at: Date.new(2016, 3, 1))}
	let!(:invoice7) { create(:completed_invoice, customer: customer4, created_at: Date.new(2018, 3, 1))}
	let!(:invoice8) { create(:completed_invoice, customer: customer5, created_at: Date.new(2017, 3, 1))}
	let!(:invoice9) { create(:completed_invoice, customer: customer5, created_at: Date.new(2019, 3, 1))}
	let!(:invoice10) { create(:completed_invoice, customer: customer6, created_at: Date.new(2020, 3, 1))}
	let!(:invoice11) { create(:completed_invoice, customer: customer6, created_at: Date.new(2021, 3, 1))}

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

		it '#date_with_most_revenue' do 
			expect(merchant1.date_with_most_revenue).to eq("03/01/2019")
		end
  end

	describe 'class methods' do
		it '::active_merchants' do
			expect(Merchant.active_merchants).to eq([merchant1, merchant_2, merchant_3])

			merchant_4.update status: 0

			expect(Merchant.active_merchants).to include(merchant1, merchant_2, merchant_3, merchant_4)
		end

		it '::disabled_merchants' do
			expect(Merchant.disabled_merchants).to eq([merchant_4])

			merchant_2.update status: 1

			expect(Merchant.disabled_merchants).to eq([merchant_4, merchant_2])
		end

		it '::top_five_merchants_by_rev' do 
			merchant_5 = create(:merchant)
			merchant_6 = create(:merchant)
			item7 = create(:item, merchant: merchant_5)
			item8 = create(:item, merchant: merchant_5)
			item9 = create(:item, merchant: merchant_4)
			item10 = create(:item, merchant: merchant_4)
			item11 = create(:item, merchant: merchant_3)
			item12 = create(:item, merchant: merchant_3)
			item13 = create(:item, merchant: merchant_2)
			item14 = create(:item, merchant: merchant_2)
			item15 = create(:item, merchant: merchant_6)
	
			invoice12 = create(:completed_invoice, customer: customer6)
			invoice13 = create(:completed_invoice, customer: customer5)
			invoice14 = create(:completed_invoice, customer: customer4)
			invoice15 = create(:completed_invoice, customer: customer3)
			invoice16 = create(:completed_invoice, customer: customer2)
			invoice17 = create(:completed_invoice, customer: customer1)
			invoice18 = create(:completed_invoice, customer: customer1)
			invoice19 = create(:completed_invoice, customer: customer1)
			invoice20 = create(:completed_invoice, customer: customer1)


			create(:invoice_item, item: item7, invoice: invoice12, quantity: 1, unit_price: 6)
			create(:invoice_item, item: item8, invoice: invoice13, quantity: 1, unit_price: 6)

			create(:invoice_item, item: item9, invoice: invoice14, quantity: 1, unit_price: 6)
			create(:invoice_item, item: item10, invoice: invoice15, quantity: 1, unit_price: 6)

			create(:invoice_item, item: item11, invoice: invoice16, quantity: 1, unit_price: 6)
			create(:invoice_item, item: item12, invoice: invoice17, quantity: 1, unit_price: 6)

			create(:invoice_item, item: item13, invoice: invoice18, quantity: 1, unit_price: 6)
			create(:invoice_item, item: item14, invoice: invoice19, quantity: 1, unit_price: 6)

			create(:invoice_item, item: item15, invoice: invoice20, quantity: 1, unit_price: 6)

			transaction16 = create(:transaction, invoice: invoice12) 
			transaction17 = create(:transaction, invoice: invoice13) 
			transaction18 = create(:transaction, invoice: invoice14) 
			transaction19 = create(:transaction, invoice: invoice15) 
			transaction20 = create(:transaction, invoice: invoice16) 
			transaction21 = create(:transaction, invoice: invoice17) 
			transaction22 = create(:transaction, invoice: invoice18) 
			transaction23 = create(:transaction, invoice: invoice19) 
			transaction24 = create(:transaction, invoice: invoice20) 

			expect(Merchant.top_five_merchant_by_rev).to eq([merchant1, merchant_2, merchant_3, merchant_4, merchant_5])
			expect(Merchant.top_five_merchant_by_rev).to_not include(merchant_6)
		end
	end
end
