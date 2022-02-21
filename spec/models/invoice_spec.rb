require 'rails_helper'

RSpec.describe Invoice, type: :model do
  it {should validate_presence_of :customer_id}
  it {should validate_presence_of :status}
  it {should have_many :invoice_items}
  it {should have_many :transactions}
  it {should belong_to :customer}

  describe 'instance methods' do
    it 'can reformat the created_at timestamp' do
      invoice_1 = create(:invoice)
      expect(invoice_1.created_at_date).to eq("Monday, February 21, 2022")
    end
  end
end
