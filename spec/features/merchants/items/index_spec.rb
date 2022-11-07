require "rails_helper"
require "date"

RSpec.describe "On the Merchant's Items index page" do
  before(:each) do
    @merchant = Merchant.create!(name: "Practical Magic Shop")
    @book = @merchant.items.create!(name: "Book of the dead", description: "book of necromancy spells", unit_price: 4)
    @candle = @merchant.items.create!(name: "Candle of life", description: "candle that gifts everlasting life", unit_price: 15)
    @potion = @merchant.items.create!(name: "Love potion", description: "One serving size of true love potion", unit_price: 10)
    @scroll = @merchant.items.create!(name: "Scroll of healing", description: "A scroll which when read aloud, heals your wounds.", unit_price: 9)
    @bone = @merchant.items.create!(name: "Bird bones", description: "Complete (not intact) skeleton of crow. For use as spell components.", unit_price: 2)
    @wand = @merchant.items.create!(name: "Willow birch wand", description: "Newly made 12-inch willow birch wand.", unit_price: 3)

    customer = Customer.create!(first_name: "Gandalf", last_name: "Thegrey")

    feb_third = DateTime.new(2022,2,3,4,5,6)
    march_third = DateTime.new(2022,3,3,6,2,3)
    april_first = DateTime.new(2022,4,1,8,9,6)

    invoice_1 = customer.invoices.create!(status: 1, created_at: feb_third)
    invoice_2 = customer.invoices.create!(status: 1, created_at: march_third)
    invoice_3 = customer.invoices.create!(status: 1, created_at: april_first)

    InvoiceItem.create!(invoice: invoice_1, item: @book, quantity: 2, unit_price: 4, status: 2)
    InvoiceItem.create!(invoice: invoice_1, item: @candle, quantity: 2, unit_price: 15, status: 2)
    InvoiceItem.create!(invoice: invoice_2, item: @potion, quantity: 2, unit_price: 10, status: 2)
    InvoiceItem.create!(invoice: invoice_2, item: @scroll, quantity: 2, unit_price: 9, status: 2)
    InvoiceItem.create!(invoice: invoice_2, item: @bone, quantity: 1, unit_price: 2, status: 2)
    InvoiceItem.create!(invoice: invoice_3, item: @wand, quantity: 1, unit_price: 3, status: 0)
    InvoiceItem.create!(invoice: invoice_3, item: @scroll, quantity: 6, unit_price: 9, status: 0)

    invoice_1.transactions.create!(credit_card_number: 123456789, credit_card_expiration_date: "07/2023", result: "success")
    invoice_1.transactions.create!(credit_card_number: 123456789, credit_card_expiration_date: "07/2023", result: "failed")
    invoice_2.transactions.create!(credit_card_number: 123456789, credit_card_expiration_date: "07/2023", result: "success")
    invoice_3.transactions.create!(credit_card_number: 123456789, credit_card_expiration_date: "07/2023", result: "failed")

    @other_merchant = Merchant.create!(name: "Joe's Pickle Bus")
    @other_merchant.items.create!(name: "Fried pickles", description: "a packet of fried pickles", unit_price: 2)
    @other_merchant.items.create!(name: "Pickled cabbage", description: "a packet of pickled cabbage", unit_price: 1)
  end

  describe "When I visit merchants/:merchant_id/items" do
    it "displays a list of the names of all my items and I do not see items for any other merchant" do
      visit "/merchants/#{@merchant.id}/items"

      within "#disabled" do
        within "#item-#{@book.id}" do
          expect(page).to have_content("Book of the dead")
        end
        within "#item-#{@candle.id}" do
          expect(page).to have_content("Candle of life")
        end
        within "#item-#{@potion.id}" do
          expect(page).to have_content("Love potion")
        end
        within "#item-#{@scroll.id}" do
          expect(page).to have_content("Scroll of healing")
        end
        within "#item-#{@bone.id}" do
          expect(page).to have_content("Bird bones")
        end
        within "#item-#{@wand.id}" do
          expect(page).to have_content("Willow birch wand")
        end
      end

      expect(page).to_not have_content("Fried pickles")
      expect(page).to_not have_content("Pickled cabbage")
    end

    it "when I click on the name of an item from the index page, I am taken to the show page" do
      visit merchant_items_path(@merchant)

      expect(page).to have_link("Book of the dead", href: merchant_item_path(@merchant, @book))
      expect(page).to have_link("Candle of life", href: merchant_item_path(@merchant, @candle))
      expect(page).to have_link("Love potion", href: merchant_item_path(@merchant, @potion))

      within "#disabled" do
        within "#item-#{@book.id}" do
          click_on("Book of the dead")
        end
      end

      expect(current_path).to eq(merchant_item_path(@merchant, @book))
    end

    it "displays items grouped by status and disable/enable buttons for each item, when clicked, reloads index and the items status is changed" do
      visit "merchants/#{@merchant.id}/items"

      within "#disabled" do
        within "#item-#{@book.id}" do
          expect(page).to have_button("Enable")
        end
        within "#item-#{@candle.id}" do
          expect(page).to have_button("Enable")
        end
        within "#item-#{@potion.id}" do
          expect(page).to have_button("Enable")
          click_button("Enable")
        end
      end

      expect(current_path).to eq(merchant_items_path(@merchant))

      within "#disabled" do
        within "#item-#{@book.id}" do
          expect(page).to have_button("Enable")
        end
        within "#item-#{@candle.id}" do
          expect(page).to have_button("Enable")
        end
      end

      within "#enabled" do
        within "#item-#{@potion.id}" do
          expect(page).to have_button("Disable")
          click_button("Disable")
        end
      end

      expect(current_path).to eq(merchant_items_path(@merchant))
      within "#disabled" do
        within "#item-#{@book.id}" do
          expect(page).to have_button("Enable")
        end
        within "#item-#{@candle.id}" do
          expect(page).to have_button("Enable")
        end
        within "#item-#{@potion.id}" do
          expect(page).to have_button("Enable")
        end
      end
    end

    it "has a link to 'New Item' which takes me to a form to create a new item" do
      visit "/merchants/#{@merchant.id}/items"

      expect(page).to have_link("New Item", href: new_merchant_item_path(@merchant))

      click_on("New Item")

      expect(current_path).to eq(new_merchant_item_path(@merchant))
    end

    it "displays the names of the top 5 most popular items ranked by total revenue generated. Each name links to the item's show page" do
      visit "merchants/#{@merchant.id}/items"

      within "#top-items" do
        expect("Candle of life: $30.00").to appear_before("Love potion: $20.00 in sales", only_text: true)
        expect("Love potion: $20.00 in sales").to appear_before("Scroll of healing: $18.00 in sales", only_text: true)
        expect("Scroll of healing: $18.00 in sales").to appear_before("Book of the dead: $8.00 in sales", only_text: true)
        expect("Book of the dead: $8.00 in sales").to appear_before("Bird bones: $2.00 in sales", only_text: true)

        expect(page).to have_link("Candle of life", href: merchant_item_path(@merchant, @candle))
        expect(page).to have_link("Love potion", href: merchant_item_path(@merchant, @potion))
        expect(page).to have_link("Scroll of healing", href: merchant_item_path(@merchant, @scroll))
        expect(page).to have_link("Book of the dead", href: merchant_item_path(@merchant, @book))
        expect(page).to have_link("Bird bones", href: merchant_item_path(@merchant, @bone))
      end
    end

    it "displays the date with the most sales for each item with label 'Top selling date for <item> was <date>'" do
      visit "merchants/#{@merchant.id}/items"

      within "#top-items" do
        expect(page).to have_content("Top selling date for Candle of life was 2/3/22")
        expect(page).to have_content("Top selling date for Love potion was 3/3/22")
        expect(page).to have_content("Top selling date for Scroll of healing was 3/3/22")
        expect(page).to have_content("Top selling date for Book of the dead was 2/3/22")
        expect(page).to have_content("Top selling date for Bird bones was 3/3/22")
      end
    end
  end

  describe "Wireframe requirements for merchants items index page" do
    it "has the little esty shop heading, nav bar, My Items header, and merchant's name" do
      visit "merchants/#{@merchant.id}/items"

      expect(page).to have_content("Little Esty Shop")
      expect(page).to have_content("Practical Magic Shop")
      expect(page).to have_content("Dashboard")
      expect(page).to have_content("My Items")
      expect(page).to have_content("My Invoices")
    end
  end
end