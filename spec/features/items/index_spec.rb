require 'rails_helper'

RSpec.describe 'Merchants' do
  before(:each) do
    @merchant = Merchant.create!(name: 'FooMerchant')
    @item1 = @merchant.items.create!(name: 'fooItem')
    @item2 = @merchant.items.create!(name: 'barItem')
  end

  describe 'Items' do
    describe '#index' do
      it 'has some behaviour' do
        visit "/merchants/#{@merchant.id}/items"
        expect(page).to have_content(@item1.name)
        expect(page).to have_content(@item2.name)
      end
    end
  end
end
