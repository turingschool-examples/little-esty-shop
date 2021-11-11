require 'rails_helper'

RSpec.describe 'the merchants items index' do
  describe 'as a merchant' do
    before :each do
      @merchant = Merchant.create(name: 'Toys and Stuff')
      @item_1 = @merchant.items.create(
        name: 'fidget spinner',
        description: 'it spins',
        unit_price: 1500
      )
      @item_2 = @merchant.items.create(
        name: 'yo-yo',
        description: 'do some cool tricks!',
        unit_price: 1000
      )
    end

    it 'shows all of the items for this merchant' do
      visit "/merchants/#{@merchant.id}/items"

      expect(page).to have_content @item_1.name
      expect(page).to have_content @item_2.name
    end

    it 'each item on my items index is a link to the show page' do
      visit "/merchants/#{@merchant.id}/items"

      click_on @item_1.name

      expect(current_path).to eq "/merchants/#{@merchant.id}/items/#{@item_1.id}"
    end

    it 'each item has an edit button' do
      visit "/merchants/#{@merchant.id}/items"

      within "div#item-#{@item_1.id}" do
        expect(page).to have_link "Edit this item"

        click_link "Edit this item"
      end

      expect(current_path).to eq "/merchants/#{@merchant.id}/items/#{@item_1.id}/edit"
    end

    describe 'item create' do
      it 'I see a link to create a new item' do
        visit "/merchants/#{@merchant.id}/items"

        expect(page).to have_link "Create a new item"

        click_link "Create a new item"

        expect(current_path).to eq "/merchants/#{@merchant.id}/items/new"
      end

      it 'the page has a form that creates a new item when submitted' do
        visit "/merchants/#{@merchant.id}/items/new"
        fill_in :name, with: 'fidget spinner'
        fill_in :description, with: 'it spins'
        fill_in :unit_price, with: '15.00'
        click_on 'Save'

        expect(current_path).to eq "/merchants/#{@merchant.id}/items"
        expect(page).to have_content 'fidget spinner'
        # user story says the item's status should be disabled by default?
        # items don't have a status so I'm not sure about this one...
      end
    end

    describe 'top items by revenue section' do
      it 'displays the top 5 items by revenue (ii.quantity * ii.unit_price)' do
        merchant = Merchant.create(name: "Friendly Traveling Merchant")
        item_1 = merchant.items.create(name: 'YoYo', description: 'its on a string', unit_price: 1000)
        item_2 = merchant.items.create(name: 'raisin', description: 'dried grape', unit_price: 100)
        item_3 = merchant.items.create(name: 'apple', description: 'nice and crisp', unit_price: 500)
        item_4 = merchant.items.create(name: 'banana', description: 'mushy but good', unit_price: 200)
        item_5 = merchant.items.create(name: 'pear', description: 'refreshing treat', unit_price: 600)

        customer_1 = Customer.create(first_name: 'George', last_name: 'Washington')
        invoice_1 = customer_1.invoices.create(status: 2)
        invoice_2 = customer_1.invoices.create(status: 2)
        invoice_3 = customer_1.invoices.create(status: 2)
        invoice_item_1 = invoice_1.invoice_items.create(item_id: item_1.id, quantity: 3, unit_price: 1000, status: 'shipped')
        invoice_item_2 = invoice_1.invoice_items.create(item_id: item_2.id, quantity: 1, unit_price: 100, status: 'shipped')
        invoice_item_3 = invoice_1.invoice_items.create(item_id: item_3.id, quantity: 1, unit_price: 400, status: 'shipped')
        invoice_item_4 = invoice_2.invoice_items.create(item_id: item_4.id, quantity: 1, unit_price: 200, status: 'shipped')
        invoice_item_5 = invoice_2.invoice_items.create(item_id: item_5.id, quantity: 1, unit_price: 600, status: 'shipped')
        invoice_item_6 = invoice_3.invoice_items.create(item_id: item_5.id, quantity: 2, unit_price: 500, status: 'shipped')
        invoice_item_7 = invoice_3.invoice_items.create(item_id: item_5.id, quantity: 1, unit_price: 600, status: 'shipped')

        transaction_1 = invoice_1.transactions.create(credit_card_number: 1234123412341234, credit_card_expiration_date: '2012-03-27', result: 'failed')
        transaction_2 = invoice_1.transactions.create(credit_card_number: 1234123412341234, credit_card_expiration_date: '2012-03-27', result: 'success')
        transaction_3 = invoice_2.transactions.create(credit_card_number: 1234123412341234, credit_card_expiration_date: '2012-03-27', result: 'success')
        transaction_4 = invoice_3.transactions.create(credit_card_number: 1234123412341234, credit_card_expiration_date: '2012-03-27', result: 'failed')
        transaction_4 = invoice_3.transactions.create(credit_card_number: 1234123412341234, credit_card_expiration_date: '2012-03-27', result: 'success')

        visit "/merchants/#{merchant.id}/items"

        expect(page).to have_content 'Top Items'

        within 'div#top-items' do
          expect(item_1.name).to appear_before item_5.name
          expect(item_5.name).to appear_before item_3.name
          expect(item_3.name).to appear_before item_4.name
          expect(item_4.name).to appear_before item_2.name
          expect(page).to have_content "#{item_5.name} - $22.00 in sales"
        end
      end
    end

    it "disable/enable items" do
      item_1 = @merchant.items.create(
        name: 'fidget spinner',
        description: 'it spins',
        unit_price: 1500,
        status: "able"
      )

      visit "/merchants/#{@merchant.id}/items"

      within "div#item-#{item_1.id}" do
        click_on "Enable/Disable"
      end

      expect(current_path).to eq("/merchants/#{@merchant.id}/items")
      expect(page).to have_content("Status: Unable")

      within "div#item-#{item_1.id}" do
        click_on "Enable/Disable"
      end

      expect(current_path).to eq("/merchants/#{@merchant.id}/items")
      expect(item_1.status).to eq("able")
      expect(page).to have_content("Status: Able")
    end

    it "group items by status" do
      merchant = Merchant.create(name: "Friendly Traveling Merchant")
      item_1 = merchant.items.create(name: 'YoYo', description: 'its on a string', unit_price: 1000)
      item_2 = merchant.items.create(name: 'raisin', description: 'dried grape', unit_price: 100)
      item_3 = merchant.items.create(name: 'apple', description: 'nice and crisp', unit_price: 500, status: 'unable')
      item_4 = merchant.items.create(name: 'banana', description: 'mushy but good', unit_price: 200, status: 'unable')
      item_5 = merchant.items.create(name: 'pear', description: 'refreshing treat', unit_price: 600, status: 'unable')

      visit "/merchants/#{merchant.id}/items"
      expect(page).to have_content("Enabled Items:")
      expect(page).to have_content("Disabled Items:")

      within("div#enabled-items") do
        expect(page).to have_content(item_1.name)
        expect(page).to have_content(item_2.name)
        expect(page).to_not have_content(item_3.name)
      end

      within("div#disabled-items") do
        expect(page).to have_content(item_3.name)
        expect(page).to have_content(item_4.name)
        expect(page).to have_content(item_5.name)
      end
    end

    it "top item's best day" do
      merchant = Merchant.create(name: "Friendly Traveling Merchant")
      item_1 = merchant.items.create(name: 'YoYo', description: 'its on a string', unit_price: 1000)
      item_2 = merchant.items.create(name: 'raisin', description: 'dried grape', unit_price: 100)
      item_3 = merchant.items.create(name: 'apple', description: 'nice and crisp', unit_price: 500)
      item_4 = merchant.items.create(name: 'banana', description: 'mushy but good', unit_price: 200)
      item_5 = merchant.items.create(name: 'pear', description: 'refreshing treat', unit_price: 600)

      customer_1 = Customer.create(first_name: 'George', last_name: 'Washington')

      invoice_1 = customer_1.invoices.create(status: 2)
      invoice_2 = customer_1.invoices.create(status: 2, created_at: "2012-03-24")
      invoice_3 = customer_1.invoices.create(status: 2, created_at: "2012-03-25")
      invoice_4 = customer_1.invoices.create(status: 2, created_at: "2012-03-27")
      invoice_5 = customer_1.invoices.create(status: 2, created_at: "2012-03-28")

      invoice_item_1 = invoice_1.invoice_items.create(item_id: item_1.id, quantity: 3, unit_price: 1000, status: 'shipped')
      invoice_item_2 = invoice_1.invoice_items.create(item_id: item_2.id, quantity: 1, unit_price: 100, status: 'shipped')
      invoice_item_3 = invoice_1.invoice_items.create(item_id: item_3.id, quantity: 1, unit_price: 400, status: 'shipped')

