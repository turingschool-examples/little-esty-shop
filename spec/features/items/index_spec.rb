require 'rails_helper'

RSpec.describe 'Merchants' do
  before(:each) do
    @merchant = Merchant.create!(name: 'FooMerchant')
    @merchant.items.create!(name: 'fooItem')
    @merchant.items.create!(name: 'barItem')
  end

  describe "Items" do
    describe '#index' do
      it 'has some behaviour' do
        visit "/merchants/#{@merchant.id}/items"
      end

    end


  end

end