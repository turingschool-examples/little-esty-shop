require 'rails_helper'

RSpec.describe Transaction do

  describe 'enums' do
    it 'does' do 
      expect { define_enum_for(:result).with_values(['success', 'failed']) }
    end
  end
end