#for testing same revenue, return most recent date - invoice_5.created_at, item_4
      invoice_item_4 = invoice_2.invoice_items.create(item_id: item_4.id, quantity: 1, unit_price: 200, status: 'shipped')
      invoice_item_5 = invoice_4.invoice_items.create(item_id: item_4.id, quantity: 1, unit_price: 200, status: 'shipped')
      invoice_item_6 = invoice_5.invoice_items.create(item_id: item_4.id, quantity: 1, unit_price: 200, status: 'shipped')

      invoice_item_7 = invoice_2.invoice_items.create(item_id: item_5.id, quantity: 1, unit_price: 600, status: 'shipped')
      invoice_item_8 = invoice_3.invoice_items.create(item_id: item_5.id, quantity: 2, unit_price: 500, status: 'shipped')
      invoice_item_9 = invoice_3.invoice_items.create(item_id: item_5.id, quantity: 1, unit_price: 600, status: 'shipped')

      transaction_1 = invoice_1.transactions.create(credit_card_number: 1234123412341234, credit_card_expiration_date: '2012-03-27', result: 'success')
      transaction_2 = invoice_2.transactions.create(credit_card_number: 1234123412341234, credit_card_expiration_date: '2012-03-27', result: 'success')
      transaction_3 = invoice_3.transactions.create(credit_card_number: 1234123412341234, credit_card_expiration_date: '2012-03-27', result: 'success')
      transaction_4 = invoice_4.transactions.create(credit_card_number: 1234123412341234, credit_card_expiration_date: '2012-03-27', result: 'success')
      transaction_5 = invoice_5.transactions.create(credit_card_number: 1234123412341234, credit_card_expiration_date: '2012-03-27', result: 'success')

      visit "/merchants/#{merchant.id}/items"

      within 'div#top-items' do
        expect(page).to have_content("Top selling date for #{item_4.name} is #{invoice_5.created_at.strftime("%A, %B %-d, %Y")}")
        expect(page).to have_content("Top selling date for #{item_5.name} is #{invoice_3.created_at.strftime("%A, %B %-d, %Y")}")
      end
    end
  end
end
