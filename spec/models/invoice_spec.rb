require 'rails_helper'

RSpec.describe Invoice do

  describe 'enums' do
    it 'does' do 
      expect { define_enum_for(:status).with_values(['in progress', 'cancelled', 'completed']) }
    end
  end

  describe 'relationships' do 
    it { should have_many :invoice_items }
  end

  describe 'validations' do
    it { should validate_presence_of :status }
  end
end