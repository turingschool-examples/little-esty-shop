require 'rails_helper'

RSpec.describe Merchant do
  describe 'relationships' do
    it { should have_many(:items) }
    it { should have_many(:invoice_items).through(:items) }
    it { should have_many(:invoices).through(:invoice_items) }
    it { should have_many(:customers).through(:invoices) }
    it { should have_many(:transactions).through(:invoices) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
  end

  describe 'instance methods' do
    it 'items_ready_to_ship should return array of items ready to ship ordered by invoice date' do
      merchant1 = Merchant.create!(name: "Schroeder-Jerde")

      item1 = merchant1.items.create!(name: "Qui Esse", description: "Nihil autem sit odio inventore deleniti", unit_price: 75107)
      item2 = merchant1.items.create!(name: "Autem Minima", description: "Cumque consequuntur ad", unit_price: 67076)

      customer1 = Customer.create!(first_name: "Leanne", last_name: "Braun")
      customer2 = Customer.create!(first_name: "Sylvester", last_name: "Nader")
      customer3 = Customer.create!(first_name: "Heber", last_name: "Kuhn")

      invoice2 = customer2.invoices.create!(status: "completed")
      invoice3 = customer3.invoices.create!(status: "in progress")
      invoice4 = customer2.invoices.create!(status: "completed")
      invoice5 = customer1.invoices.create!(status: "completed")
      invoice1 = customer1.invoices.create!(status: "in progress")

      invoice_item1 = InvoiceItem.create!(item_id: item1.id, invoice_id: invoice1.id, quantity: 5, unit_price: 13635, status: "packaged")
      invoice_item2 = InvoiceItem.create!(item_id: item1.id, invoice_id: invoice2.id, quantity: 9, unit_price: 23324, status: "pending")
      invoice_item3 = InvoiceItem.create!(item_id: item2.id, invoice_id: invoice3.id, quantity: 8, unit_price: 34873, status: "packaged")
      invoice_item4 = InvoiceItem.create!(item_id: item2.id, invoice_id: invoice4.id, quantity: 3, unit_price: 2196, status: "packaged")
      invoice_item5 = InvoiceItem.create!(item_id: item2.id, invoice_id: invoice5.id, quantity: 7, unit_price: 79140, status: "shipped")

      transaction1 = Transaction.create!(invoice_id: invoice1.id, credit_card_number: 4654405418249632, credit_card_expiration_date: "2/22", result: "success")
      transaction2 = Transaction.create!(invoice_id: invoice2.id, credit_card_number: 4580251236515201, credit_card_expiration_date: "1/22", result: "failed")
      transaction3 = Transaction.create!(invoice_id: invoice3.id, credit_card_number: 4354495077693036, credit_card_expiration_date: "10/22", result: "success")
      transaction4 = Transaction.create!(invoice_id: invoice4.id, credit_card_number: 4515551623735607, credit_card_expiration_date: "4/25", result: "success")
      transaction5 = Transaction.create!(invoice_id: invoice5.id, credit_card_number: 4844518708741275, credit_card_expiration_date: "4/23", result: "success")

      expect(merchant1.items_ready_to_ship.first.id).to eq(invoice3.id)
      expect(merchant1.items_ready_to_ship.first.name).to eq("#{item2.name}")
      expect(merchant1.items_ready_to_ship.first.created_at).to eq(invoice3.created_at)
    end
  end
end
