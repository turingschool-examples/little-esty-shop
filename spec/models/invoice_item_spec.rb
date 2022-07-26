require 'rails_helper'

RSpec.describe InvoiceItem do

  describe 'enums' do
    it 'does' do 
      expect { define_enum_for(:status).with_values(['pending', 'packaged', 'shipped']) }
    end
  end
end