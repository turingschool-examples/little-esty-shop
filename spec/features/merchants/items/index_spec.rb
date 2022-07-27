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

      click_on('Spatula')

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


#     Merchant Items Index: 5 most popular items

      # As a merchant
      # When I visit my items index page
      # Then I see the names of the top 5 most popular items ranked by total revenue generated
      # And I see that each item name links to my merchant item show page for that item
      # And I see the total revenue generated next to each item name

      # Notes on Revenue Calculation:
      # - Only invoices with at least one successful transaction should count towards revenue
      # - Revenue for an invoice should be calculated as the sum of the revenue of all invoice items
      # - Revenue for an invoice item should be calculated as the invoice item unit price multiplied by the quantity (do not use the item unit price)

    it 'shows the 5 most popular items' do 
      merchant_1 = Merchant.create!(name: 'Spongebob The Merchant')

      customer_1 = Customer.create!(first_name: 'Somany', last_name: 'Damntests')

      spatula = Item.create!(name: 'Spatula', description: 'It is for cooking', unit_price: 3, merchant_id: merchant_1.id)
      spoon = Item.create!(name: 'Spoon', description: 'It is for eating ice cream', unit_price: 1, merchant_id: merchant_1.id)
      knife = Item.create!(name: 'Knife', description: 'It is for slicing bread', unit_price: 5, merchant_id: merchant_1.id)
      computer = Item.create!(name: 'Computer', description: 'It is for playing games', unit_price: 50, merchant_id: merchant_1.id)
      table = Item.create!(name: 'Table', description: 'It is for eating at', unit_price: 70, merchant_id: merchant_1.id)
      bag_of_money = Item.create!(name: 'Bag of Money', description: 'It is for whatever you want', unit_price: 999, merchant_id: merchant_1.id)

      invoice_1 = Invoice.create!(customer_id: customer_1.id, status: 2)

      transaction_1 = Transaction.create!(invoice_id: invoice_1.id, credit_card_number: '983475', credit_card_expiration_date: nil, result: 0)
      transaction_1 = Transaction.create!(invoice_id: invoice_1.id, credit_card_number: '345', credit_card_expiration_date: nil, result: 1)
      transaction_1 = Transaction.create!(invoice_id: invoice_1.id, credit_card_number: '34657865', credit_card_expiration_date: nil, result: 0)
      transaction_1 = Transaction.create!(invoice_id: invoice_1.id, credit_card_number: '78965367', credit_card_expiration_date: nil, result: 0)

      InvoiceItem.create!(item_id: spatula.id, invoice_id: invoice_1.id, quantity: 5, unit_price: 23, status: 2)
      InvoiceItem.create!(item_id: spoon.id, invoice_id: invoice_1.id, quantity: 3, unit_price: 2345, status: 2)
      InvoiceItem.create!(item_id: knife.id, invoice_id: invoice_1.id, quantity: 2, unit_price: 654, status: 2)
      InvoiceItem.create!(item_id: computer.id, invoice_id: invoice_1.id, quantity: 4, unit_price: 876, status: 2)
      InvoiceItem.create!(item_id: table.id, invoice_id: invoice_1.id, quantity: 3, unit_price: 543, status: 2)
      InvoiceItem.create!(item_id: bag_of_money.id, invoice_id: invoice_1.id, quantity: 4, unit_price: 352, status: 2)

      visit "/merchants/#{merchant_1.id}/items"

      within "#top-five-items" do 
        expect('Bag of Money').to appear_before('Table')
        expect('Table').to appear_before('Computer')
        expect('Computer').to appear_before('Knife')
        expect('Knife').to appear_before('Spatula')
        expect(page).to have_content('Spatula')
        expect(page).to_not have_content('Spoon')
      end
    end
  end
end