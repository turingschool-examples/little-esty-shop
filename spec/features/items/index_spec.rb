require 'rails_helper'

RSpec.describe 'merchant items index page', type: :feature do
  describe 'as a merchant' do
    describe 'when I visit my merchant items index page (/merchants/:id/items)' do
      before :each do
        @crystal_moon = Merchant.create!(name: "Crystal Moon Designs")
        @surf_designs = Merchant.create!(name: "Surf & Co. Designs")

        @pearl = @crystal_moon.items.create!(name: "Pearl", description: "Not a BlackPearl!", unit_price: 25)
        @moon_rock = @crystal_moon.items.create!(name: "Moon Rock", description: "Evolve Your Pokemon!", unit_price: 105)
        @lapis_lazuli = @crystal_moon.items.create!(name: "Lapis Lazuli", description: "Not the Jewel Knight!", unit_price: 45)
        @topaz = @crystal_moon.items.create!(name: "Topaz", description: "Just Another Topaz!", unit_price: 55)
        @amethyst = @crystal_moon.items.create!(name: "Amethyst", description: "Common Loot!", unit_price: 55)
        @emerald = @crystal_moon.items.create!(name: "Emerald", description: "Where's Sonic?", unit_price: 85)
        @ruby = @crystal_moon.items.create!(name: "Ruby", description: "Razzle Dazzle?", unit_price: 65)
        @sapphire = @crystal_moon.items.create!(name: "Sapphire", description: "Deep Blue!", unit_price: 45)
        @dream_catcher = @crystal_moon.items.create!(name: "Midnight Dream Catcher", description: "Catch the magic of your dreams!", unit_price: 25)
        @rose_quartz = @crystal_moon.items.create!(name: "Rose Quartz Pendant", description: "Manifest the love of your life!", unit_price: 37)
        @tarot_deck = @crystal_moon.items.create!(name: "Witchy Tarot Deck", description: "Unveil your true path!", unit_price: 22)
        @wax = @surf_designs.items.create!(name: "Board Wax", description: "Hang ten!", unit_price: 7)
        @rash_guard = @surf_designs.items.create!(name: "Radical Rash Guard", description: "Stay totally groovy and rash free!", unit_price: 50)
        @zinc = @surf_designs.items.create!(name: "100% Zinc Face Protectant", description: "Our original organic formula!", unit_price: 13)


        @paul = Customer.create!(first_name: "Paul", last_name: "Walker")
        @sam = Customer.create!(first_name: "Sam", last_name: "Gamgee")
        @abbas = Customer.create!(first_name: "Abbas", last_name: "Firnas")
        @hamada = Customer.create!(first_name: "Hamada", last_name: "Hilal")
        @frodo = Customer.create!(first_name: "Frodo", last_name: "Baggins")
        @eevee = Customer.create!(first_name: "Eevee", last_name: "Ketchup")

        @invoice_1 = Invoice.create!(status: 2, customer_id: @paul.id)
        @invoice_2 = Invoice.create!(status: 2, customer_id: @paul.id)
        @invoice_3 = Invoice.create!(status: 2, customer_id: @sam.id)
        @invoice_4 = Invoice.create!(status: 2, customer_id: @sam.id)
        @invoice_5 = Invoice.create!(status: 2, customer_id: @abbas.id)
        @invoice_6 = Invoice.create!(status: 2, customer_id: @abbas.id)
        @invoice_7 = Invoice.create!(status: 2, customer_id: @hamada.id)
        @invoice_8 = Invoice.create!(status: 2, customer_id: @hamada.id)
        @invoice_9 = Invoice.create!(status: 2, customer_id: @frodo.id)
        @invoice_10 = Invoice.create!(status: 2, customer_id: @frodo.id)
        @invoice_11 = Invoice.create!(status: 2, customer_id: @eevee.id)
        @invoice_12 = Invoice.create!(status: 2, customer_id: @paul.id)
        @invoice_13 = Invoice.create!(status: 2, customer_id: @sam.id)
        @invoice_14 = Invoice.create!(status: 2, customer_id: @eevee.id)

        @pearl_invoice = InvoiceItem.create!(item_id: @pearl.id, invoice_id: @invoice_1.id, quantity: 2, unit_price: 25, status: 1)
        @moon_rock_invoice = InvoiceItem.create!(item_id: @moon_rock.id, invoice_id: @invoice_2.id, quantity: 2, unit_price: 105, status: 1)
        @lapis_lazuli_invoice = InvoiceItem.create!(item_id: @lapis_lazuli.id, invoice_id: @invoice_3.id, quantity: 2, unit_price: 45, status: 1)
        @topaz_invoice = InvoiceItem.create!(item_id: @topaz.id, invoice_id: @invoice_4.id, quantity: 2, unit_price: 55, status: 1)
        @amethyst_invoice = InvoiceItem.create!(item_id: @amethyst.id, invoice_id: @invoice_5.id, quantity: 2, unit_price: 55, status: 2)
        @emerald_invoice = InvoiceItem.create!(item_id: @emerald.id, invoice_id: @invoice_6.id, quantity: 2, unit_price: 85, status: 2)
        @ruby_invoice = InvoiceItem.create!(item_id: @ruby.id, invoice_id: @invoice_7.id, quantity: 2, unit_price: 65, status: 2)
        @sapphire_invoice = InvoiceItem.create!(item_id: @sapphire.id, invoice_id: @invoice_8.id, quantity: 2, unit_price: 45, status: 2)
        @dream_catcher_invoice = InvoiceItem.create!(item_id: @dream_catcher.id, invoice_id: @invoice_9.id, quantity: 2, unit_price: 25, status: 2)
        @rose_quartz_invoice = InvoiceItem.create!(item_id: @rose_quartz.id, invoice_id: @invoice_10.id, quantity: 2, unit_price: 37, status: 2)
        @tarot_deck_invoice = InvoiceItem.create!(item_id: @tarot_deck.id, invoice_id: @invoice_11.id, quantity: 2, unit_price: 22, status: 2)
        @wax_invoice = InvoiceItem.create!(item_id: @wax.id, invoice_id: @invoice_12.id, quantity: 2, unit_price: 7, status: 2)
        @rash_guard_invoice = InvoiceItem.create!(item_id: @rash_guard.id, invoice_id: @invoice_13.id, quantity: 2, unit_price: 50, status: 2)
        @zinc_invoice = InvoiceItem.create!(item_id: @zinc.id, invoice_id: @invoice_14.id, quantity: 2, unit_price: 13, status: 1)

        @transaction_1 = Transaction.create!(result: 1, invoice_id: @invoice_1.id, credit_card_number: 0001)
        @transaction_2 = Transaction.create!(result: 1, invoice_id: @invoice_2.id, credit_card_number: 0002)
        @transaction_3 = Transaction.create!(result: 1, invoice_id: @invoice_3.id, credit_card_number: 0003)
        @transaction_4 = Transaction.create!(result: 1, invoice_id: @invoice_4.id, credit_card_number: 0004)
        @transaction_5 = Transaction.create!(result: 1, invoice_id: @invoice_5.id, credit_card_number: 0005)
        @transaction_6 = Transaction.create!(result: 1, invoice_id: @invoice_6.id, credit_card_number: 0006)
        @transaction_7 = Transaction.create!(result: 1, invoice_id: @invoice_7.id, credit_card_number: 0007)
        @transaction_8 = Transaction.create!(result: 1, invoice_id: @invoice_8.id, credit_card_number: 0010)
        @transaction_9 = Transaction.create!(result: 1, invoice_id: @invoice_9.id, credit_card_number: 0011)
        @transaction_10 = Transaction.create!(result: 1, invoice_id: @invoice_10.id, credit_card_number: 0012)
        @transaction_11 = Transaction.create!(result: 1, invoice_id: @invoice_11.id, credit_card_number: 0013)
        @transaction_12 = Transaction.create!(result: 1, invoice_id: @invoice_12.id, credit_card_number: 0014)
        @transaction_13 = Transaction.create!(result: 1, invoice_id: @invoice_13.id, credit_card_number: 0015)
        @transaction_14 = Transaction.create!(result: 1, invoice_id: @invoice_14.id, credit_card_number: 0016)
      end

      it '- lists the names of all of my items, and I do not see items for any other merchant' do

        visit merchant_items_path(@crystal_moon)

        expect(page).to have_content("Welcome To Crystal Moon Designs")
        expect(page).to have_content("Midnight Dream Catcher")
        expect(page).to have_content("Rose Quartz Pendant")
        expect(page).to have_content("Witchy Tarot Deck")
        expect(page).to_not have_content("Welcome To Surf & Co. Designs")
        expect(page).to_not have_content("Board Wax")
      end

      it 'should have each item name as a link that redirects to the show page of that item' do
        visit merchant_items_path(@crystal_moon)

        expect(page).to have_link("Midnight Dream Catcher")

        click_link "Midnight Dream Catcher"

        expect(page).to have_current_path(merchant_item_path(@crystal_moon, @dream_catcher))
        expect(page).to have_content("Item: Midnight Dream Catcher")
      end

      it '- next to each item name I see a button to disable or enable that item.
      when I click this button, I am redirected back to the items index and I see
      that the items status has changed' do
        visit merchant_items_path(@surf_designs)

        expect(page).to have_button("Disable Board Wax")
        expect(page).to have_content("available for purchase")

        click_button "Disable Board Wax"
        expect(current_path).to eq("/merchants/#{@surf_designs.id}/items")

        expect(page).to have_content("Status: not available for purchase")
        expect(page).to have_button("Enable Board Wax")

        click_button "Enable Board Wax"
        expect(current_path).to eq("/merchants/#{@surf_designs.id}/items")

        expect(page).to have_content("Status: available for purchase")
      end

      it '- I see two sections, one for enabled items, and one for disabled items.
      I see that each item it listed in the appropriate section' do
        visit merchant_items_path(@crystal_moon)

        within "#enabled" do
          expect(page).to have_content("Midnight Dream Catcher")
          expect(page).to have_content("Rose Quartz Pendant")
          expect(page).to have_content("Witchy Tarot Deck")
        end

        within "#disabled" do
          expect(page).to_not have_content("Midnight Dream Catcher")
          expect(page).to_not have_content("Rose Quartz Pendant")
          expect(page).to_not have_content("Witchy Tarot Deck")
        end

        click_button "Disable Rose Quartz Pendant"

        within "#enabled" do
          expect(page).to have_content("Midnight Dream Catcher")
          expect(page).to have_content("Witchy Tarot Deck")
          expect(page).to_not have_content("Rose Quartz Pendant")
        end

        within "#disabled" do
          expect(page).to have_content("Rose Quartz Pendant")
          expect(page).to_not have_content("Midnight Dream Catcher")
          expect(page).to_not have_content("Witchy Tarot Deck")
        end

        click_button "Disable Midnight Dream Catcher"

        within "#enabled" do
          expect(page).to have_content("Witchy Tarot Deck")
          expect(page).to_not have_content("Midnight Dream Catcher")
          expect(page).to_not have_content("Rose Quartz Pendant")
        end

        within "#disabled" do
          expect(page).to have_content("Rose Quartz Pendant")
          expect(page).to have_content("Midnight Dream Catcher")
          expect(page).to_not have_content("Witchy Tarot Deck")
        end

        click_button "Enable Midnight Dream Catcher"

        within "#enabled" do
          expect(page).to have_content("Midnight Dream Catcher")
          expect(page).to have_content("Witchy Tarot Deck")
          expect(page).to_not have_content("Rose Quartz Pendant")
        end

        within "#disabled" do
          expect(page).to have_content("Rose Quartz Pendant")
          expect(page).to_not have_content("Midnight Dream Catcher")
          expect(page).to_not have_content("Witchy Tarot Deck")
        end
      end

      it '- I see a link to create a new item.  when I click the link, I am directed to (/merchants/:id/items/new)' do
        visit merchant_items_path(@surf_designs)

        click_link 'Create New Item'

        expect(current_path).to eq("/merchants/#{@surf_designs.id}/items/new")
      end

      it "has a section for the top 5 items by revenue for the merchant" do

        visit merchant_items_path(@crystal_moon)
        
        expect(page).to have_content("Top 5 Items")
        expect(page).to have_content("Moon Rock: 210")
        expect(page).to have_content("Emerald: 170")
        expect(page).to have_content("Ruby: 130")
        expect(page).to have_content("Amethyst: 110")
        expect(page).to have_content("Topaz: 110")
        expect("Moon Rock").to appear_before("Emerald")
        expect("Emerald").to appear_before("Ruby")
        expect("Ruby").to appear_before("Amethyst")
        expect("Amethyst").to appear_before("Topaz")
      end

      it "s top 5 items' names are links to their respective pages" do
        visit merchant_items_path(@crystal_moon)

        within "#top_items" do
          click_link "Moon Rock"
        end

        expect(current_path).to eql(merchant_item_path(@crystal_moon, @moon_rock))
      end

      it 'has the date with the most sales for each of the top 5 most popular items' do
        visit merchant_items_path(@crystal_moon)

        within "#top_items" do
          expect(page).to have_content("The top selling date for Moon Rock was #{@moon_rock_invoice.created_at}")
          expect(page).to have_content("The top selling date for Emerald was #{@emerald_invoice.created_at}")
          expect(page).to have_content("The top selling date for Ruby was #{@ruby_invoice.created_at}")
          expect(page).to have_content("The top selling date for Amethyst was #{@amethyst_invoice.created_at}")
          expect(page).to have_content("The top selling date for Topaz was #{@topaz_invoice.created_at}")
        end
      end
    end
  end
end
