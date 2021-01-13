require 'rails_helper'

describe 'As a merchant' do
  describe "When I visit my merchant items index page ('merchant/merchant_id/items')" do
    before :each do
      @max = Merchant.create!(name: 'Merch Max')
      @bob = Merchant.create!(name: 'Bob')
      @item_1 = @max.items.create!(name: 'Beans', description: 'Tasty', unit_price: 5, status: 0)
      @item_2 = @max.items.create!(name: 'Item 2', description: 'Blah', unit_price: 10, status: 0)
      @item_3 = @bob.items.create!(name: 'Item 3', description: 'Test', unit_price: 15, status: 0)
     
      visit merchant_items_path(@max.id)
    end

    it 'I see a list of the names of all of my items' do
      expect(page).to have_content(@item_1.name)
      expect(page).to have_content(@item_2.name)
    end

    it 'I do not see items for any other merchant' do
      expect(page).to_not have_content(@item_3.name)
    end

    describe 'When I click on the name of an item' do
      it "Then I am taken to that merchant's item's show page (/merchant/merchant_id/items/item_id)" do
        expect(page).to have_link(@item_1.name, href: "/merchants/#{@max.id}/items/#{@item_1.id}")
        expect(page).to have_link(@item_2.name, href: "/merchants/#{@max.id}/items/#{@item_2.id}")

        click_link(@item_1.name)

        expect(current_path).to eq("/merchants/#{@max.id}/items/#{@item_1.id}")
      end
    end

    it 'Next to each item name I see a button to disable or enable that item' do
      expect(page).to have_selector("input[id='disable-merchant-item-#{@item_1.id}-btn']")
      expect(page).to have_selector("input[id='disable-merchant-item-#{@item_2.id}-btn']")
    end

    describe 'When I click this button' do
      before :each do
        within ".merchant-item-#{@item_1.id}" do
          click_on 'Disable'
        end
      end
  
      it 'Then I am redirected back to the items index' do
        expect(current_path).to eq(merchant_items_path(@max.id))
      end

      it 'Then I see that the items status has changed' do
        within ".merchant-item-#{@item_1.id}" do
          expect(page).to have_content("Status: Disabled")
          expect(page).to have_button("Enable")

          click_on 'Enable'

          expect(page).to have_content("Status: Enabled")
          expect(page).to have_button("Disable")
        end
      end
    end

    it "Then I see two sections, one for 'Enabled Items' and one for 'Disabled Items'" do
      expect(page).to have_selector("section[id='enabled-merchant-items']")
      expect(page).to have_content("Enabled Merchant Items")
      expect(page).to have_selector("section[id='disabled-merchant-items']")
      expect(page).to have_content("Disabled Merchant Items")
    end

    it 'Then I see that each Item is listed in the appropriate section based on status' do
      item_4 = @max.items.create!(name: 'Item 4', description: 'Item 4 Description...', unit_price: 20, status: 1)
      item_5 = @max.items.create!(name: 'Item 5', description: 'Item 5 Description...', unit_price: 30, status: 1)

      visit merchant_items_path(@max.id)

      within '#enabled-merchant-items' do
        expect(page).to have_content(@item_1.name)
        expect(page).to have_content(@item_2.name)
      end

      within '#disabled-merchant-items' do
        expect(page).to have_content(item_4.name)
        expect(page).to have_content(item_5.name)
      end
    end

    it "can see a link to create a new item" do 
      visit merchant_items_path(@max.id)

      click_link "Create New Item"

      expect(current_path).to eq("/merchants/#{@max.id}/items/new")
    end

    it "can see the top 5 most popular items ranked by total revenue and top items best day" do
      sally    = Customer.create!(first_name: 'Sally', last_name: 'Smith')
      joel     = Customer.create!(first_name: 'Joel', last_name: 'Hansen')
      billy    = Customer.create!(first_name: 'Billy', last_name: 'Joel')
      steve    = Customer.create!(first_name: 'Steve', last_name: 'Carrell')
      frank    = Customer.create!(first_name: 'Frank', last_name: 'Sinatra')
      Jon      = Customer.create!(first_name: 'Jon', last_name: 'Travolta')

      all_birds = Merchant.create!(name: 'All Birds', status: 0)
      walmart   = Merchant.create!(name: 'Walmart', status: 0)
      overstock = Merchant.create!(name: 'Overstock', status: 0)
      big_lots  = Merchant.create!(name: 'Big Lots', status: 0)
      amazon    = Merchant.create!(name: 'Amazon', status: 0)
      alibaba   = Merchant.create!(name: 'Alibaba', status: 1)
      # Invoices:
      invoice1 = Invoice.create!(status: 0, customer_id: sally.id, merchant_id: all_birds.id)
      invoice2 = Invoice.create!(status: 0, customer_id: joel.id, merchant_id: all_birds.id)
      invoice3 = Invoice.create!(status: 0, customer_id: billy.id, merchant_id: all_birds.id)
      invoice4 = Invoice.create!(status: 0, customer_id: steve.id, merchant_id: all_birds.id)
      invoice5 = Invoice.create!(status: 0, customer_id: frank.id, merchant_id: all_birds.id)
      invoice6 = Invoice.create!(status: 0, customer_id: joel.id, merchant_id: all_birds.id)
      # Transactions:
      tx1      = Transaction.create!(credit_card_number: 010001001022, credit_card_expiration_date: 20251001, result: 'success', invoice_id: invoice2.id)
      tx2      = Transaction.create!(credit_card_number: 010001005555, credit_card_expiration_date: 20220101, result: 'failed', invoice_id: invoice1.id)
      tx3      = Transaction.create!(credit_card_number: 010001001022, credit_card_expiration_date: 20251001, result: 'success', invoice_id: invoice3.id)
      tx4      = Transaction.create!(credit_card_number: 010001001022, credit_card_expiration_date: 20251001, result: 'success', invoice_id: invoice4.id)
      tx5      = Transaction.create!(credit_card_number: 010001005555, credit_card_expiration_date: 20220101, result: 'success', invoice_id: invoice5.id)
      tx6      = Transaction.create!(credit_card_number: 010001005555, credit_card_expiration_date: 20220101, result: 'success', invoice_id: invoice5.id)
      tx7      = Transaction.create!(credit_card_number: 010001005555, credit_card_expiration_date: 20220101, result: 'success', invoice_id: invoice6.id)
      # Items:
      candle   = Item.create!(name: 'Lavender Candle', description: '8oz Soy Candle', unit_price: 7.0, merchant_id: all_birds.id)
      backpack = Item.create!(name: 'Camo Backpack', description: 'Double Zip Backpack', unit_price: 15.5, merchant_id: all_birds.id)
      radio1   = Item.create!(name: 'Retro Radio', description: 'Twist and Turn to your fav jams', unit_price: 9.75, merchant_id: all_birds.id)
      radio2   = Item.create!(name: 'Retro', description: 'Twist and Turn to your fav jams', unit_price: 9.75, merchant_id: all_birds.id)
      radio3   = Item.create!(name: 'Name', description: 'Twist and Turn to your fav jams', unit_price: 9.75, merchant_id: all_birds.id)
      radio4   = Item.create!(name: 'I Heart Radio', description: 'Twist and Turn to your fav jams', unit_price: 9.75, merchant_id: all_birds.id)
      # InvoiceItems:
      invitm1  = InvoiceItem.create!(status: 0, quantity: 25, unit_price: 7.0, invoice_id: invoice1.id, item_id: candle.id)
      invitm2  = InvoiceItem.create!(status: 2, quantity: 10, unit_price: 15.5, invoice_id: invoice2.id, item_id: backpack.id)
      invitm3  = InvoiceItem.create!(status: 1, quantity: 100, unit_price: 9.75, invoice_id: invoice3.id, item_id: radio1.id)
      invitm4  = InvoiceItem.create!(status: 1, quantity: 50, unit_price: 9.75, invoice_id: invoice4.id, item_id: radio2.id)
      invitm5  = InvoiceItem.create!(status: 1, quantity: 65, unit_price: 9.75, invoice_id: invoice5.id, item_id: radio3.id)
      invitm6  = InvoiceItem.create!(status: 1, quantity: 30, unit_price: 9.75, invoice_id: invoice6.id, item_id: radio4.id)
      
      visit merchant_items_path(all_birds.id)
 
      within(".item-top5") do
        expect(page).to have_link(radio3.name)
        expect(page).to have_link(radio1.name)
        expect(page).to have_link(radio2.name)
        expect(page).to have_link(radio4.name)
        expect(page).to have_link(backpack.name)
      
        expect(radio3.name).to appear_before(radio1.name)
        expect(radio2.name).to appear_before(radio4.name)
        expect(radio4.name).to appear_before(backpack.name)

        expect(page).to have_content("Item:Name $1267.5")
        expect(page).to have_content("Item:Retro Radio $975.0")
        expect(page).to have_content("Item:Retro $487.5")
        expect(page).to have_content("Item:I Heart Radio $292.5")
        expect(page).to have_content("Item:Camo Backpack $155.0")

        expect(page).to have_content("Top selling date for #{radio3.name} was #{radio3.invoices.best_day.created_at.strftime('%m/%d/%y')}")
        expect(page).to have_content("Top selling date for #{radio1.name} was #{radio1.invoices.best_day.created_at.strftime('%m/%d/%y')}")
        expect(page).to have_content("Top selling date for #{radio2.name} was #{radio2.invoices.best_day.created_at.strftime('%m/%d/%y')}")
        expect(page).to have_content("Top selling date for #{radio4.name} was #{radio4.invoices.best_day.created_at.strftime('%m/%d/%y')}")
        expect(page).to have_content("Top selling date for #{backpack.name} was #{backpack.invoices.best_day.created_at.strftime('%m/%d/%y')}")
      end 
    end 
  end
end
