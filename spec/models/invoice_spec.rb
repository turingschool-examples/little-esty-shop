require 'rails_helper'

RSpec.describe Invoice do
  describe 'relations' do
    it { should belong_to :customer }
    it { should have_many :transactions}
    it { should have_many :invoice_items }
    it { should have_many(:items).through(:invoice_items) }
  end

  describe 'validations' do
    it { should validate_presence_of(:customer_id)}
    it { should define_enum_for(:status).with({:in_progress => 0, :completed => 1, :cancelled => 2}) }
  end

  describe 'instance methods' do
    describe '#creation_date_formatted' do
      it 'date is fomatted as DAY, MM DD, YYYY' do
        customer_1 = Customer.create!(first_name: 'Paul', last_name: 'Atreides')
        invoice_1 = customer_1.invoices.create!(status: 1, created_at: '2022-02-25 10:01:05')
        expect(invoice_1.creation_date_formatted).to eq('Friday, February 25, 2022')
      end
    end
  end
end
