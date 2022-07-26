require 'rails_helper'

RSpec.describe Invoice do

  describe 'enums' do
    it 'does' do 
      expect { define_enum_for(:status).with_values(['in progress', 'cancelled', 'completed']) }
    end
  end
end