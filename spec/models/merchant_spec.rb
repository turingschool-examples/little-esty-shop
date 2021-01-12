require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe "relationships" do
    it { should have_many :invoices }
    it { should have_many :customers }
    it { should have_many :items }
  end

  describe 'instance methods' do
    before :each do
      @merchant1 = Merchant.create!(name: "Robert Heath")

      @item1 = Item.create!(name: "magic pen", description: "special", unit_price: 9.10, enabled: true, merchant_id: @merchant1.id)
      @item2 = Item.create!(name: "preposterous pencil", description: "big", unit_price: 8.50, enabled: true, merchant_id: @merchant1.id)
      @item3 = Item.create!(name: "fantastic fountain pen", description: "small", unit_price: 55.00, merchant_id: @merchant1.id)
    end

    it 'can find all enabled items for a merchant' do
      expect(@merchant1.enabled_items).to eq([@item1, @item2])
    end

    it 'can find all disabled items for a merchant' do
      expect(@merchant1.disabled_items).to eq([@item3])
    end

    it 'can find all invoices for a merchant' do
      customer1 = Customer.create!(id: 1, first_name: 'Joey', last_name: 'Ondricka')
      customer3 = Customer.create!(id: 3, first_name: 'Mariah', last_name: 'Toy')

      merchant26 = Merchant.create!(id: 26, name: 'Balistreri, Schaefer and Kshlerin')
      merchant75 = Merchant.create!(id: 75, name: 'Eichmann-Turcotte')
      merchant33 = Merchant.create!(id: 33, name: 'Quitzon and Sons')
      merchant8 = Merchant.create!(id: 8, name: 'Osinski, Pollich and Koelpin')

      inv1 = Invoice.create!(id: 1, customer_id: 1, merchant_id: 26, status: 'cancelled')
      inv2 = Invoice.create!(id: 2, customer_id: 1, merchant_id: 75, status: 'cancelled')
      inv4 = Invoice.create!(id: 4, customer_id: 1, merchant_id: 33, status: 'completed')
      inv12 = Invoice.create!(id: 12, customer_id: 3, merchant_id: 8, status: 'in progress')

      trans1 = Transaction.create!(id: 1, invoice_id: 1, credit_card_number: 	4654405418249632, result: 'success')
      trans2 = Transaction.create!(id: 2, invoice_id: 2, credit_card_number: 	4654405418249632, result: 'success')
      trans3 = Transaction.create!(id: 3, invoice_id: 4, credit_card_number: 	4654405418249632, result: 'failed')
      trans4 = Transaction.create!(id: 11, invoice_id: 12, credit_card_number: 	4654405418249632, result: 'failed')

      expect(merchant26.all_invoices).to eq([inv1])
    end
  end
end
