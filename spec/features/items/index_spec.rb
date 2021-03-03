require "rails_helper"

RSpec.describe "Merchant Item Index Page" do
  before(:each) do
    @merchant = create(:merchant)
    @merchant2 = create(:merchant)
    
    @item1 = @merchant.items.create(name: "item 1", description: "it is item 1", unit_price: 5 )
    @item2 = @merchant.items.create(name: "item 2", description: "it is item 2", unit_price: 5 )
    @item3 = @merchant.items.create(name: "item 3", description: "it is item 3", unit_price: 5 )
    @item4 = @merchant.items.create(name: "item 4", description: "it is item 4", unit_price: 5 )
    @item5 = @merchant.items.create(name: "item 5", description: "it is item 5", unit_price: 5 )
    @item6 = @merchant.items.create(name: "item 6", description: "it is item 6", unit_price: 5 )
    @item7 = @merchant.items.create(name: "item 7", description: "it is item 7", unit_price: 5 )

    @customer = create(:customer)

    @invoice1 = create(:invoice, customer: @customer)
    @invoice2 = create(:invoice, customer: @customer)
    @invoice3 = create(:invoice, customer: @customer)
    @invoice4 = create(:invoice, customer: @customer)
    @invoice5 = create(:invoice, customer: @customer)
    @invoice6 = create(:invoice, customer: @customer)
    @invoice7 = create(:invoice, customer: @customer)

    @invoice_item1 = create(:invoice_item, invoice: @invoice1, item: @item1, unit_price: 1, quantity: 1, status: 2)
    @invoice_item2 = create(:invoice_item, invoice: @invoice2, item: @item2, unit_price: 1, quantity: 2, status: 2)
    @invoice_item3 = create(:invoice_item, invoice: @invoice3, item: @item3, unit_price: 1, quantity: 5, status: 2)
    @invoice_item4 = create(:invoice_item, invoice: @invoice4, item: @item4, unit_price: 1, quantity: 4, status: 2)
    @invoice_item5 = create(:invoice_item, invoice: @invoice5, item: @item5, unit_price: 1, quantity: 7, status: 2)
    @invoice_item6 = create(:invoice_item, invoice: @invoice6, item: @item6, unit_price: 1, quantity: 3, status: 2)
    @invoice_item7 = create(:invoice_item, invoice: @invoice7, item: @item7, unit_price: 1, quantity: 1, status: 2)

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
  
  it "shows the names of the top 5 most popular items ranked by total revenue generated, and its total revenue" do
    visit merchant_items_path(@merchant)
    
    within("#merchant-top-items") do
      expect(@item5.name).to appear_before(@item3.name)
      expect(@item3.name).to appear_before(@item4.name)
      expect(@item4.name).to appear_before(@item6.name)
      expect(@item6.name).to appear_before(@item2.name)
      expect(page).to have_content(@merchant.top_five_items.first.total_revenue)
      expect(page).to have_content(@merchant.top_five_items.second.total_revenue)
      expect(page).to have_content(@merchant.top_five_items.third.total_revenue)
      expect(page).to have_content(@merchant.top_five_items.fourth.total_revenue)
      expect(page).to have_content(@merchant.top_five_items.fifth.total_revenue)
    end
  end
  
  it "lists the best day for an item with a label 'Top selling date was' for the top five items" do
    visit merchant_items_path(@merchant)

    expect(page).to have_content("Top selling date was:")

    within("#top-item-#{@item5.id}") do
      expect(page).to have_content(@item5.best_day.format_day)
    end
  end
end
end
