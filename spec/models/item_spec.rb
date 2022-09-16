require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'relationships' do
    it {should belong_to(:merchant)}
  end

  before :each do
    @item1 = create(:item, unit_price: 5700)
    @item2 = create(:item)
  end

end
