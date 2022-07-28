require 'rails_helper'

RSpec.describe Invoice do

  describe 'enums' do
    it 'does' do
      expect { define_enum_for(:status).with_values(['in progress', 'cancelled', 'completed']) }
    end
  end

  describe 'relationships' do
    it { should belong_to(:customer) }
    it { should have_many(:invoice_items) }
    it { should have_many(:transactions) }
    it { should have_many(:items).through(:invoice_items) }
    it { should have_many(:merchants).through(:items)}
  end

  describe 'validations' do
    it { should validate_presence_of :status }
  end
end
