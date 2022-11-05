require 'rails_helper'

RSpec.describe 'merchant items index page' do 
  describe 'when i visit my merchant items index page' do 
    before :each do 
      @klein_rempel = Merchant.create!(name: "Klein, Rempel and Jones")
      @whb = Merchant.create!(name: "WHB")
      @something= @klein_rempel.items.create!(name: "Something", description: "A thing that is something", unit_price: 300, status: "Enabled")
      @another = @klein_rempel.items.create!(name: "Another", description: "One more something", unit_price: 150, status: "Enabled")
      @other = @whb.items.create!(name: "Other", description: "One more something", unit_price: 150)
      @water= @klein_rempel.items.create!(name: "Water", description: "like the ocean", unit_price: 80, status: "Disabled")
      @ice= @klein_rempel.items.create!(name: "Ice", description: "water but better", unit_price: 80, status: "Disabled")

    end
    it 'i see a list of names of all my items but not those for other merchants' do 
      visit merchant_items_path(@klein_rempel)
      expect(page).to have_content("Something")
      expect(page).to have_content("Another")
      expect(page).to_not have_content("Other")
    end

    it 'next to each item is a button to disable/ enable item which takes user back to items index with items status changed' do 
      visit merchant_items_path(@klein_rempel)
      within "#enabled-item-#{@something.name}" do 
        expect(page).to have_content("Something")
        click_button "Disable"
        expect(current_path).to eq(merchant_items_path(@klein_rempel))
      end 
    end

    it 'Each item is split into two categories on the page, enabled items and disabled' do 
      visit merchant_items_path(@klein_rempel)
      within('div#enabled_items') do 
        expect(page).to have_content("Something")
        expect(page).to have_content("Another")
        expect(page).to_not have_content("Ice")

        within "#enabled-item-#{@something.name}" do 
          click_button "Disable"
        end 
        expect(page).to_not have_content("Something")
        expect(page).to have_content("Another")
        expect(page).to_not have_content("Ice")

      end

      within('div#disabled_items') do 
        expect(page).to have_content("Something")
        expect(page).to have_content("Ice")

        within "#disabled-item-#{@something.name}" do 
          click_button "Enable"
        end
        expect(page).to_not have_content("Something")
        expect(page).to have_content("Ice")

      end
    end

    it 'a user can add a new item and default status is disabled' do 
      visit merchant_items_path(@klein_rempel)
      click_button "New Item"
      expect(current_path).to eq("/merchants/#{@klein_rempel.id}/items/new")
      expect(page).to have_content("Add an Item")
      fill_in :name, with: "Water Bottle"
      fill_in :description, with: "A necessary desk item"
      fill_in :unit_price, with: 500
      click_button "Submit"
      expect(current_path).to eq("/merchants/#{@klein_rempel.id}/items")
      within('div#disabled_items') do 
        expect(page).to have_content("Water Bottle")
      end
      within('div#enabled_items') do 
        expect(page).to_not have_content("Water Bottle")
      end
    end


    before :each do 
      @merchant1 = Merchant.create!(name: 'Lisa Frank Knockoffs')
      @merchant2 = Merchant.create!(name: 'Fun Testing')
      @item1 = @merchant1.items.create!(name: 'Trapper Keeper', description: 'Its a Lisa Frank Trapper Keeper', unit_price: 3000)
      @item2 = @merchant2.items.create!(name: 'Pencil', description: 'Its a Lisa Frank Trapper Keeper', unit_price: 25)
      @item3 = @merchant2.items.create!(name: 'Soggy Gummy Worm', description: 'Its a Lisa Frank Trapper Keeper', unit_price: 1000)
      @item4 = @merchant2.items.create!(name: 'Eraser', description: 'Its a Lisa Frank Trapper Keeper', unit_price: 5000)
      @item5 = @merchant2.items.create!(name: 'Folder', description: 'Its a Lisa Frank Trapper Keeper', unit_price: 50)
      @item6 = @merchant2.items.create!(name: 'Kevin Ta Action Figure', description: 'The coolest action figure around!', unit_price: 10000)
      @item7 = @merchant2.items.create!(name: 'Water Bottle', description: 'Drink water!', unit_price: 10)
      @customer5 = Customer.create!(first_name: 'Swell', last_name: 'Sally')
      @invoice6 = @customer5.invoices.create!(status: 2, created_at: "2020-10-04 11:00:00 UTC")
      @invoice7 = @customer5.invoices.create!(status: 2, created_at: "2022-11-02 11:00:00 UTC")
      @invoice8 = @customer5.invoices.create!(status: 2, created_at: "2010-7-02 08:00:00 UTC")
      @invoice6 = @customer5.invoices.create!(status: 2, created_at: "2020-2-02 08:00:00 UTC")

      InvoiceItem.create!(invoice: @invoice6, item: @item2, quantity: 1, unit_price: 20)
      InvoiceItem.create!(invoice: @invoice8, item: @item3, quantity: 1, unit_price: 30)
      InvoiceItem.create!(invoice: @invoice7, item: @item4, quantity: 1, unit_price: 40)
      InvoiceItem.create!(invoice: @invoice6, item: @item5, quantity: 1, unit_price: 50)
      InvoiceItem.create!(invoice: @invoice8, item: @item6, quantity: 1, unit_price: 60)
      InvoiceItem.create!(invoice: @invoice6, item: @item7, quantity: 1, unit_price: 10)

      @invoice6.transactions.create!(result: 0)
      @invoice7.transactions.create!(result: 0)
      @invoice8.transactions.create!(result: 0)

    end
    it 'lists top 5 most popular items ranked by total revenue' do 
      visit "/merchants/#{@merchant2.id}/items"
      within('div#top_items') do 
        expect("Kevin Ta Action Figure").to appear_before("Folder")
        expect(@item4.name).to appear_before(@item3.name)
        expect(@item4.name).to appear_before(@item3.name)
        expect(@item4.name).to_not appear_before(@item5.name)
        expect(page).to_not have_content(@item7.name)

      end
    end
    it 'each popular item shows total revenue and links to show page for item' do 
      visit "/merchants/#{@merchant2.id}/items"
      expect(page).to have_content("Folder: 50 in sales")
      expect(page).to have_content("Pencil: 20 in sales")
      expect(page).to_not have_content("Water Bottle - 10 in sales")
    end

    it 'each item on top 5 links to merchant item show page for that item' do 
      visit "/merchants/#{@merchant2.id}/items"
      click_link("Folder")
      expect(current_path).to eq("/merchants/#{@merchant2.id}/items/#{@item5.id}")
    end
   

    it 'top selling date for each item was date with most sales' do 
      visit "/merchants/#{@merchant2.id}/items"
      
      expect(page).to have_content("Top Selling Date For Kevin Ta Action Figure was Friday, July 02, 2010")
      expect(page).to have_content("Top Selling Date For Folder was Sunday, February 02, 2020")
      expect(page).to have_content("Top Selling Date For Eraser was Wednesday, November 02, 2022")
    end
  end
end