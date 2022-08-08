require 'rails_helper'

RSpec.describe 'merchant items index page' do
  context 'merchant items user story' do
    it 'lets us see all the item names a merchant has' do
      khajit = Merchant.create!(name: "Khajit")
      bob = Merchant.create!(name: "Bob The Burgerman")

      item_1 = khajit.items.create!(name: "Skooma", description: "Khajit has wares if you have coin", unit_price: 1420 )
      item_2 = bob.items.create!(name: "Burgers", description: "Best Burgers in Town!", unit_price: 599 )
      item_3 = bob.items.create!(name: "Fries", description: "Gene stop eating the fries, they`re for customers", unit_price: 250 )

      visit "/merchants/#{bob.id}/items"

      within "#item-#{item_2.id}" do
        expect(page).to have_content("Burgers")
        expect(page).to_not have_content("Skooma")
      end

      within "#item-#{item_3.id}" do
        expect(page).to have_content("Fries")
        expect(page).to_not have_content("Skooma")
      end
    end

    it 'can click on the name of an item and be redirected to that merchants items show page' do
      merchant_1 = Merchant.create!(name: 'Spongebob The Merchant')

      spatula = Item.create!(name: 'Spatula', description: 'It is for cooking', unit_price: 3, merchant_id: merchant_1.id)
      spoon = Item.create!(name: 'Spoon', description: 'It is for eating ice cream', unit_price: 1, merchant_id: merchant_1.id)

      visit "/merchants/#{merchant_1.id}/items"

      expect(page).to have_link('Spatula')
      expect(page).to have_link('Spoon')

      within "#item-#{spatula.id}" do
        click_on('Spatula')
      end

      expect(current_path).to eq("/merchants/#{merchant_1.id}/items/#{spatula.id}")
    end

    it 'has a link to that brings you to a form to add an item' do
      merchant_1 = Merchant.create!(name: 'Spongebob The Merchant')

      spatula = Item.create!(name: 'Spatula', description: 'It is for cooking', unit_price: 3, merchant_id: merchant_1.id)
      spoon = Item.create!(name: 'Spoon', description: 'It is for eating ice cream', unit_price: 1, merchant_id: merchant_1.id)

      visit "/merchants/#{merchant_1.id}/items"

      within "#create-item" do
        expect(page).to have_link("New Item")
      end

      click_on('New Item')

      expect(current_path).to eq("/merchants/#{merchant_1.id}/items/new")
    end
  end

  describe 'Merchant Item disable / enable button' do
    context 'button to enable / disable every item on merchant index page' do
      it 'has a button to enable / disable an item' do
        bob = Merchant.create!(name: "Bob The Burgerman")

        item_1 = bob.items.create!(name: "Burgers", description: "Best Burgers in Town!", unit_price: 599 )
        item_2 = bob.items.create!(name: "Fries", description: "Gene stop eating the fries, they`re for customers", unit_price: 250 )

        visit "/merchants/#{bob.id}/items"

        within "#item-#{item_1.id}" do
          expect(page).to have_selector(:link_or_button, "Enable Burgers")
          expect(page).to have_selector(:link_or_button, "Disable Burgers")
          expect(page).to_not have_selector(:link_or_button, "Enable Fries")
          expect(page).to_not have_selector(:link_or_button, "Disable Fries")
        end

        within "#item-#{item_2.id}" do
          expect(page).to have_selector(:link_or_button, "Enable Fries")
          expect(page).to have_selector(:link_or_button, "Disable Fries")
          expect(page).to_not have_selector(:link_or_button, "Enable Burgers")
          expect(page).to_not have_selector(:link_or_button, "Disable Burgers")
        end
      end
    end

    context 'change items status' do
      it 'changes the items status to enabled & disabled' do
        bob = Merchant.create!(name: "Bob The Burgerman")

        item_1 = bob.items.create!(name: "Burgers", description: "Best Burgers in Town!", unit_price: 599)
        item_2 = bob.items.create!(name: "Fries", description: "Gene stop eating the fries, they`re for customers", unit_price: 250)

        visit "/merchants/#{bob.id}/items"

        within "#item-#{item_1.id}" do
          expect(page).to have_content("Status:")
        end

        click_on "Enable Burgers"

        within "#item-#{item_1.id}" do
          expect(page).to have_current_path("/merchants/#{bob.id}/items")
          expect(page).to have_content("Status: Enabled")
          expect(page).to_not have_content("Status: Disabled")
        end

        click_on "Disable Fries"

        within "#item-#{item_2.id}" do
          expect(page).to have_current_path("/merchants/#{bob.id}/items")
          expect(page).to have_content("Status: Disabled")
          expect(page).to_not have_content("Status: Enabled")
        end
      end
    end

    it 'shows the 5 most popular items' do
      merchant_1 = Merchant.create!(name: 'Spongebob The Merchant')
      merchant_2 = Merchant.create!(name: 'Sandy The Squirrel Merchant')

      customer_1 = Customer.create!(first_name: 'Somany', last_name: 'Damntests')
      customer_2 = Customer.create!(first_name: 'Keeling', last_name: 'Mesoftly')
      customer_3 = Customer.create!(first_name: 'Withis', last_name: 'Words')

      spatula = Item.create!(name: 'Spatula', description: 'It is for cooking', unit_price: 3, merchant_id: merchant_1.id)
      spoon = Item.create!(name: 'Spoon', description: 'It is for eating ice cream', unit_price: 1, merchant_id: merchant_1.id)
      knife = Item.create!(name: 'Knife', description: 'It is for slicing bread', unit_price: 5, merchant_id: merchant_1.id)
      computer = Item.create!(name: 'Computer', description: 'It is for playing games', unit_price: 50, merchant_id: merchant_1.id)
      table = Item.create!(name: 'Table', description: 'It is for eating at', unit_price: 70, merchant_id: merchant_1.id)
      bag_of_money = Item.create!(name: 'Bag of Money', description: 'It is for whatever you want', unit_price: 999, merchant_id: merchant_1.id)
      wooden_number_seven = Item.create!(name: 'Decorative Wood 7', description: 'It is a piece of wood shaped like a 7', unit_price: 400, merchant_id: merchant_1.id)
      jacks = Item.create!(name: 'Bag of Jacks', description: 'It is for playing Jacks', unit_price: 3, merchant_id: merchant_2.id)

      invoice_1 = Invoice.create!(customer_id: customer_1.id, status: 2)
      invoice_2 = Invoice.create!(customer_id: customer_1.id, status: 2)
      invoice_3 = Invoice.create!(customer_id: customer_1.id, status: 2)
      invoice_4 = Invoice.create!(customer_id: customer_1.id, status: 2)
      invoice_5 = Invoice.create!(customer_id: customer_1.id, status: 2)
      invoice_6 = Invoice.create!(customer_id: customer_1.id, status: 2)
      invoice_7 = Invoice.create!(customer_id: customer_1.id, status: 2)
      invoice_8 = Invoice.create!(customer_id: customer_1.id, status: 1)

      transaction_1 = Transaction.create!(invoice_id: invoice_1.id, credit_card_number: '983475', credit_card_expiration_date: nil, result: 'success')
      transaction_2 = Transaction.create!(invoice_id: invoice_2.id, credit_card_number: '345', credit_card_expiration_date: nil, result: 'success')
      transaction_3 = Transaction.create!(invoice_id: invoice_3.id, credit_card_number: '34657865', credit_card_expiration_date: nil, result: 'success')
      transaction_4 = Transaction.create!(invoice_id: invoice_4.id, credit_card_number: '3456546', credit_card_expiration_date: nil, result: 'success')
      transaction_5 = Transaction.create!(invoice_id: invoice_5.id, credit_card_number: '234234', credit_card_expiration_date: nil, result: 'success')
      transaction_6 = Transaction.create!(invoice_id: invoice_6.id, credit_card_number: '6578', credit_card_expiration_date: nil, result: 'success')
      transaction_7 = Transaction.create!(invoice_id: invoice_7.id, credit_card_number: '9789', credit_card_expiration_date: nil, result: 'success')
      transaction_8 = Transaction.create!(invoice_id: invoice_8.id, credit_card_number: '3456', credit_card_expiration_date: nil, result: 'failed')

      invoice_item_1 = InvoiceItem.create!(item_id: spatula.id, invoice_id: invoice_1.id, quantity: 5, unit_price: 2, status: 2)
      invoice_item_2 = InvoiceItem.create!(item_id: spoon.id, invoice_id: invoice_1.id, quantity: 3, unit_price: 3, status: 2)
      invoice_item_3 = InvoiceItem.create!(item_id: knife.id, invoice_id: invoice_2.id, quantity: 2, unit_price: 1, status: 2)
      invoice_item_4 = InvoiceItem.create!(item_id: computer.id, invoice_id: invoice_2.id, quantity: 4, unit_price: 2, status: 2)
      invoice_item_5 = InvoiceItem.create!(item_id: table.id, invoice_id: invoice_3.id, quantity: 3, unit_price: 3, status: 2)
      invoice_item_7 = InvoiceItem.create!(item_id: bag_of_money.id, invoice_id: invoice_3.id, quantity: 4, unit_price: 1, status: 2)
      invoice_item_8 = InvoiceItem.create!(item_id: wooden_number_seven.id, invoice_id: invoice_4.id, quantity: 4, unit_price: 1, status: 2)
      invoice_item_9 = InvoiceItem.create!(item_id: knife.id, invoice_id: invoice_4.id, quantity: 4, unit_price: 1, status: 2)
      invoice_item_10 = InvoiceItem.create!(item_id: spatula.id, invoice_id: invoice_5.id, quantity: 3, unit_price: 4, status: 2)
      invoice_item_11 = InvoiceItem.create!(item_id: table.id, invoice_id: invoice_6.id, quantity: 4, unit_price: 1, status: 2)
      invoice_item_12 = InvoiceItem.create!(item_id: table.id, invoice_id: invoice_7.id, quantity: 2, unit_price: 3, status: 2)
      invoice_item_13 = InvoiceItem.create!(item_id: jacks.id, invoice_id: invoice_8.id, quantity: 4, unit_price: 1, status: 2)

      visit "/merchants/#{merchant_1.id}/items"

      within "#top-five-items" do
        # expect('Spatula').to appear_before('Table')
        # expect('Table').to appear_before('Spoon')
        # expect('Spoon').to appear_before('Computer')
        # expect('Computer').to appear_before('Knife')
        expect(page).to have_content('Knife')
        expect(page).to_not have_content('Bag of Money')
      end
    end

    it 'the top 5 items has a link to each items merchant item show page' do
      merchant_1 = Merchant.create!(name: 'Spongebob The Merchant')
      merchant_2 = Merchant.create!(name: 'Sandy The Squirrel Merchant')

      customer_1 = Customer.create!(first_name: 'Somany', last_name: 'Damntests')
      customer_2 = Customer.create!(first_name: 'Keeling', last_name: 'Mesoftly')
      customer_3 = Customer.create!(first_name: 'Withis', last_name: 'Words')

      spatula = Item.create!(name: 'Spatula', description: 'It is for cooking', unit_price: 3, merchant_id: merchant_1.id)
      spoon = Item.create!(name: 'Spoon', description: 'It is for eating ice cream', unit_price: 1, merchant_id: merchant_1.id)
      knife = Item.create!(name: 'Knife', description: 'It is for slicing bread', unit_price: 5, merchant_id: merchant_1.id)
      computer = Item.create!(name: 'Computer', description: 'It is for playing games', unit_price: 50, merchant_id: merchant_1.id)
      table = Item.create!(name: 'Table', description: 'It is for eating at', unit_price: 70, merchant_id: merchant_1.id)
      bag_of_money = Item.create!(name: 'Bag of Money', description: 'It is for whatever you want', unit_price: 999, merchant_id: merchant_1.id)
      wooden_number_seven = Item.create!(name: 'Decorative Wood 7', description: 'It is a piece of wood shaped like a 7', unit_price: 400, merchant_id: merchant_1.id)
      jacks = Item.create!(name: 'Bag of Jacks', description: 'It is for playing Jacks', unit_price: 3, merchant_id: merchant_2.id)

      invoice_1 = Invoice.create!(customer_id: customer_1.id, status: 2)
      invoice_2 = Invoice.create!(customer_id: customer_1.id, status: 2)
      invoice_3 = Invoice.create!(customer_id: customer_1.id, status: 2)
      invoice_4 = Invoice.create!(customer_id: customer_1.id, status: 2)
      invoice_5 = Invoice.create!(customer_id: customer_1.id, status: 2)
      invoice_6 = Invoice.create!(customer_id: customer_1.id, status: 2)
      invoice_7 = Invoice.create!(customer_id: customer_1.id, status: 2)
      invoice_8 = Invoice.create!(customer_id: customer_1.id, status: 1)

      transaction_1 = Transaction.create!(invoice_id: invoice_1.id, credit_card_number: '983475', credit_card_expiration_date: nil, result: 'success')
      transaction_2 = Transaction.create!(invoice_id: invoice_2.id, credit_card_number: '345', credit_card_expiration_date: nil, result: 'success')
      transaction_3 = Transaction.create!(invoice_id: invoice_3.id, credit_card_number: '34657865', credit_card_expiration_date: nil, result: 'success')
      transaction_4 = Transaction.create!(invoice_id: invoice_4.id, credit_card_number: '3456546', credit_card_expiration_date: nil, result: 'success')
      transaction_5 = Transaction.create!(invoice_id: invoice_5.id, credit_card_number: '234234', credit_card_expiration_date: nil, result: 'success')
      transaction_6 = Transaction.create!(invoice_id: invoice_6.id, credit_card_number: '6578', credit_card_expiration_date: nil, result: 'success')
      transaction_7 = Transaction.create!(invoice_id: invoice_7.id, credit_card_number: '9789', credit_card_expiration_date: nil, result: 'success')
      transaction_8 = Transaction.create!(invoice_id: invoice_8.id, credit_card_number: '3456', credit_card_expiration_date: nil, result: 'failed')

      invoice_item_1 = InvoiceItem.create!(item_id: spatula.id, invoice_id: invoice_1.id, quantity: 5, unit_price: 2, status: 2)
      invoice_item_2 = InvoiceItem.create!(item_id: spoon.id, invoice_id: invoice_1.id, quantity: 3, unit_price: 3, status: 2)
      invoice_item_3 = InvoiceItem.create!(item_id: knife.id, invoice_id: invoice_2.id, quantity: 2, unit_price: 1, status: 2)
      invoice_item_4 = InvoiceItem.create!(item_id: computer.id, invoice_id: invoice_2.id, quantity: 4, unit_price: 2, status: 2)
      invoice_item_5 = InvoiceItem.create!(item_id: table.id, invoice_id: invoice_3.id, quantity: 3, unit_price: 3, status: 2)
      invoice_item_7 = InvoiceItem.create!(item_id: bag_of_money.id, invoice_id: invoice_3.id, quantity: 4, unit_price: 1, status: 2)
      invoice_item_8 = InvoiceItem.create!(item_id: wooden_number_seven.id, invoice_id: invoice_4.id, quantity: 4, unit_price: 1, status: 2)
      invoice_item_9 = InvoiceItem.create!(item_id: knife.id, invoice_id: invoice_4.id, quantity: 4, unit_price: 1, status: 2)
      invoice_item_10 = InvoiceItem.create!(item_id: spatula.id, invoice_id: invoice_5.id, quantity: 3, unit_price: 4, status: 2)
      invoice_item_11 = InvoiceItem.create!(item_id: table.id, invoice_id: invoice_6.id, quantity: 4, unit_price: 1, status: 2)
      invoice_item_12 = InvoiceItem.create!(item_id: table.id, invoice_id: invoice_7.id, quantity: 2, unit_price: 3, status: 2)
      invoice_item_13 = InvoiceItem.create!(item_id: jacks.id, invoice_id: invoice_8.id, quantity: 4, unit_price: 1, status: 2)

      visit "/merchants/#{merchant_1.id}/items"

      within "#top-five-items" do
        expect(page).to have_link('Spatula')
        expect(page).to have_link('Table')
        expect(page).to have_link('Spoon')
        expect(page).to have_link('Computer')
        expect(page).to have_link('Knife')
      end
    end

    it 'the top 5 items link will take you to its show page for that merchant' do
      merchant_1 = Merchant.create!(name: 'Spongebob The Merchant')
      merchant_2 = Merchant.create!(name: 'Sandy The Squirrel Merchant')

      customer_1 = Customer.create!(first_name: 'Somany', last_name: 'Damntests')
      customer_2 = Customer.create!(first_name: 'Keeling', last_name: 'Mesoftly')
      customer_3 = Customer.create!(first_name: 'Withis', last_name: 'Words')

      spatula = Item.create!(name: 'Spatula', description: 'It is for cooking', unit_price: 3, merchant_id: merchant_1.id)
      spoon = Item.create!(name: 'Spoon', description: 'It is for eating ice cream', unit_price: 1, merchant_id: merchant_1.id)
      knife = Item.create!(name: 'Knife', description: 'It is for slicing bread', unit_price: 5, merchant_id: merchant_1.id)
      computer = Item.create!(name: 'Computer', description: 'It is for playing games', unit_price: 50, merchant_id: merchant_1.id)
      table = Item.create!(name: 'Table', description: 'It is for eating at', unit_price: 70, merchant_id: merchant_1.id)
      bag_of_money = Item.create!(name: 'Bag of Money', description: 'It is for whatever you want', unit_price: 999, merchant_id: merchant_1.id)
      wooden_number_seven = Item.create!(name: 'Decorative Wood 7', description: 'It is a piece of wood shaped like a 7', unit_price: 400, merchant_id: merchant_1.id)
      jacks = Item.create!(name: 'Bag of Jacks', description: 'It is for playing Jacks', unit_price: 3, merchant_id: merchant_2.id)

      invoice_1 = Invoice.create!(customer_id: customer_1.id, status: 2)
      invoice_2 = Invoice.create!(customer_id: customer_1.id, status: 2)
      invoice_3 = Invoice.create!(customer_id: customer_1.id, status: 2)
      invoice_4 = Invoice.create!(customer_id: customer_1.id, status: 2)
      invoice_5 = Invoice.create!(customer_id: customer_1.id, status: 2)
      invoice_6 = Invoice.create!(customer_id: customer_1.id, status: 2)
      invoice_7 = Invoice.create!(customer_id: customer_1.id, status: 2)
      invoice_8 = Invoice.create!(customer_id: customer_1.id, status: 1)

      transaction_1 = Transaction.create!(invoice_id: invoice_1.id, credit_card_number: '983475', credit_card_expiration_date: nil, result: 'success')
      transaction_2 = Transaction.create!(invoice_id: invoice_2.id, credit_card_number: '345', credit_card_expiration_date: nil, result: 'success')
      transaction_3 = Transaction.create!(invoice_id: invoice_3.id, credit_card_number: '34657865', credit_card_expiration_date: nil, result: 'success')
      transaction_4 = Transaction.create!(invoice_id: invoice_4.id, credit_card_number: '3456546', credit_card_expiration_date: nil, result: 'success')
      transaction_5 = Transaction.create!(invoice_id: invoice_5.id, credit_card_number: '234234', credit_card_expiration_date: nil, result: 'success')
      transaction_6 = Transaction.create!(invoice_id: invoice_6.id, credit_card_number: '6578', credit_card_expiration_date: nil, result: 'success')
      transaction_7 = Transaction.create!(invoice_id: invoice_7.id, credit_card_number: '9789', credit_card_expiration_date: nil, result: 'success')
      transaction_8 = Transaction.create!(invoice_id: invoice_8.id, credit_card_number: '3456', credit_card_expiration_date: nil, result: 'failed')

      invoice_item_1 = InvoiceItem.create!(item_id: spatula.id, invoice_id: invoice_1.id, quantity: 5, unit_price: 2, status: 2)
      invoice_item_2 = InvoiceItem.create!(item_id: spoon.id, invoice_id: invoice_1.id, quantity: 3, unit_price: 3, status: 2)
      invoice_item_3 = InvoiceItem.create!(item_id: knife.id, invoice_id: invoice_2.id, quantity: 2, unit_price: 1, status: 2)
      invoice_item_4 = InvoiceItem.create!(item_id: computer.id, invoice_id: invoice_2.id, quantity: 4, unit_price: 2, status: 2)
      invoice_item_5 = InvoiceItem.create!(item_id: table.id, invoice_id: invoice_3.id, quantity: 3, unit_price: 3, status: 2)
      invoice_item_7 = InvoiceItem.create!(item_id: bag_of_money.id, invoice_id: invoice_3.id, quantity: 4, unit_price: 1, status: 2)
      invoice_item_8 = InvoiceItem.create!(item_id: wooden_number_seven.id, invoice_id: invoice_4.id, quantity: 4, unit_price: 1, status: 2)
      invoice_item_9 = InvoiceItem.create!(item_id: knife.id, invoice_id: invoice_4.id, quantity: 4, unit_price: 1, status: 2)
      invoice_item_10 = InvoiceItem.create!(item_id: spatula.id, invoice_id: invoice_5.id, quantity: 3, unit_price: 4, status: 2)
      invoice_item_11 = InvoiceItem.create!(item_id: table.id, invoice_id: invoice_6.id, quantity: 4, unit_price: 1, status: 2)
      invoice_item_12 = InvoiceItem.create!(item_id: table.id, invoice_id: invoice_7.id, quantity: 2, unit_price: 3, status: 2)
      invoice_item_13 = InvoiceItem.create!(item_id: jacks.id, invoice_id: invoice_8.id, quantity: 4, unit_price: 1, status: 2)

      visit "/merchants/#{merchant_1.id}/items"

      within "#top-five-items" do
        click_on 'Spatula'

        expect(current_path).to eq("/merchants/#{merchant_1.id}/items/#{spatula.id}")
      end
    end

    it 'shows the revenue for each of the top 5 items' do
      merchant_1 = Merchant.create!(name: 'Spongebob The Merchant')
      merchant_2 = Merchant.create!(name: 'Sandy The Squirrel Merchant')

      customer_1 = Customer.create!(first_name: 'Somany', last_name: 'Damntests')
      customer_2 = Customer.create!(first_name: 'Keeling', last_name: 'Mesoftly')
      customer_3 = Customer.create!(first_name: 'Withis', last_name: 'Words')

      spatula = Item.create!(name: 'Spatula', description: 'It is for cooking', unit_price: 3, merchant_id: merchant_1.id)
      spoon = Item.create!(name: 'Spoon', description: 'It is for eating ice cream', unit_price: 1, merchant_id: merchant_1.id)
      knife = Item.create!(name: 'Knife', description: 'It is for slicing bread', unit_price: 5, merchant_id: merchant_1.id)
      computer = Item.create!(name: 'Computer', description: 'It is for playing games', unit_price: 50, merchant_id: merchant_1.id)
      table = Item.create!(name: 'Table', description: 'It is for eating at', unit_price: 70, merchant_id: merchant_1.id)
      bag_of_money = Item.create!(name: 'Bag of Money', description: 'It is for whatever you want', unit_price: 999, merchant_id: merchant_1.id)
      wooden_number_seven = Item.create!(name: 'Decorative Wood 7', description: 'It is a piece of wood shaped like a 7', unit_price: 400, merchant_id: merchant_1.id)
      jacks = Item.create!(name: 'Bag of Jacks', description: 'It is for playing Jacks', unit_price: 3, merchant_id: merchant_2.id)

      invoice_1 = Invoice.create!(customer_id: customer_1.id, status: 2)
      invoice_2 = Invoice.create!(customer_id: customer_1.id, status: 2)
      invoice_3 = Invoice.create!(customer_id: customer_1.id, status: 2)
      invoice_4 = Invoice.create!(customer_id: customer_1.id, status: 2)
      invoice_5 = Invoice.create!(customer_id: customer_1.id, status: 2)
      invoice_6 = Invoice.create!(customer_id: customer_1.id, status: 2)
      invoice_7 = Invoice.create!(customer_id: customer_1.id, status: 2)
      invoice_8 = Invoice.create!(customer_id: customer_1.id, status: 1)

      transaction_1 = Transaction.create!(invoice_id: invoice_1.id, credit_card_number: '983475', credit_card_expiration_date: nil, result: 'success')
      transaction_2 = Transaction.create!(invoice_id: invoice_2.id, credit_card_number: '345', credit_card_expiration_date: nil, result: 'success')
      transaction_3 = Transaction.create!(invoice_id: invoice_3.id, credit_card_number: '34657865', credit_card_expiration_date: nil, result: 'success')
      transaction_4 = Transaction.create!(invoice_id: invoice_4.id, credit_card_number: '3456546', credit_card_expiration_date: nil, result: 'success')
      transaction_5 = Transaction.create!(invoice_id: invoice_5.id, credit_card_number: '234234', credit_card_expiration_date: nil, result: 'success')
      transaction_6 = Transaction.create!(invoice_id: invoice_6.id, credit_card_number: '6578', credit_card_expiration_date: nil, result: 'success')
      transaction_7 = Transaction.create!(invoice_id: invoice_7.id, credit_card_number: '9789', credit_card_expiration_date: nil, result: 'success')
      transaction_8 = Transaction.create!(invoice_id: invoice_8.id, credit_card_number: '3456', credit_card_expiration_date: nil, result: 'failed')

      invoice_item_1 = InvoiceItem.create!(item_id: spatula.id, invoice_id: invoice_1.id, quantity: 5, unit_price: 2, status: 2)
      invoice_item_2 = InvoiceItem.create!(item_id: spoon.id, invoice_id: invoice_1.id, quantity: 3, unit_price: 3, status: 2)
      invoice_item_3 = InvoiceItem.create!(item_id: knife.id, invoice_id: invoice_2.id, quantity: 2, unit_price: 1, status: 2)
      invoice_item_4 = InvoiceItem.create!(item_id: computer.id, invoice_id: invoice_2.id, quantity: 4, unit_price: 2, status: 2)
      invoice_item_5 = InvoiceItem.create!(item_id: table.id, invoice_id: invoice_3.id, quantity: 3, unit_price: 3, status: 2)
      invoice_item_7 = InvoiceItem.create!(item_id: bag_of_money.id, invoice_id: invoice_3.id, quantity: 4, unit_price: 1, status: 2)
      invoice_item_8 = InvoiceItem.create!(item_id: wooden_number_seven.id, invoice_id: invoice_4.id, quantity: 4, unit_price: 1, status: 2)
      invoice_item_9 = InvoiceItem.create!(item_id: knife.id, invoice_id: invoice_4.id, quantity: 4, unit_price: 1, status: 2)
      invoice_item_10 = InvoiceItem.create!(item_id: spatula.id, invoice_id: invoice_5.id, quantity: 3, unit_price: 4, status: 2)
      invoice_item_11 = InvoiceItem.create!(item_id: table.id, invoice_id: invoice_6.id, quantity: 4, unit_price: 1, status: 2)
      invoice_item_12 = InvoiceItem.create!(item_id: table.id, invoice_id: invoice_7.id, quantity: 2, unit_price: 3, status: 2)
      invoice_item_13 = InvoiceItem.create!(item_id: jacks.id, invoice_id: invoice_8.id, quantity: 4, unit_price: 1, status: 2)

      visit "/merchants/#{merchant_1.id}/items"

      within "#top-five-items" do
        expect(page).to have_content('$0.22')
        expect(page).to have_content('$0.19')
        expect(page).to have_content('$0.09')
        expect(page).to have_content('$0.08')
        expect(page).to have_content('$0.06')
      end
    end

    it 'shows the top selling date for each item' do
      merchant_1 = Merchant.create!(name: 'Spongebob The Merchant')
      merchant_2 = Merchant.create!(name: 'Sandy The Squirrel Merchant')

      customer_1 = Customer.create!(first_name: 'Somany', last_name: 'Damntests')
      customer_2 = Customer.create!(first_name: 'Keeling', last_name: 'Mesoftly')
      customer_3 = Customer.create!(first_name: 'Withis', last_name: 'Words')

      spatula = Item.create!(name: 'Spatula', description: 'It is for cooking', unit_price: 3, merchant_id: merchant_1.id)
      spoon = Item.create!(name: 'Spoon', description: 'It is for eating ice cream', unit_price: 1, merchant_id: merchant_1.id)
      knife = Item.create!(name: 'Knife', description: 'It is for slicing bread', unit_price: 5, merchant_id: merchant_1.id)
      computer = Item.create!(name: 'Computer', description: 'It is for playing games', unit_price: 50, merchant_id: merchant_1.id)
      table = Item.create!(name: 'Table', description: 'It is for eating at', unit_price: 70, merchant_id: merchant_1.id)
      bag_of_money = Item.create!(name: 'Bag of Money', description: 'It is for whatever you want', unit_price: 999, merchant_id: merchant_1.id)
      wooden_number_seven = Item.create!(name: 'Decorative Wood 7', description: 'It is a piece of wood shaped like a 7', unit_price: 400, merchant_id: merchant_1.id)
      jacks = Item.create!(name: 'Bag of Jacks', description: 'It is for playing Jacks', unit_price: 3, merchant_id: merchant_2.id)

      invoice_1 = Invoice.create!(customer_id: customer_1.id, status: 2)
      invoice_2 = Invoice.create!(customer_id: customer_1.id, status: 2)
      invoice_3 = Invoice.create!(customer_id: customer_1.id, status: 2)
      invoice_4 = Invoice.create!(customer_id: customer_1.id, status: 2)
      invoice_5 = Invoice.create!(customer_id: customer_1.id, status: 2)
      invoice_6 = Invoice.create!(customer_id: customer_1.id, status: 2)
      invoice_7 = Invoice.create!(customer_id: customer_1.id, status: 2)
      invoice_8 = Invoice.create!(customer_id: customer_1.id, status: 1)

      transaction_1 = Transaction.create!(invoice_id: invoice_1.id, credit_card_number: '983475', credit_card_expiration_date: nil, result: 'success')
      transaction_2 = Transaction.create!(invoice_id: invoice_2.id, credit_card_number: '345', credit_card_expiration_date: nil, result: 'success')
      transaction_3 = Transaction.create!(invoice_id: invoice_3.id, credit_card_number: '34657865', credit_card_expiration_date: nil, result: 'success')
      transaction_4 = Transaction.create!(invoice_id: invoice_4.id, credit_card_number: '3456546', credit_card_expiration_date: nil, result: 'success')
      transaction_5 = Transaction.create!(invoice_id: invoice_5.id, credit_card_number: '234234', credit_card_expiration_date: nil, result: 'success')
      transaction_6 = Transaction.create!(invoice_id: invoice_6.id, credit_card_number: '6578', credit_card_expiration_date: nil, result: 'success')
      transaction_7 = Transaction.create!(invoice_id: invoice_7.id, credit_card_number: '9789', credit_card_expiration_date: nil, result: 'success')
      transaction_8 = Transaction.create!(invoice_id: invoice_8.id, credit_card_number: '3456', credit_card_expiration_date: nil, result: 'failed')

      invoice_item_1 = InvoiceItem.create!(item_id: spatula.id, invoice_id: invoice_1.id, quantity: 5, unit_price: 2, status: 2)
      invoice_item_2 = InvoiceItem.create!(item_id: spoon.id, invoice_id: invoice_1.id, quantity: 3, unit_price: 3, status: 2)
      invoice_item_3 = InvoiceItem.create!(item_id: knife.id, invoice_id: invoice_2.id, quantity: 2, unit_price: 1, status: 2)
      invoice_item_4 = InvoiceItem.create!(item_id: computer.id, invoice_id: invoice_2.id, quantity: 4, unit_price: 2, status: 2)
      invoice_item_5 = InvoiceItem.create!(item_id: table.id, invoice_id: invoice_3.id, quantity: 3, unit_price: 3, status: 2)
      invoice_item_7 = InvoiceItem.create!(item_id: bag_of_money.id, invoice_id: invoice_3.id, quantity: 4, unit_price: 1, status: 2)
      invoice_item_8 = InvoiceItem.create!(item_id: wooden_number_seven.id, invoice_id: invoice_4.id, quantity: 4, unit_price: 1, status: 2)
      invoice_item_9 = InvoiceItem.create!(item_id: knife.id, invoice_id: invoice_4.id, quantity: 4, unit_price: 1, status: 2)
      invoice_item_10 = InvoiceItem.create!(item_id: spatula.id, invoice_id: invoice_5.id, quantity: 3, unit_price: 4, status: 2)
      invoice_item_11 = InvoiceItem.create!(item_id: table.id, invoice_id: invoice_6.id, quantity: 4, unit_price: 1, status: 2)
      invoice_item_12 = InvoiceItem.create!(item_id: table.id, invoice_id: invoice_7.id, quantity: 2, unit_price: 3, status: 2)
      invoice_item_13 = InvoiceItem.create!(item_id: jacks.id, invoice_id: invoice_8.id, quantity: 4, unit_price: 1, status: 2)

      visit "/merchants/#{merchant_1.id}/items"

      within "#top-five-items" do
        expect(page).to have_content("Top selling date for Spatula was #{spatula.top_day.strftime("%-m/%d/%y")}")
      end
    end
  end

  describe 'group by status' do
    context ' enable / disable' do
      it 'groups by Enabled Items / Disabled Items' do
        bob = Merchant.create!(name: "Bob The Burgerman")

        item_1 = bob.items.create!(name: "Burgers", description: "Best Burgers in Town!", unit_price: 599)
        item_2 = bob.items.create!(name: "Fries", description: "Gene stop eating the fries, they`re for customers", unit_price: 250)
        item_3 = bob.items.create!(name: 'Spatula', description: 'It is for cooking', unit_price: 3)
        item_4 = bob.items.create!(name: 'Spoon', description: 'It is for eating ice cream', unit_price: 1)

        visit "/merchants/#{bob.id}/items"

        click_on "Enable Burgers"
        click_on "Enable Fries"

        click_on "Disable Spatula"
        click_on "Disable Spoon"

        within "#enabled_items" do
          expect(page).to have_content("Burgers")
          expect(page).to have_content("Fries")
          expect(page).to_not have_content("Spatula")
          expect(page).to_not have_content("Spoon")
        end

        within "#disabled_items" do
          expect(page).to have_content("Spatula")
          expect(page).to have_content("Spoon")
          expect(page).to_not have_content("Burgers")
          expect(page).to_not have_content("Fries")
        end
      end
    end
  end
end
