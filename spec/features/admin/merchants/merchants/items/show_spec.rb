require 'rails_helper'

RSpec.describe 'Merchant Items show page', type: :feature do
  before do
    @merchant = create(:merchant)
    @merchant2 = create(:merchant)

    @item1 = create(:item, merchant: @merchant)
    @item2 = create(:item, merchant: @merchant)
    @item3 = create(:item, merchant: @merchant)
    @item4 = create(:item, merchant: @merchant2)
    @item5 = create(:item, merchant: @merchant2)
    @item6 = create(:item, merchant: @merchant2)
  end

  it "can see all the items attributes including name, description, and selling price" do

    visit ("/merchants/#{@merchant.id}/items/#{@item1.id}")

      expect(page).to have_content(@item1.name)
      expect(page).to have_content(@item1.description)
      expect(page).to have_content(@item1.unit_price)
      expect(page).to have_content(@item1.status)
      expect(page).to have_no_content(@item2.name)

    visit "/merchants/#{@merchant.id}/items/#{@item2.id}"
        expect(page).to have_content(@item2.name)
        expect(page).to have_content(@item2.description)
        expect(page).to have_content(@item2.unit_price)
        expect(page).to have_content(@item2.status)
        expect(page).to have_no_content(@item3.name)

    visit "/merchants/#{@merchant2.id}/items/#{@item4.id}"
      expect(page).to have_content(@item4.name)
      expect(page).to have_content(@item4.description)
      expect(page).to have_content(@item4.unit_price)
      expect(page).to have_content(@item4.status)
      expect(page).to have_no_content(@item5.name)


      visit "/merchants/#{@merchant2.id}/items/#{@item5.id}"
      expect(page).to have_content(@item5.name)
      expect(page).to have_content(@item5.description)
      expect(page).to have_content(@item5.unit_price)
      expect(page).to have_content(@item5.status)
      expect(page).to have_no_content(@item6.name)
  end
end
