require 'rails_helper'

RSpec.describe 'Merchants Item Index Page' do
  before :each do
    @merchant1 = Merchant.create!(name: 'Tom Holland')
    @merchant2 = Merchant.create!(name: 'Mary Jane')

    @item1 = Item.create!(name: 'spider suit', description: 'saves lives', unit_price: '10000', merchant_id: @merchant1.id)
    @item2 = Item.create!(name: 'web shooter', description: 'shoots webs', unit_price: '5000', merchant_id: @merchant1.id)
    @item3 = Item.create!(name: 'upside down kiss', description: 'That Mary jane Swag', unit_price: '15000', merchant_id: @merchant2.id)

    visit merchant_items_path(@merchant1.id)
  end

  it 'is on the correct page' do
    expect(current_path).to eq(merchant_items_path(@merchant1.id))
    expect(page).to have_content("Merchant Items")
  end

  it 'can display all of the merchants items' do
    expect(page).to have_content('Merchants Items')

    expect(page).to have_content(@item1.name)
    expect(page).to have_content(@item2.name)
    expect(page).to_not have_content(@item3.name)
  end

  describe "item disable/enable" do
    before :each do
      @item4 = Item.create!(name: 'sweatpants', description: 'comfy', unit_price: '15000', merchant_id: @merchant1.id)

      visit merchant_items_path(@merchant1.id)
    end
    
    it "displays a button to disable or enable each item" do
      within "#merchant_item-#{@item1.id}" do
        expect(@item1.enable).to eq('enable')
        expect(page).to have_button('disable')
      end
      within "#merchant_item-#{@item2.id}" do
        expect(@item1.enable).to eq('enable')
        expect(page).to have_button('disable')
      end
      within "#merchant_item-#{@item4.id}" do
        expect(@item1.enable).to eq('enable')
        expect(page).to have_button('disable')
      end
    end

    it "clicking enable/disable button redirects back to the index page and the updated status is displayed" do
      within "#merchant_item-#{@item1.id}" do
        expect(@item1.enable).to eq('enable')

        click_button('disable')
        @item1.reload

        expect(page).to have_current_path(merchant_items_path(@merchant1.id))
        expect(@item1.enable).to eq('disable')
      end
    end
  end
end
