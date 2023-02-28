require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'relationships' do
    it { should have_many :invoice_items }
    it { should have_many(:invoices).through(:invoice_items) }
    it { should have_many(:transactions).through(:invoices)}
    it { should belong_to :merchant }
    it {should define_enum_for(:status).with_values(["enabled", "disabled"])}
  end
  let!(:merchant1) { create(:merchant)}
  let!(:merchant2) { create(:merchant)}

  let!(:customer1) { Customer.create!(first_name: "Britney", last_name: "Spears") }
	let!(:customer2) { Customer.create!(first_name: "Bob", last_name: "Smith") }

	let!(:invoice1) { create(:completed_invoice, customer: customer1, created_at: Date.new(2014, 4, 1))} ##
	let!(:invoice2) { create(:completed_invoice, customer: customer1,  created_at: Date.new(2012, 3, 2))}
	let!(:invoice3) { create(:completed_invoice, customer: customer2,  created_at: Date.new(2012, 3, 2))} ##
	let!(:invoice4) { create(:completed_invoice, customer: customer1,  created_at: Date.new(2012, 3, 2))}
	let!(:invoice5) { create(:completed_invoice, customer: customer1,  created_at: Date.new(2012, 3, 3))}
	let!(:invoice6) { create(:completed_invoice, customer: customer2,  created_at: Date.new(2012, 3, 4))}
	let!(:invoice7) { create(:completed_invoice, customer: customer2,  created_at: Date.new(2012, 3, 3))}
	let!(:invoice8) { create(:completed_invoice, customer: customer1,  created_at: Date.new(2012, 3, 1))} ##
	let!(:invoice9) { create(:completed_invoice, customer: customer1,  created_at: Date.new(2012, 3, 3))} ##
	let!(:invoice10) { create(:completed_invoice, customer: customer1,  created_at: Date.new(2012, 3, 2))} ##
	let!(:invoice11) { create(:completed_invoice, customer: customer1,  created_at: Date.new(2012, 3, 2))}

  let!(:item1) {create(:item, merchant: merchant1, name: 'item1')}  
  let!(:item2) {create(:item, merchant: merchant1, name: 'item2', status: 'enabled')}
  let!(:item3) {create(:item, merchant: merchant1, name: 'item3')}
  let!(:item4) {create(:item, merchant: merchant1, name: 'item4')}
  let!(:item5) {create(:item, merchant: merchant2, name: 'item5')}
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
		InvoiceItem.create!(item: item1, invoice: invoice1, quantity: 3, unit_price: 1)
		InvoiceItem.create!(item: item1, invoice: invoice2, quantity: 1, unit_price: 1)
		InvoiceItem.create!(item: item1, invoice: invoice4, quantity: 1, unit_price: 1)
		InvoiceItem.create!(item: item1, invoice: invoice5, quantity: 1, unit_price: 1)
		InvoiceItem.create!(item: item1, invoice: invoice8, quantity: 1, unit_price: 1)
		InvoiceItem.create!(item: item1, invoice: invoice11, quantity: 1, unit_price: 1) # => 8

		InvoiceItem.create!(item: item2, invoice: invoice1, quantity: 2, unit_price: 1)
		InvoiceItem.create!(item: item2, invoice: invoice5, quantity: 2, unit_price: 1)
		InvoiceItem.create!(item: item2, invoice: invoice9, quantity: 2, unit_price: 1)
		InvoiceItem.create!(item: item2, invoice: invoice1, quantity: 1, unit_price: 1) # => 7

		InvoiceItem.create!(item: item3, invoice: invoice8, quantity: 412, unit_price: 1)
		InvoiceItem.create!(item: item3, invoice: invoice9, quantity: 4322, unit_price: 1)
		InvoiceItem.create!(item: item3, invoice: invoice10, quantity: 54, unit_price: 1)
		InvoiceItem.create!(item: item3, invoice: invoice3, quantity: 453, unit_price: 1)
		InvoiceItem.create!(item: item3, invoice: invoice1, quantity: 43, unit_price: 1)

		InvoiceItem.create!(item: item4, invoice: invoice10, quantity: 1, unit_price: 1)
		InvoiceItem.create!(item: item4, invoice: invoice11, quantity: 1, unit_price: 1)
		InvoiceItem.create!(item: item4, invoice: invoice2, quantity: 1, unit_price: 1)
		InvoiceItem.create!(item: item4, invoice: invoice3, quantity: 1, unit_price: 1)
		InvoiceItem.create!(item: item4, invoice: invoice4, quantity: 1, unit_price: 1) # => 4

		InvoiceItem.create!(item: item5, invoice: invoice7, quantity: 3, unit_price: 1) # => failed transaction
		InvoiceItem.create!(item: item5, invoice: invoice3, quantity: 2, unit_price: 1) # => 2

		InvoiceItem.create!(item: item6, invoice: invoice3, quantity: 1, unit_price: 1) # => 1
	end

  describe "::class methods" do

    it "::enabled_items" do
      expect(merchant1.items.enabled_items).to eq([item2])

      item3.update(status: 0)

      expect(merchant1.items.enabled_items).to eq([item2, item3])
    end

    it "::disabled_items" do
      expect(merchant1.items.disabled_items).to eq([item1, item3, item4, item6])

      item2.update!(status: 1)

      expect(merchant1.items.disabled_items).to include(item1, item2, item3, item4, item6)
    end

		it '::top_five_most_popular_items' do
			expect(merchant1.items.top_five_most_popular_items).to eq([item3, item1, item2, item4, item6])
		end

		describe '#instance methods' do
			describe '#best_day' do
				it 'returns the best selling day for an item' do
					expect(item1.best_day).to eq('03/02/2012')
					expect(item2.best_day).to eq('04/01/2014')
					expect(item3.best_day).to eq('03/02/2012')
					expect(item4.best_day).to eq('03/02/2012')
					expect(item5.best_day).to eq('03/03/2012')
				end

				it 'returns the most recent day if there are 2 best selling days' do
					InvoiceItem.create!(item: item3, invoice: invoice9, quantity: 1, unit_price: 1)
					# Adding this invoice to this item makes both 03/03 and 03/02 be the best selling day
					# for the item. This means it returns 03/03 instead of 03/02
					
					expect(item3.best_day).to eq('03/03/2012')
				end
			end
		end
  end
end
