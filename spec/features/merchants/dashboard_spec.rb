require 'rails_helper'

RSpec.describe 'Dashboard Page' do
  before :each do
    @merch1 = Merchant.create!(name: 'Jolly Roger Imports')
    @merch2 = Merchant.create!(name: 'Molly Fine Arts')
    @merch3 = Merchant.create!(name: 'Treats and Things')
  end

  it 'shows the merchants name' do
    visit "/merchants/#{@merch1.id}/dashboard"

    within('#merchant-details') do
      expect(page).to have_content('Jolly Roger Imports')
      expect(page).to_not have_content('Molly Fine Arts')
    end

    visit "/merchants/#{@merch2.id}/dashboard"

    within('#merchant-details') do
      expect(page).to have_content('Molly Fine Arts')
      expect(page).to_not have_content('Treats and Things')
    end
  end
  it 'has a link to the merchants items page' do
    visit "/merchants/#{@merch1.id}/dashboard"

    within('#merchant-links') do
      expect(page).to have_link('My Items')
      click_on('My Items')
      expect(current_path).to eq("/merchants/#{@merch1.id}/items")
    end
  end
  
  it 'has a link to the merchants invoices page' do
    visit "/merchants/#{@merch1.id}/dashboard"

    within('#merchant-links') do
      expect(page).to have_link('My Invoices')
      click_on('My Invoices')
      expect(current_path).to eq("/merchants/#{@merch1.id}/invoices")
    end
    
  end

  describe 'Items Ready to Ship' do
    it 'lists items that are ready to ship ordered oldest to newest' do
      customer1 = Customer.create!(first_name: 'Theophania', last_name: 'Fenwick')
      customer2 = Customer.create!(first_name: 'Vera', last_name: 'Wynn')

      item1 = @merch2.items.create!(name: 'Copper Bracelet', description: 'Shiny, but not too shiny', unit_price: 20)
      item2 = @merch2.items.create!(name: 'Copper Ring', description: 'Shiny, but not too shiny', unit_price: 10)
      item3 = @merch2.items.create!(name: 'Lemongrass Extract', description: 'Smells citrus', unit_price: 6)

      invoice1 = customer1.invoices.create!(status: 1)
      invoice2 = customer2.invoices.create!(status: 1)

      invoice_item1 = InvoiceItem.create!(invoice: invoice1, item: item3, quantity: 1, unit_price: 6, status: 1)
      invoice_item2 = InvoiceItem.create!(invoice: invoice2, item: item1, quantity: 1, unit_price: 20, status: 1)
      invoice_item3 = InvoiceItem.create!(invoice: invoice2, item: item2, quantity: 1, unit_price: 10, status: 2)
      invoice_item4 = InvoiceItem.create!(invoice: invoice1, item: item1, quantity: 1, unit_price: 10, status: 1)

      visit "/merchants/#{@merch2.id}/dashboard"

      within '#items-ready-to-ship' do
        expect(page).to have_content('Copper Bracelet')
        expect(page).to have_content('Lemongrass Extract')
        expect(page).to_not have_content('Copper Ring')
        expect(invoice_item1.id.to_s).to appear_before(invoice_item4.id.to_s)
        expect(invoice_item4.id.to_s).to appear_before(invoice_item2.id.to_s)
      end
    end

    it 'lists the date the invoice was created next to the item name' do
      customer1 = Customer.create!(first_name: 'Theophania', last_name: 'Fenwick')
      customer2 = Customer.create!(first_name: 'Vera', last_name: 'Wynn')

      item1 = @merch2.items.create!(name: 'Copper Bracelet', description: 'Shiny, but not too shiny', unit_price: 20)
      item2 = @merch2.items.create!(name: 'Copper Ring', description: 'Shiny, but not too shiny', unit_price: 10)
      item3 = @merch2.items.create!(name: 'Lemongrass Extract', description: 'Smells citrus', unit_price: 6)

      invoice1 = customer1.invoices.create!(status: 1)
      invoice2 = customer2.invoices.create!(status: 1)

      invoice_item1 = InvoiceItem.create!(invoice: invoice1, item: item3, quantity: 1, unit_price: 6, status: 1)
      invoice_item2 = InvoiceItem.create!(invoice: invoice2, item: item1, quantity: 1, unit_price: 20, status: 1)
      invoice_item3 = InvoiceItem.create!(invoice: invoice2, item: item2, quantity: 1, unit_price: 10, status: 2)
      invoice_item4 = InvoiceItem.create!(invoice: invoice1, item: item2, quantity: 1, unit_price: 10, status: 2)

      visit "/merchants/#{@merch2.id}/dashboard"

      within "#invoice-item-#{invoice_item1.id}" do
        expect(page).to have_content(invoice_item1.invoice.formatted_date)
      end

      within "#invoice-item-#{invoice_item2.id}" do
        expect(page).to have_content(invoice_item2.invoice.formatted_date)
      end
    end
  end

  it 'displays top 5 customers and number of successful transactions for each' do
    pokemart = Merchant.create!(name: 'PokeMart')
    potion = pokemart.items.create!(name: 'Potion', description: 'Recovers 10 HP', unit_price: 2)
    super_potion = pokemart.items.create!(name: 'Super Potion', description: 'Recovers 25 HP', unit_price: 5)
    ultra_ball = pokemart.items.create!(name: 'Ultra Ball', description: 'High chance of catching a Pokemon', unit_price: 8)

    trainer_red = Customer.create!(first_name: 'Red', last_name: 'Trainer')
    invoice1 = trainer_red.invoices.create!(status: 2)
    invoice_item1 = InvoiceItem.create!(invoice: invoice1, item: ultra_ball, quantity: 6, unit_price: 8, status: 0)
    invoice1.transactions.create!(credit_card_number: 3395123433951234, result: 1)
    invoice1.transactions.create!(credit_card_number: 3395123433951234, result: 1)
    invoice1.transactions.create!(credit_card_number: 3395123433951234, result: 1)
    invoice1.transactions.create!(credit_card_number: 3395123433951234, result: 1)
    invoice1.transactions.create!(credit_card_number: 3395123433951234, result: 1)
    invoice1.transactions.create!(credit_card_number: 3395123433951234, result: 1)

    trainer_blue = Customer.create!(first_name: 'Blue', last_name: 'Trainer')
    invoice2 = trainer_blue.invoices.create!(status: 2)
    invoice_item2 = InvoiceItem.create!(invoice: invoice2, item: potion, quantity: 5, unit_price: 2, status: 0)
    invoice2.transactions.create!(credit_card_number: 6695123466951234, result: 1)
    invoice2.transactions.create!(credit_card_number: 6695123466951234, result: 1)
    invoice2.transactions.create!(credit_card_number: 6695123466951234, result: 1)
    invoice2.transactions.create!(credit_card_number: 6695123466951234, result: 1)
    invoice2.transactions.create!(credit_card_number: 6695123466951234, result: 1)

    misty = Customer.create!(first_name: 'Misty', last_name: 'Trainer')
    invoice3 = misty.invoices.create!(status: 2)
    invoice_item3 = InvoiceItem.create!(invoice: invoice3, item: ultra_ball, quantity: 2, unit_price: 8, status: 0)
    invoice3.transactions.create!(credit_card_number: 9995123499951234, result: 1)
    invoice3.transactions.create!(credit_card_number: 9995123499951234, result: 1)

    brock = Customer.create!(first_name: 'Brock', last_name: 'Trainer')
    invoice4 = brock.invoices.create!(status: 2)
    invoice_item4 = InvoiceItem.create!(invoice: invoice4, item: super_potion, quantity: 2, unit_price: 5, status: 0)
    invoice4.transactions.create!(credit_card_number: 7795123477951234, result: 1)
    invoice4.transactions.create!(credit_card_number: 7795123477951234, result: 1)

    lance = Customer.create!(first_name: 'Lance', last_name: 'Elite')
    invoice5 = lance.invoices.create!(status: 2)
    invoice_item5 = InvoiceItem.create!(invoice: invoice5, item: potion, quantity: 3, unit_price: 2, status: 0)
    invoice5.transactions.create!(credit_card_number: 1195123411951234, result: 1)
    invoice5.transactions.create!(credit_card_number: 1195123411951234, result: 1)
    invoice5.transactions.create!(credit_card_number: 1195123411951234, result: 1)

    giovanni = Customer.create!(first_name: 'Giovanni', last_name: 'Gym Trainer')
    invoice6 = giovanni.invoices.create!(status: 1)
    invoice_item6 = InvoiceItem.create!(invoice: invoice6, item: ultra_ball, quantity: 99, unit_price: 8, status: 1)
    invoice6.transactions.create!(credit_card_number: 2295123422951234, result: 0)
    invoice6.transactions.create!(credit_card_number: 2295123422951234, result: 0)

    visit "/merchants/#{pokemart.id}/dashboard"

    within "#customer-id-#{trainer_red.id}" do
      expect(page).to have_content(trainer_red.first_name)
      expect(page).to have_content(trainer_red.last_name)
      expect(page).to have_content("Successful Transactions: 6")
      expect(page).to_not have_content(trainer_blue.first_name)
      expect(page).to_not have_content(giovanni.first_name)
    end

    within "#customer-id-#{trainer_blue.id}" do
      expect(page).to have_content(trainer_blue.first_name)
      expect(page).to have_content(trainer_blue.last_name)
      expect(page).to have_content("Successful Transactions: 5")
      expect(page).to_not have_content(trainer_red.first_name)
      expect(page).to_not have_content(giovanni.first_name) 
    end

    within "#customer-id-#{lance.id}" do
      expect(page).to have_content(lance.first_name)
      expect(page).to have_content(lance.last_name)
      expect(page).to have_content("Successful Transactions: 3")
      expect(page).to_not have_content(misty.first_name)
      expect(page).to_not have_content(giovanni.first_name)
    end

    within "#customer-id-#{misty.id}" do
      expect(page).to have_content(misty.first_name)
      expect(page).to have_content(misty.last_name)
      expect(page).to have_content("Successful Transactions: 2")
      expect(page).to_not have_content(lance.first_name)
      expect(page).to_not have_content(giovanni.first_name)
    end

    within "#customer-id-#{brock.id}" do
      expect(page).to have_content(brock.first_name)
      expect(page).to have_content(brock.last_name)
      expect(page).to have_content("Successful Transactions: 2")
      expect(page).to_not have_content(misty.first_name)
      expect(page).to_not have_content(giovanni.first_name)
    end
    save_and_open_page
  end
end