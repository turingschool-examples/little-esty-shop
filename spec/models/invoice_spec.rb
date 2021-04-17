require 'rails_helper'

RSpec.describe Invoice, type: :model do
  describe 'relationships' do
    it {should belong_to :customer}
    it {should have_many :invoice_items}
    it {should have_many(:items).through :invoice_items}
  end

  describe 'validations' do
    it { should validate_presence_of(:status) }
  end

  describe 'instance methods' do
    it "::formatted_date" do
    end

    it "::full_name" do
    end
  end
end
