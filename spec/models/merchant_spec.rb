require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe 'relationships' do
    it { should have_many :items }
    it { should have_many :invoices }
    it { should have_many(:invoice_items).through(:items) }
  end

  let!(:this_gai_ovah_hea) { Customer.create!(first_name: "Dis", last_name: "Gai") }
  let!(:nkelthuraksyyll) { Customer.create!(first_name: "N'kelthuraksyyll", last_name: "The unboud, Lord of ten Thousand chains unBroken, Vanquisher of KMart") }
  let!(:phil) { Customer.create!(first_name: "Phil", last_name: "Phil") } 

  let!(:invoice1) { Invoice.create!(customer_id: this_gai_ovah_hea.id, created_at: Date.yesterday) } 
  let!(:invoice2) { Invoice.create!(customer_id: this_gai_ovah_hea.id,  created_at: Date.tomorrow) } 
  let!(:invoice3) { Invoice.create!(customer_id: this_gai_ovah_hea.id) } 
  let!(:invoice_owl) {Invoice.create!(customer_id: nkelthuraksyyll.id, status: "cancelled") }
  let!(:invoice_sponge) {Invoice.create!(customer_id: nkelthuraksyyll.id, status: "completed") }
  let!(:invoice_vinyl) {Invoice.create!(customer_id: nkelthuraksyyll.id, status: "completed") }
  let!(:invoice_lunchbox) {Invoice.create!(customer_id: phil.id, status: "cancelled") }
  let!(:invoice_macguffin_muffins) {Invoice.create!(customer_id: phil.id, status: "completed") }

  let!(:sam) { Merchant.create!(name: "Sam's Sports") }
  let!(:football) { sam.items.create!(name: "Football", description: "This a football", unit_price: 3000, status: 0) }
  let!(:baseball) { sam.items.create!(name: "Baseball", description: "This a baseball", unit_price: 2500, status: 0) }
  let!(:glove) { sam.items.create!(name: "Baseball Glove", description: "This a baseball glove", unit_price: 4000, status: 1) }
  let!(:owl) { sam.items.create!(name: "Owl", description: "It eats mice. And maybe your face.", unit_price: 54999) }
  let!(:sponge) { sam.items.create!(name: "Sponge", description: "His name is Bob.", unit_price: 99) }
  let!(:vinyl) { sam.items.create!(name: "Unknown Vinyl", description: "A vinyl. Who knows what's on it?", unit_price: 999999) }
  let!(:lunchbox) { sam.items.create!(name: "Lunch Box", description: "Molded sandvich included", unit_price: 5693) }
  let!(:macguffin_muffins) { sam.items.create!(name: "The Macguffin Muffins", description: "https://youtu.be/di7DI6Q7JXA?t=39", unit_price: 99999999) }

  let!(:transaction_football1) { invoice1.transactions.create!(result: 1) }
  let!(:transaction_baseball1) { invoice1.transactions.create!(result: 0) }
  let!(:transaction_baseball2) { invoice1.transactions.create!(result: 1) }
  let!(:transaction_glove1) { invoice2.transactions.create!(result: 0) }
  let!(:transaction_owl1) { invoice_owl.transactions.create!(result: 1) }
  let!(:transaction_sponge1) { invoice2.transactions.create!(result: 1) }
  let!(:transaction_vinyl1) { invoice_vinyl.transactions.create!(result: 0) }
  let!(:transaction_lunchbox1) { invoice_lunchbox.transactions.create!(result: 1) }
  let!(:transaction_macguffin_muffins1) { invoice_macguffin_muffins.transactions.create!(result: 0) }

  before (:each) do
    @football_inv = InvoiceItem.create!(invoice_id: invoice1.id, item_id: football.id, quantity: 1, unit_price: 3000, status: 0)   
    @baseball_inv = InvoiceItem.create!(invoice_id: invoice1.id, item_id: baseball.id, quantity: 10, unit_price: 96732, status: 1)  
    @glove_inv = InvoiceItem.create!(invoice_id: invoice2.id, item_id: glove.id, quantity: 1, unit_price: 4000, status: 2)         
    @glove_inv = InvoiceItem.create!(invoice_id: invoice2.id, item_id: glove.id, quantity: 2, unit_price: 4000, status: 2)                       
    @owl_inv = InvoiceItem.create!(invoice: invoice_owl, item: owl, quantity: 50000, unit_price: 51832, status: 1)                            
    @sponge_inv = InvoiceItem.create!(invoice: invoice_sponge, item: sponge, status: 0)                                                               
    @vinyl_inv = InvoiceItem.create!(invoice: invoice_vinyl, item: vinyl, quantity: 3, unit_price: 9999999, status: 2)                          
    @lunchbox_inv = InvoiceItem.create!(invoice: invoice_lunchbox, item: lunchbox, quantity: 500, unit_price: 66666, status: 1)                    
    @macguffin_muffins_inv = InvoiceItem.create!(invoice: invoice_macguffin_muffins, item: macguffin_muffins, quantity: 7, unit_price: 99999, status: 0)    
  end

  describe 'instance methods' do
    it '#merchant_invoices' do
      expect(sam.merchant_invoices).to eq([invoice1, invoice2, invoice_owl, invoice_sponge, invoice_vinyl, invoice_lunchbox, invoice_macguffin_muffins])
      expect(sam.merchant_invoices).to_not eq([invoice1, invoice1, invoice2,])

      cleats = sam.items.create!(name: "Cleats", description: "These are cleats", unit_price: 7500)
      InvoiceItem.create!(invoice_id: invoice3.id, item_id: cleats.id)

      expect(sam.merchant_invoices).to eq([invoice1, invoice2, invoice3, invoice_owl, invoice_sponge, invoice_vinyl, invoice_lunchbox, invoice_macguffin_muffins])
    end

    it '#items_not_yet_shipped' do 
      expect(sam.items_not_yet_shipped).to eq([@football_inv, @baseball_inv, @owl_inv, @sponge_inv, @lunchbox_inv, @macguffin_muffins_inv])
    end

    it '#top_5_items_by_revenue' do
      require 'pry'; binding.pry
      expect(sam.top_5_items_by_revenue).to eq([vinyl, baseball, macguffin_muffins, glove, football])
    end

    it '#enabled_items' do
      expect(sam.enabled_items).to eq([football, baseball])
    end

    it '#disabled_items' do 
      expect(sam.disabled_items).to eq([glove])
    end
  end
end
