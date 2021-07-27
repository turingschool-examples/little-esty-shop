require 'rails_helper'

RSpec.describe Invoice do
  describe 'associations' do
    it {should belong_to :customer}
    it {should have_many :invoice_items}
    it {should have_many(:items).through(:invoice_items)}
  end

  describe 'validations' do
    it { should validate_presence_of :status }
    it { should define_enum_for(:status).with_values([:cancelled, 'in progress', :completed]) }

  end

end
