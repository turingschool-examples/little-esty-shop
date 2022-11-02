require 'rails_helper'

RSpec.describe 'Merchants' do
  before(:each) do
    @merchant = Merchant.create!(name: 'FooMerchant')
    @item1 = @merchant.items.create!(name: 'fooItem', description: 'lorem ipsum dolocet', unit_price: 17505)
    @item2 = @merchant.items.create!(name: 'barItem', description: 'lorem dolocet ipsum gotsum', unit_price: 456789)
  end

  describe 'Items' do
    describe '#show' do
      it "lists the item's attributes" do
        visit "/merchants/#{@merchant.id}/items/#{@item1.id}"
        expect(page).to have_content(@item1.name)
        expect(page).to have_content(@item1.description)
        expect(page).to have_content(@item1.unit_price)
      end

      xit 'has some behaviour' do

      end
    end
  end
end
