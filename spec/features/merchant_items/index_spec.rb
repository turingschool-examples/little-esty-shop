require 'rails_helper'

RSpec.describe 'the merchants items index' do
  describe 'as a merchant' do
    before :each do
      @merchant = Merchant.create(name: 'Toys and Stuff')
    end

    it 'shows all of the items for this merchant' do
      item_1 = @merchant.items.create(
        name: 'fidget spinner',
        description: 'it spins',
        unit_price: 1500
      )
      item_2 = @merchant.items.create(
        name: 'yo-yo',
        description: 'do some cool tricks!',
        unit_price: 1000
      )

      visit "/merchants/#{@merchant.id}/items"

      expect(page).to have_content item_1.name
      expect(page).to have_content item_2.name
    end

    it 'each item on my items index is a link to the show page' do
      item = @merchant.items.create(
        name: 'fidget spinner',
        description: 'it spins',
        unit_price: 1500
      )

      visit "/merchants/#{@merchant.id}/items"
      click_on item.name

      expect(current_path).to eq "/merchants/#{@merchant.id}/items/#{item.id}"
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
        invoice_1 = customer_1.invoices.create(status: 'Completed')
        invoice_2 = customer_1.invoices.create(status: 'Completed')
        invoice_3 = customer_1.invoices.create(status: 'Completed')
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

      click_on "Enable/Disable"

      expect(current_path).to eq("/merchants/#{@merchant.id}/items")
      expect(item_1.status).to eq("unable")

      click_on "Enable/Disable"
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

    xit "top item's best day" do
      merchant = Merchant.create(name: "Friendly Traveling Merchant")
      item_1 = merchant.items.create(name: 'YoYo', description: 'its on a string', unit_price: 1000)
      item_2 = merchant.items.create(name: 'raisin', description: 'dried grape', unit_price: 100)
      item_3 = merchant.items.create(name: 'apple', description: 'nice and crisp', unit_price: 500)
      item_4 = merchant.items.create(name: 'banana', description: 'mushy but good', unit_price: 200)
      item_5 = merchant.items.create(name: 'pear', description: 'refreshing treat', unit_price: 600)
      customer_1 = Customer.create(first_name: 'George', last_name: 'Washington')
      invoice_1 = customer_1.invoices.create(status: 'Completed')
      invoice_2 = customer_1.invoices.create(status: 'Completed')
      invoice_3 = customer_1.invoices.create(status: 'Completed')
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

      within 'div#top-items' do
        expect("Top selling date for #{item_1.name} was").to appear_before("Top selling date for #{item_5.name} was")
        expect("Top selling date for #{item_4.name} was").to appear_before("Top selling date for #{item_2.name} was")
        expect(item_5.name).to appear_before item_3.name
        expect(item_3.name).to appear_before item_4.name
        expect(item_4.name).to appear_before item_2.name
        expect(page).to have_content "#{item_5.name} - $22.00 in sales"
      end
    end
# next to each of the 5 most popular items
# I see the date with the most sales for each item.
# And I see a label “Top selling date for was "  TESTING UP TO HERE
#
# Note: use the invoice date. If there are multiple
# days with equal number of sales, return the most recent day.
#item order = item_1, 5, 3, 4, 2

  end
end
