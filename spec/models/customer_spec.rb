require 'rails_helper'

RSpec.describe Customer, type: :model do
  describe 'relationships' do
  it { should have_many :invoices}
  end
 
  describe 'validations' do
    it { should validate_presence_of :first_name}
    it { should validate_presence_of :last_name}
  end

  describe 'class methods' do
    it "returns top 5 customers" do

    expect(Customer.top_five).to eq("nothing")
    end
  end
end
