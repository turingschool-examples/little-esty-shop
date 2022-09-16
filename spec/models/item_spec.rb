require 'rails_helper'
RSpec.describe Item, type: :model do

  let!(:barry) { Merchant.create!(name: "Barry's Bonus Barn")}
  let!(:rocker) { barry.items.create!(name: "Rooster Rocker", description: "A big ol chair for a big ol porch", unit_price: 45000, enabled: true) }
  let!(:gordy) { Customer.create!(first_name: "Gordy 'Big Chairs'", last_name: "Howerton")}
  let!(:gordy_inv1) { gordy.invoices.create!(status: "completed", created_at: "2012-03-27 14:54:09", updated_at: "2012-03-27 14:54:09") }
  let!(:transaction1) { gordy_inv1.transactions.create!(credit_card_number: "1935292921010120202", result: "success")}
  let!(:gordy_inv2) { gordy.invoices.create!(status: "completed", created_at: "2012-04-30 14:54:09", updated_at: "2012-04-30 14:54:09") }
  let!(:transaction2) { gordy_inv2.transactions.create!(credit_card_number: "1935292921010120202", result: "success")}
  let!(:gordy_inv3) { gordy.invoices.create!(status: "completed", created_at: "2012-06-28 14:54:09", updated_at: "2012-02-28 14:54:09") }
  let!(:transaction3) { gordy_inv3.transactions.create!(credit_card_number: "1935292921010120202", result: "success")}
  let!(:gordy_inv4) { gordy.invoices.create!(status: "completed", created_at: "2012-05-25 14:54:09", updated_at: "2012-05-25 14:54:09") }
  let!(:transaction4) { gordy_inv4.transactions.create!(credit_card_number: "1935292921010120202", result: "success")}
  let!(:item_inv1) { InvoiceItem.create!}
  
  let!(:item_inv1) { InvoiceItem.create!(invoice_id: gordy_inv1.id, item_id: rocker.id, quantity: 4, unit_price: 1300, status:"packaged" )}
  let!(:item_inv2) { InvoiceItem.create!(invoice_id: gordy_inv2.id, item_id: rocker.id, quantity: 4, unit_price: 1400, status:"packaged" )}
  let!(:item_inv3) { InvoiceItem.create!(invoice_id: gordy_inv3.id, item_id: rocker.id, quantity: 10, unit_price: 1600, status:"packaged" )}
  let!(:item_inv4) { InvoiceItem.create!(invoice_id: gordy_inv4.id, item_id: rocker.id, quantity: 10, unit_price: 1600, status:"packaged" )}

  describe 'relationships' do
    it { should belong_to(:merchant) }
    it { should have_many :invoice_items }
    it { should have_many(:invoices).through(:invoice_items) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:description) }
    it { should validate_numericality_of(:unit_price) }
  end

  before(:each) do
    # @instance_var = Something.create!(input)
  end

  describe 'class methods' do
    describe '#search' do
      it 'returns partial matches' do
       #method goes here
      end
    end
  end

  describe 'instance methods' do
    describe '#method_name' do
     it 'description of method' do
      #expect statement here
     end
    end

    describe '#best_sales_date' do
      it 'returns the date with most sales for an item' do
        expect(rocker.best_sales_date).to eq("June 28, 2012")
        expect(rocker.best_sales_date).to_not eq("May 25, 2012")
      end
    end
  end

end