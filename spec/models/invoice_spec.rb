require 'rails_helper'

RSpec.describe Invoice, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:status) }
    it { should validate_presence_of(:created_at) }
    it { should validate_presence_of(:updated_at) }
  end

  describe 'relationships' do
    it { should belong_to(:customer) }
    it { should have_many(:items).through(:invoice_items) }
    it { should have_many(:transactions) }
  end

  describe 'instance methods' do
    it 'returns the invoices created at date as Weekday, Month Day, Year' do
      date = 	"2020-02-08 09:54:09 UTC".to_datetime
      cust1 = FactoryBot.create(:customer, first_name: "L'Ron", last_name: 'Hubbard')
      merch1 = FactoryBot.create(:merchant)
      item1 = FactoryBot.create(:item, merchant_id: merch1.id)
      invoice1 = FactoryBot.create(:invoice, created_at: date, customer_id: cust1.id)
      invoice_item_1 = FactoryBot.create(:invoice_item, item_id: item1.id, invoice_id: invoice1.id)

      expect(invoice1.formatted_created_at).to eq("Saturday, February  8, 2020")
    end

    it 'returns the invoice customers first and last name together' do
      date = 	"2020-02-08 09:54:09 UTC".to_datetime
      cust1 = FactoryBot.create(:customer, first_name: "L'Ron", last_name: 'Hubbard')
      merch1 = FactoryBot.create(:merchant)
      item1 = FactoryBot.create(:item, merchant_id: merch1.id)
      invoice1 = FactoryBot.create(:invoice, created_at: date, customer_id: cust1.id)
      invoice_item_1 = FactoryBot.create(:invoice_item, item_id: item1.id, invoice_id: invoice1.id)

      expect(invoice1.customer_name).to eq("L'Ron Hubbard")
    end
  end
end
