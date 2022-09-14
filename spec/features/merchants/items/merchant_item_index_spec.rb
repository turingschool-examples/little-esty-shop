require 'rails_helper'

RSpec.describe 'Merchant Items Index Page' do
  before :each do
    @merch1 = Merchant.create!(name: "Charles InCharge")
    @item1 = @merch1.items.create!(name: "thing", description: "Some Latin", unit_price: 5700 )
    @item2 = @merch1.items.create!(name: "Do Hicky", description: "Context of stuff", unit_price: 28030 )

    @merch2 = Merchant.create!(name: "Lola LaGata")
    @item3 = @merch2.items.create!(name: "Object", description: "Not a Ruby one", unit_price: 58320 )
    @item4 = @merch2.items.create!(name: "Gadget", description: "It does a thing", unit_price: 42112 )
    @item5 = @merch2.items.create!(name: "Do Hicky Ripoff", description: "Context of stuff but better", unit_price: 39552 )
  end

  describe 'As a Merchant' do
    describe 'I visit my merchant items index page' do
      it 'I see a list of all my items' do
        visit merchant_items_path(@merch1.id)

        expect(page).to have_content(@merch1.name)
        expect(page).to have_content(@item1.name)
        expect(page).to have_content(@item2.name)

        expect(page).to_not have_content(@item3.name)
        expect(page).to_not have_content(@item4.name)
        expect(page).to_not have_content(@item5.name)
      end
    end
  end
end