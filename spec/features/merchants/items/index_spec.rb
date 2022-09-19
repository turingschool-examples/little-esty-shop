require 'rails_helper'

RSpec.describe 'Merchants Item Index' do
  before :each do
    @merchant_1 = create(:merchant)
    @merchant_2 = create(:merchant)
    
    @items_1 = create_list(:item, 10, merchant: @merchant_1, active_status: :enabled)
    @items_2 = create_list(:item, 10, merchant: @merchant_2, active_status: :enabled)
    @items_3 = create_list(:item, 2, merchant: @merchant_1)
    @items_4 = create_list(:item, 2, merchant: @merchant_2)
  end

  # When I visit my merchant items index page ("merchants/merchant_id/items")
  # I see a list of the names of all of my items
  # And I do not see items for any other merchant
  describe 'user story 6' do
    it 'I see a list of the names of all of my items' do

      visit merchant_items_path(@merchant_1)

      within("#item-#{@items_1[0].id}") do
        expect(page).to have_content("#{@items_1[0].name}")
        expect(page).to_not have_content("#{@items_2[0].name}")
      end

      within("#item-#{@items_1[1].id}") do
        expect(page).to have_content("#{@items_1[1].name}")
        expect(page).to_not have_content("#{@items_1[4].name}")
      end

    visit merchant_items_path(@merchant_2)

      within("#item-#{@items_2[0].id}") do
        expect(page).to have_content("#{@items_2[0].name}")
        expect(page).to_not have_content("#{@items_1[0].name}")
      end

      within("#item-#{@items_2[1].id}") do
        expect(page).to have_content("#{@items_2[1].name}")
        expect(page).to_not have_content("#{@items_2[5].name}")
      end
    end
  end

  # As a merchant,
  # When I click on the name of an item from the merchant items index page,
  # Then I am taken to that merchant's item's show page (/merchants/merchant_id/items/item_id)
  # And I see all of the item's attributes including:
  describe 'user story 7' do
    it 'When I click on the name of an item I am taken to that merchants item show page' do

      visit "/merchants/#{@merchant_1.id}/items"

      within("#item-#{@items_1[0].id}") do
        click_on "#{@items_1[0].name}"
        expect(current_path).to eq("/merchants/#{@merchant_1.id}/items/#{@items_1[0].id}")
      end

      visit "/merchants/#{@merchant_2.id}/items"

      within("#item-#{@items_2[6].id}") do
        click_on "#{@items_2[6].name}"
        expect(current_path).to eq("/merchants/#{@merchant_2.id}/items/#{@items_2[6].id}")
      end
    end

    it 'I see all of the items attributes' do

      @items_1.each do |item|
        visit merchant_item_path(@merchant_1, item)
        expect(page).to have_content(item.name)
        expect(page).to have_content(item.description)
        expect(page).to have_content(item.unit_price)
      end

      @items_2.each do |item|
        visit merchant_item_path(@merchant_2, item)
        expect(page).to have_content(item.name)
        expect(page).to have_content(item.description)
        expect(page).to have_content(item.unit_price)
      end
    end
  end

  # As a merchant
  # When I visit my items index page
  # Next to each item name I see a button to disable or enable that item.
  # When I click this button
  # Then I am redirected back to the items index
  # And I see that the items status has changed
  describe 'user story 9' do
    it 'Next to each item name I see a button to disable or enable that item' do

      visit merchant_items_path(@merchant_1)

      within("#item-#{@items_1[0].id}") do
        expect(page).to have_button("Disable")
      end

      within("#item-#{@items_1[1].id}") do
        expect(page).to have_button("Disable")
      end

      within("#item-#{@items_3[0].id}") do
        expect(page).to have_button("Enable")
      end

      within("#item-#{@items_3[1].id}") do
        expect(page).to have_button("Enable")
      end

      visit merchant_items_path(@merchant_2)

      within("#item-#{@items_2[0].id}") do
        expect(page).to have_button("Disable")
      end

      within("#item-#{@items_4[0].id}") do
        expect(page).to have_button("Enable")
      end
    end

    it "When I click this button I am redirected back to the items index" do
      visit merchant_items_path(@merchant_1)

      within("#item-#{@items_1[0].id}") do
        click_button "Disable"
      end
        expect(current_path).to eq(merchant_items_path(@merchant_1))
    end

    it "I see the items status has changed" do

      visit merchant_items_path(@merchant_1)

      within("#item-#{@items_1[0].id}") do
        expect(page).to have_button("Disable")
        click_button "Disable"
        expect(page).to have_button("Enable")
      end

      visit merchant_items_path(@merchant_2)

      within("#item-#{@items_4[1].id}") do
        expect(page).to have_button("Enable")
        click_button "Enable"
        expect(page).to have_button("Disable")
      end
    end
  end

  # As a merchant,
  # When I visit my merchant items index page
  # Then I see two sections, one for "Enabled Items" and one for "Disabled Items"
  # And I see that each Item is listed in the appropriate section
  describe 'user story 10' do
    it 'Then I see two sections, one for Enabled Items and one for Disabled Items' do

      visit merchant_items_path(@merchant_1)

      within("#enabled-items") do
        expect(page).to have_content("Enabled Items")
      end

      within("#disabled-items") do
        expect(page).to have_content("Disabled Items")
      end

    end

    it 'I see that each Item is listed in the appropriate section' do

      visit merchant_items_path(@merchant_1)

      within("#enabled-items") do
        within("#item-#{@items_1[0].id}") do
          expect(page).to have_content("#{@items_1[0].name}")
          expect(page).to have_button("Disable")
        end

        within("#item-#{@items_1[1].id}") do
          expect(page).to have_content("#{@items_1[1].name}")
          expect(page).to have_button("Disable")
        end
      end

      within("#disabled-items") do
        within("#item-#{@items_3[0].id}") do
          expect(page).to have_content("#{@items_3[0].name}")
          expect(page).to have_button("Enable")
        end

        within("#item-#{@items_3[1].id}") do
          expect(page).to have_content("#{@items_3[1].name}")
          expect(page).to have_button("Enable")
        end
      end

      visit merchant_items_path(@merchant_2)

      within("#enabled-items") do
        within("#item-#{@items_2[0].id}") do
          expect(page).to have_content("#{@items_2[0].name}")
          expect(page).to have_button("Disable")
        end

        within("#item-#{@items_2[1].id}") do
          expect(page).to have_content("#{@items_2[1].name}")
          expect(page).to have_button("Disable")
        end
      end

      within("#disabled-items") do
        within("#item-#{@items_4[0].id}") do
          expect(page).to have_content("#{@items_4[0].name}")
          expect(page).to have_button("Enable")
        end

        within("#item-#{@items_4[1].id}") do
          expect(page).to have_content("#{@items_4[1].name}")
          expect(page).to have_button("Enable")
        end
      end
    end
  end

  # As a merchant
  # When I visit my items index page
  # Then I see the names of the top 5 most popular items ranked by total revenue generated
  # And I see that each item name links to my merchant item show page for that item
  # And I see the total revenue generated next to each item name

  # Notes on Revenue Calculation:

  # Only invoices with at least one successful transaction should count towards revenue
  # Revenue for an invoice should be calculated as the sum of the revenue of all invoice items
  # Revenue for an invoice item should be calculated as the invoice item unit price multiplied by the quantity (do not use the item unit price)

  describe 'User Story 12 - When I visit my items index page' do
    before :each do
      @merchant_1 = create(:merchant)
    
      @item_1 = create(:item, name: "item_1", merchant: @merchant_1, active_status: :enabled)
      @item_2 = create(:item, name: "item_2", merchant: @merchant_1)
      @item_3 = create(:item, name: "item_3", merchant: @merchant_1)
      @item_4 = create(:item, name: "item_4", merchant: @merchant_1, active_status: :enabled)
      @item_5 = create(:item, name: "item_5", merchant: @merchant_1, active_status: :enabled)
      @item_6 = create(:item, name: "item_6", merchant: @merchant_1)
      @item_7 = create(:item, name: "item_7", merchant: @merchant_1, active_status: :enabled)
      @item_8 = create(:item, name: "item_8", merchant: @merchant_1)
      @item_9 = create(:item, name: "item_9", merchant: @merchant_1, active_status: :enabled)
      @item_10 = create(:item, name: "item_10", merchant: @merchant_1)
  
      @invoice_1 = create(:invoice)
      @invoice_2 = create(:invoice)
      @invoice_3 = create(:invoice)
      @invoice_4 = create(:invoice)
  
      create(:invoice_items, invoice: @invoice_1, item: @item_10, unit_price: 1000, quantity: 10)
      create(:invoice_items, invoice: @invoice_1, item: @item_5, unit_price: 900, quantity: 9)
      create(:invoice_items, invoice: @invoice_1, item: @item_3, unit_price: 800, quantity: 8)
      create(:invoice_items, invoice: @invoice_2, item: @item_7, unit_price: 700, quantity: 7)
      create(:invoice_items, invoice: @invoice_2, item: @item_6, unit_price: 600, quantity: 6)
      create(:invoice_items, invoice: @invoice_3, item: @item_2, unit_price: 500, quantity: 5)
      create(:invoice_items, invoice: @invoice_3, item: @item_4, unit_price: 400, quantity: 4)
      create(:invoice_items, invoice: @invoice_4, item: @item_8, unit_price: 300, quantity: 3)
      create(:invoice_items, invoice: @invoice_4, item: @item_9, unit_price: 200, quantity: 2)
      create(:invoice_items, invoice: @invoice_4, item: @item_1, unit_price: 100, quantity: 1)
      
      create_list(:transaction, 5, invoice: @invoice_1, result: :success)
      create_list(:transaction, 5, invoice: @invoice_1, result: :failed)
      create_list(:transaction, 5, invoice: @invoice_2, result: :failed)
      create_list(:transaction, 5, invoice: @invoice_2, result: :success)
      create_list(:transaction, 5, invoice: @invoice_3, result: :failed)
      create_list(:transaction, 5, invoice: @invoice_3, result: :failed)
      create_list(:transaction, 5, invoice: @invoice_4, result: :success)
      create_list(:transaction, 5, invoice: @invoice_4, result: :success)
    end
    it 'Then I see the names of the top 5 most popular items ranked by total revenue generated' do
      visit merchant_items_path(@merchant_1)
      
      within "#5-best-items" do
        expect(@item_10.name).to appear_before( @item_5.name)
        expect(@item_5.name).to appear_before( @item_3.name)
        expect(@item_3.name).to appear_before( @item_7.name)
        expect(@item_7.name).to appear_before( @item_6.name)
        expect(@item_5.name).to_not appear_before( @item_10.name)
        expect(@item_3.name).to_not appear_before( @item_5.name)
        expect(@item_7.name).to_not appear_before( @item_3.name)
        expect(@item_6.name).to_not appear_before( @item_7.name)
      end
    end

    it 'And I see that each item name links to my merchant item show page for that item' do
      visit merchant_items_path(@merchant_1)

      within "#5-best-items" do
        find_link({text: "#{@item_10.name}", href: merchant_item_path(@merchant_1, @item_10)}).visible?
        find_link({text: "#{@item_5.name}", href: merchant_item_path(@merchant_1, @item_5)}).visible?
        find_link({text: "#{@item_3.name}", href: merchant_item_path(@merchant_1, @item_3)}).visible?
        find_link({text: "#{@item_7.name}", href: merchant_item_path(@merchant_1, @item_7)}).visible?
        find_link({text: "#{@item_6.name}", href: merchant_item_path(@merchant_1, @item_6)}).visible?
      end
    end

    it 'And I see the total revenue generated next to each item name' do
      visit merchant_items_path(@merchant_1)
    
      within "#5-best-items" do
      
        expect(page).to have_content((@item_10.revenue) / 100)
        expect(page).to have_content((@item_5.revenue) / 100)
        expect(page).to have_content((@item_3.revenue) / 100)
        expect(page).to have_content((@item_7.revenue) / 100)
        expect(page).to have_content((@item_6.revenue) / 100)
      end
    end
  end
end
