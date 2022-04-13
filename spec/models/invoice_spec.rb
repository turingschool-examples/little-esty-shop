require 'rails_helper'

RSpec.describe Invoice do
  before :each do
    @customer = Customer.create!(first_name: "Billy", last_name: "Jonson",
                                 created_at: Time.parse('2012-03-27 14:54:09 UTC'),
                                 updated_at: Time.parse('2012-03-27 14:54:09 UTC'))

    @invoice = @customer.invoices.create!(status: "in progress",
                                          created_at: Time.parse('2012-03-25 09:54:09 UTC'),
                                          updated_at: Time.parse('2012-03-25 09:54:09 UTC'))
  end

  context 'readable attributes' do
    it 'has a status' do
      expect(@invoice.status).to eq("in progress")
    end
  end

  context 'validations' do
    it { should validate_presence_of :status}
    it { should define_enum_for(:status) }
  end

  context 'relationships' do
    it { should belong_to :customer }
    it { should have_many :transactions }
    it { should have_many(:items).through(:invoice_items)}
  end

  context 'instance methods' do
    expect(@invoice.formatted_date).to eq("Sunday, March 25, 2012")
  end
end
