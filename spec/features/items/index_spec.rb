require "rails_helper"

RSpec.describe "Merchant Item Index Page" do
  before(:each) do
    @merchant = create(:merchant)
    @merchant2 = create(:merchant)
    
    create_list(:item, 5, merchant:  @merchant)
    create_list(:item, 5, :merchant => @merchant2)
  end
  describe "As a merchant" do
    it "shows the names of all the items" do
      visit merchant_items_path(@merchant)
      
      expect(page).to have_content(@merchant.items.first.name)
      expect(page).to have_content(@merchant.items.second.name)
      expect(page).to have_content(@merchant.items.third.name)
      expect(page).to have_content(@merchant.items.fourth.name)
      expect(page).to have_content(@merchant.items.fifth.name)
      
    end
    
    it "doesn't show any other merchants items" do
      visit merchant_items_path(@merchant)
      
      expect(page).to_not have_content(@merchant2.items.first.name)
      expect(page).to_not have_content(@merchant2.items.second.name)
    end
  end
end