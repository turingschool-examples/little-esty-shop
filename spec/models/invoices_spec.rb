require "rails_helper"


RSpec.describe(Invoice, type: :model) do
  let(:invoice) { Invoice.new(    customer_id: 1,     status: "in progress") }

  describe 'relationships' do
    it {should have_many(:transactions)}
    it {should belong_to(:customer)}
    it {should have_many(:invoice_items)}
    it {should have_many(:items).through(:invoice_items)}
    it {should validate_numericality_of(:customer_id)}

  end

  describe 'validations' do
    it {should validate_presence_of(:customer_id)}
    it {should validate_presence_of(:status)}
  end

  it("is an instance of invoice") do
    expect(invoice).to(be_instance_of(Invoice))
  end

  describe 'relationships' do
    it { should have_many :transactions }
  end
end
