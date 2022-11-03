require 'rails_helper'

RSpec.describe Transaction, type: :model do
  let!(:nomi) {Merchant.create!(name: "Naomi LLC")}
  let!(:tyty) {Merchant.create!(name: "TyTy's Grub")}
  
  let!(:timmy) {Customer.create!(first_name: "Timmy", last_name: "Limmy")}
  let!(:sue) {Customer.create!(first_name: "Sue", last_name: "Maybis")}
  let!(:shooter) {Customer.create!(first_name: "Shooter", last_name: "Mcgavin")}
  let!(:louise) {Customer.create!(first_name: "Louise", last_name: "Banks")}
  let!(:alfred) {Customer.create!(first_name: "Alfred", last_name: "Borden")}
  let!(:olivia) {Customer.create!(first_name: "Olivia", last_name: "Wenscombe")}
  
  let!(:item_1) {nomi.items.create!(name: "book", description: "big book", unit_price: 11)}
  let!(:item_2) {nomi.items.create!(name: "book", description: "bigber book", unit_price: 11)}
  
  let!(:invoice_1) {Invoice.create!(status: 2, customer_id: timmy.id)}
  let!(:invoice_2) {Invoice.create!(status: 2, customer_id: timmy.id)}
  let!(:invoice_3) {Invoice.create!(status: 2, customer_id: sue.id)}
  let!(:invoice_4) {Invoice.create!(status: 2, customer_id: sue.id)}
  let!(:invoice_5) {Invoice.create!(status: 2, customer_id: shooter.id)}
  let!(:invoice_6) {Invoice.create!(status: 2, customer_id: shooter.id)}
  let!(:invoice_7) {Invoice.create!(status: 2, customer_id: louise.id)}
  let!(:invoice_8) {Invoice.create!(status: 2, customer_id: louise.id)}
  let!(:invoice_9) {Invoice.create!(status: 2, customer_id: alfred.id)}
  let!(:invoice_10) {Invoice.create!(status: 2, customer_id: alfred.id)}
  let!(:invoice_11) {Invoice.create!(status: 2, customer_id: olivia.id)}
  let!(:invoice_12) {Invoice.create!(status: 2, customer_id: olivia.id)}
  
  let!(:invoice_item_1)  {InvoiceItem.create!(item_id: item_1.id, invoice_id: invoice_1.id, quantity: 2, unit_price: 11, status: "pending")}
  let!(:invoice_item_2)  {InvoiceItem.create!(item_id: item_1.id, invoice_id: invoice_3.id, quantity: 2, unit_price: 11, status: "pending")}
  let!(:invoice_item_3)  {InvoiceItem.create!(item_id: item_1.id, invoice_id: invoice_5.id, quantity: 2, unit_price: 11, status: "pending")}
  let!(:invoice_item_4)  {InvoiceItem.create!(item_id: item_1.id, invoice_id: invoice_7.id, quantity: 2, unit_price: 11, status: "pending")}
  let!(:invoice_item_5)  {InvoiceItem.create!(item_id: item_1.id, invoice_id: invoice_9.id, quantity: 2, unit_price: 11, status: "pending")}
  let!(:invoice_item_6)  {InvoiceItem.create!(item_id: item_1.id, invoice_id: invoice_11.id, quantity: 2, unit_price: 11, status: "pending")}
  
  
  let!(:transaction_1) {Transaction.create!(credit_card_number: 1111111111111111, credit_card_expiration_date: "11/11", result: "success", invoice_id: invoice_1.id)}
  let!(:transaction_2) {Transaction.create!(credit_card_number: 1111111111111111, credit_card_expiration_date: "11/11", result: "success", invoice_id: invoice_2.id)}
  let!(:transaction_3) {Transaction.create!(credit_card_number: 2222222222222222, credit_card_expiration_date: "01/11", result: "success", invoice_id: invoice_3.id)}
  let!(:transaction_4) {Transaction.create!(credit_card_number: 2222222222222222, credit_card_expiration_date: "01/11", result: "success", invoice_id: invoice_4.id)}
  let!(:transaction_5) {Transaction.create!(credit_card_number: 3333333333333333, credit_card_expiration_date: "01/21", result: "success", invoice_id: invoice_5.id)}
  let!(:transaction_6) {Transaction.create!(credit_card_number: 3333333333333333, credit_card_expiration_date: "01/21", result: "success", invoice_id: invoice_6.id)}
  let!(:transaction_7) {Transaction.create!(credit_card_number: 1555555555555555, credit_card_expiration_date: "01/21", result: "success", invoice_id: invoice_7.id)}
  let!(:transaction_8) {Transaction.create!(credit_card_number: 1555555555555555, credit_card_expiration_date: "01/21", result: "success", invoice_id: invoice_8.id)}
  let!(:transaction_9) {Transaction.create!(credit_card_number: 1000000000000000, credit_card_expiration_date: "01/21", result: "success", invoice_id: invoice_9.id)}
  let!(:transaction_10) {Transaction.create!(credit_card_number: 1000000000000000, credit_card_expiration_date: "01/21", result: "success", invoice_id: invoice_10.id)}
  let!(:transaction_11) {Transaction.create!(credit_card_number: 2000000000000000, credit_card_expiration_date: "01/21", result: "success", invoice_id: invoice_11.id)}
  let!(:transaction_12) {Transaction.create!(credit_card_number: 2000000000000000, credit_card_expiration_date: "01/21", result: "failed", invoice_id: invoice_12.id)}

  describe 'relationships' do
    it {should belong_to(:invoice)}
  end

  describe 'validations' do
    it {should validate_presence_of(:credit_card_number)}
    it {should validate_numericality_of(:credit_card_number)}
    it {should validate_presence_of(:result)}
  end
  
  describe '#top_five_customers' do
    it 'returns the top five customers' do
   
      expect(nomi.top_five_customers[0].id).to eq(timmy.id)
      expect(nomi.top_five_customers[1].id).to eq(sue.id)
      expect(nomi.top_five_customers[2].id).to eq(shooter.id)
      expect(nomi.top_five_customers[3].id).to eq(louise.id)
      expect(nomi.top_five_customers[4].id).to eq(alfred.id)
    end
  end
end
