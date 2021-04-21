require 'rails_helper'

RSpec.describe ApplicationRecord, type: :model do

  describe 'instance methods' do
    it "#formatted_unit_price" do
      item = create(:item, unit_price: 200)
      expect(item.formatted_unit_price.to_s).to eq('2.00')
    end
  end
end
