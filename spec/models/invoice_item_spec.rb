require 'rails_helper'

RSpec.describe InvoiceItem do

  describe 'enums' do
    it 'does' do 
      expect { define_enum_for(:status).with_values(['pending', 'packaged', 'shipped']) }
    end
  end

  describe 'relationships' do
    it { should belong_to :invoice }
    it { should belong_to :item }
  end

  describe 'validations' do
    it { should validate_presence_of :quantity }
    it { should validate_presence_of :unit_price }
    it { should validate_presence_of :status }
  end
end