require "rails_helper"

RSpec.describe "Merchant Item Index Page" do
  before(:each) do
    @merchant = create(:merchant)
    @merchant2 = create(:merchant)
    
    @item1 = @merchant.items.create(name: "item 1", description: "it is item 1", unit_price: 5 )
    @item2 = @merchant.items.create(name: "item 2", description: "it is item 2", unit_price: 5 )
    @item3 = @merchant.items.create(name: "item 3", description: "it is item 3", unit_price: 5 )

    # create_list(:item, 5, merchant:  @merchant)
    create_list(:item, 5, :merchant => @merchant2)
  end
  describe "As a merchant" do
    it "shows the names of all the items" do
      visit merchant_items_path(@merchant)
      
      within("#item-#{@item1.id}") do
        expect(page).to have_content(@item1.name)
        expect(page).to have_content(@item1.status)
      end

      within("#item-#{@item2.id}") do
        expect(page).to have_content(@item2.name)
        expect(page).to have_content(@item2.status)
      end

      within("#item-#{@item2.id}") do
        expect(page).to have_content(@item2.name)
        expect(page).to have_content(@item2.status)
      end
    end
    
    it "doesn't show any other merchants items" do
      visit merchant_items_path(@merchant)
      
      expect(page).to_not have_content(@merchant2.items.first.name)
      expect(page).to_not have_content(@merchant2.items.second.name)
    end

    it "has next to each item name a button to disable or enable that item" do
      visit merchant_items_path(@merchant)
      
      within("#item-#{@item1.id}") do
        expect(page).to have_button("Enable")
      end
    end
    
    describe "When I click this button" do
      it "takes me back to the items index showing the changed status of the item" do
        visit merchant_items_path(@merchant)

        within("#item-#{@item1.id}") do
          click_on "Enable"
          expect(current_path).to eq(merchant_items_path(@merchant))
        end
      end

      it "can also disable an item" do
        visit merchant_items_path(@merchant)
        
        within("#item-#{@item1.id}") do
          click_on "Enable"
          expect(current_path).to eq(merchant_items_path(@merchant))
          expect(page).to have_content("enabled")
          expect(page).to have_button("Disable")
          click_on "Disable"
          expect(page).to have_content("disabled")
        end
      end
    end

    it "has two sections, one for 'Enabled Items' and one for 'Disabled Items'
    And I see that each Item is listed in the appropriate section" do
      enabled_item = create(:item, merchant: @merchant, status: "enabled")
      visit merchant_items_path(@merchant)
      
      within("#merchant-enabled-items") do
        expect(page).to have_content(enabled_item.name)
      end

      within("#item-#{enabled_item.id}") do
        expect(page).to have_button("Disable")
      end
      
      within("#merchant-disabled-items") do
        expect(page).to have_content(@item1.name)
        expect(page).to have_content(@item2.name)
        expect(page).to have_content(@item3.name)
      end
      
      within("#item-#{@item1.id}") do
        expect(page).to have_button("Enable")
      end
    end
  end
end