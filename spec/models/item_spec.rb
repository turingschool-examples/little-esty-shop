require "rails_helper"

RSpec.describe(Item, type: :model) do
  let(:item) { Item.new(name: "Qui Esse", description: "Nihil autem", unit_price: 32301, merchant_id: 1) }

  it "is an instance of item" do
    expect(item).to be_instance_of(Item)
  end

  describe 'relationships' do
    it { should belong_to :merchant }
    it { should have_many(:invoices).through(:invoice_items)}
    it { should have_many(:invoice_items)}
  end

  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :description }
    it { should validate_presence_of :unit_price }
    it { should validate_numericality_of :unit_price }
    #http://www.chrisrolle.com/en/blog/boolean-attribute-validation
  end

  describe 'instance methods' do
    describe 'best_day' do
      let!(:merchant_1) {create(:random_merchant)} 

      let!(:item_1) {create(:random_item, merchant_id: merchant_1.id)}
      let!(:item_2) {create(:random_item, merchant_id: merchant_1.id)}
      

      let!(:customer_1) {create(:random_customer)}
      let!(:customer_2) {create(:random_customer)}
      let!(:customer_3) {create(:random_customer)}
    
      let!(:invoice_1) {Invoice.create!(customer_id: customer_1.id, status: 'completed', created_at: Time.new(2022, 9, 1, 12, 11, 9))}
      let!(:invoice_2) {Invoice.create!(customer_id: customer_2.id, status: 'completed', created_at: Time.new(2022, 9, 1, 12, 11, 9))}
      let!(:invoice_3) {Invoice.create!(customer_id: customer_3.id, status: 'cancelled', created_at: Time.new(2019, 9, 1, 12, 11, 9))}
      let!(:invoice_4) {Invoice.create!(customer_id: customer_1.id, status: 'completed', created_at: Time.new(2018, 9, 1, 12, 11, 9))}
      let!(:invoice_5) {Invoice.create!(customer_id: customer_2.id, status: 'completed', created_at: Time.new(2017, 9, 1, 12, 11, 9))}
      let!(:invoice_6) {Invoice.create!(customer_id: customer_3.id, status: 'completed', created_at: Time.new(2016, 9, 1, 12, 11, 9))}

      let!(:transaction_1) {Transaction.create!(invoice_id: invoice_1.id, credit_card_number: 4654405418249632, credit_card_expiration_date: '', result: 'success')}
      let!(:transaction_2) {Transaction.create!(invoice_id: invoice_2.id, credit_card_number: 4654405418249632, credit_card_expiration_date: '', result: 'failed')}
      let!(:transaction_3) {Transaction.create!(invoice_id: invoice_3.id, credit_card_number: 4654405418249632, credit_card_expiration_date: '', result: 'success')}
      let!(:transaction_4) {Transaction.create!(invoice_id: invoice_4.id, credit_card_number: 4654405418249632, credit_card_expiration_date: '', result: 'failed')}
      let!(:transaction_5) {Transaction.create!(invoice_id: invoice_5.id, credit_card_number: 4654405418249632, credit_card_expiration_date: '', result: 'success')}
      let!(:transaction_6) {Transaction.create!(invoice_id: invoice_6.id, credit_card_number: 4654405418249632, credit_card_expiration_date: '', result: 'success')}

      let!(:invoice_item_1) { InvoiceItem.create!(item_id: item_1.id, invoice_id: invoice_1.id, quantity: 3, unit_price: 2000, status: 'shipped') } 
      let!(:invoice_item_2) { InvoiceItem.create!(item_id: item_1.id, invoice_id: invoice_2.id, quantity: 3, unit_price: 2000, status: 'packaged') }
      let!(:invoice_item_3) { InvoiceItem.create!(item_id: item_1.id, invoice_id: invoice_3.id, quantity: 3, unit_price: 300, status: 'shipped') }
      let!(:invoice_item_4) { InvoiceItem.create!(item_id: item_2.id, invoice_id: invoice_4.id, quantity: 3, unit_price: 300, status: 'pending') }
      let!(:invoice_item_5) { InvoiceItem.create!(item_id: item_2.id, invoice_id: invoice_5.id, quantity: 3, unit_price: 300, status: 'pending') }
      let!(:invoice_item_6) { InvoiceItem.create!(item_id: item_2.id, invoice_id: invoice_6.id, quantity: 3, unit_price: 300, status: 'pending') }
     
      it 'returns the date for each items highest grossing day' do
        expect(item_1.best_day).to eq(Time.new(2022, 9, 1).to_date)
        expect(item_2.best_day).to eq(Time.new(2017, 9, 1).to_date)
      end
    end
  end
end
