require 'rails_helper'

RSpec.describe 'merchant items index' do
  it 'has the name of all the merchants items' do
    merch1 = Merchant.create!(name: 'Jolly Roger Imports')
    merch2 = Merchant.create!(name: 'Molly Fine Arts')

    item1 = Item.create!(name: 'Shoe', description: 'Just one shoe', unit_price: 500, merchant_id: merch1.id)
    item2 = Item.create!(name: 'Sock', description: 'A sock', unit_price: 200, merchant_id: merch1.id)
    item3 = Item.create!(name: 'Jerky', description: 'Alligator jerky', unit_price: 1500, merchant_id: merch2.id)

    visit "/merchants/#{merch1.id}/items"
    expect(current_path).to eq("/merchants/#{merch1.id}/items")

    expect(page).to have_content('Shoe')
    expect(page).to have_content('Sock')
    expect(page).to_not have_content('Jerky')
  end

  it 'has a button next to each item name to disable or enable that item. When clicked, user is redirected to item index and sees item status has changed' do
    merch1 = Merchant.create!(name: 'Jolly Roger Imports')
    merch2 = Merchant.create!(name: 'Molly Fine Arts')

    item1 = Item.create!(name: 'Shoe', description: 'Just one shoe', unit_price: 500, merchant_id: merch1.id, status: 1)
    item2 = Item.create!(name: 'Sock', description: 'A sock', unit_price: 200, merchant_id: merch1.id)
    item3 = Item.create!(name: 'Jerky', description: 'Alligator jerky', unit_price: 1500, merchant_id: merch1.id)

    visit "/merchants/#{merch1.id}/items"

    within '#enabled-items' do
      expect(page).to have_content('Shoe')
    end

    within '#disabled-items' do
      expect(page).to have_content('Sock')
      expect(page).to have_content('Jerky')
    end

    within "#enabled-item-#{item1.id}" do
      click_on 'Disable'
    end

    expect(current_path).to eq("/merchants/#{merch1.id}/items")

    within '#disabled-items' do
      expect(page).to have_content('Shoe')
    end

    within "#disabled-item-#{item3.id}" do
      click_on 'Enable'
    end

    expect(current_path).to eq("/merchants/#{merch1.id}/items")

    within '#enabled-items' do
      expect(page).to have_content('Jerky')
    end
  end

  it 'has link to create a new item, which takes user to a form to add item information' do
    merch1 = Merchant.create!(name: 'Jolly Roger Imports')
    merch2 = Merchant.create!(name: 'Molly Fine Arts')

    item1 = Item.create!(name: 'Shoe', description: 'Just one shoe', unit_price: 500, merchant_id: merch1.id, status: 1)
    item2 = Item.create!(name: 'Sock', description: 'A sock', unit_price: 200, merchant_id: merch1.id)
    item3 = Item.create!(name: 'Jerky', description: 'Alligator jerky', unit_price: 1500, merchant_id: merch1.id)

    visit "/merchants/#{merch1.id}/items"

    click_link 'New Item'

    expect(current_path).to eq("/merchants/#{merch1.id}/items/new")
  end

  it 'lists the top five items ranked by total revenue generated' do
    pokemart = Merchant.create!(name: 'PokeMart')
    potion = pokemart.items.create!(name: 'Potion', description: 'Recovers 10 HP', unit_price: 2)
    super_potion = pokemart.items.create!(name: 'Super Potion', description: 'Recovers 25 HP', unit_price: 5)
    max_revive = pokemart.items.create!(name: 'Max Revive', description: 'Recovers all HP', unit_price: 10)
    great_ball = pokemart.items.create!(name: 'Great Ball', description: 'Medium chance of catching a Pokemon',
                                        unit_price: 6)
    ultra_ball = pokemart.items.create!(name: 'Ultra Ball', description: 'High chance of catching a Pokemon',
                                        unit_price: 8)
    antidote = pokemart.items.create!(name: 'Antidote', description: 'Removes poison', unit_price: 2)

    ash = Customer.create!(first_name: 'Ash', last_name: 'Trainer')

    invoice = ash.invoices.create!(status: 2)
    invoice_item1 = InvoiceItem.create!(invoice: invoice, item: ultra_ball, quantity: 4, unit_price: 8, status: 0)
    invoice_item2 = InvoiceItem.create!(invoice: invoice, item: potion, quantity: 5, unit_price: 2, status: 0)
    invoice_item3 = InvoiceItem.create!(invoice: invoice, item: antidote, quantity: 2, unit_price: 2, status: 0)
    invoice_item4 = InvoiceItem.create!(invoice: invoice, item: max_revive, quantity: 4, unit_price: 10, status: 0)
    invoice_item5 = InvoiceItem.create!(invoice: invoice, item: super_potion, quantity: 5, unit_price: 5, status: 0)
    invoice.transactions.create!(credit_card_number: 4_173_732_636_201_894, result: 1)

    invoice2 = ash.invoices.create!(status: 1)
    invoice_item5 = InvoiceItem.create!(invoice: invoice2, item: great_ball, quantity: 4, unit_price: 6, status: 0)

    visit "/merchants/#{pokemart.id}/items"

    within '#top-items-list' do
      expect(page).to have_content('Potion')
      expect(page).to have_content('Super Potion')
      expect(page).to have_content('Max Revive')
      expect(page).to have_content('Ultra Ball')
      expect(page).to have_content('Antidote')
      expect(page).to_not have_content('Great Ball')
    end
  end

  it 'top items link to the merchant item show page for that item' do
    pokemart = Merchant.create!(name: 'PokeMart')
    potion = pokemart.items.create!(name: 'Potion', description: 'Recovers 10 HP', unit_price: 2)
    super_potion = pokemart.items.create!(name: 'Super Potion', description: 'Recovers 25 HP', unit_price: 5)
    max_revive = pokemart.items.create!(name: 'Max Revive', description: 'Recovers all HP', unit_price: 10)
    great_ball = pokemart.items.create!(name: 'Great Ball', description: 'Medium chance of catching a Pokemon',
                                        unit_price: 6)
    ultra_ball = pokemart.items.create!(name: 'Ultra Ball', description: 'High chance of catching a Pokemon',
                                        unit_price: 8)
    antidote = pokemart.items.create!(name: 'Antidote', description: 'Removes poison', unit_price: 2)

    ash = Customer.create!(first_name: 'Ash', last_name: 'Trainer')

    invoice = ash.invoices.create!(status: 2)
    invoice_item1 = InvoiceItem.create!(invoice: invoice, item: ultra_ball, quantity: 4, unit_price: 8, status: 0)
    invoice_item2 = InvoiceItem.create!(invoice: invoice, item: potion, quantity: 5, unit_price: 2, status: 0)
    invoice_item3 = InvoiceItem.create!(invoice: invoice, item: antidote, quantity: 2, unit_price: 2, status: 0)
    invoice_item4 = InvoiceItem.create!(invoice: invoice, item: max_revive, quantity: 4, unit_price: 10, status: 0)
    invoice_item5 = InvoiceItem.create!(invoice: invoice, item: super_potion, quantity: 5, unit_price: 5, status: 0)
    invoice.transactions.create!(credit_card_number: 4_173_732_636_201_894, result: 1)

    invoice2 = ash.invoices.create!(status: 1)
    invoice_item5 = InvoiceItem.create!(invoice: invoice2, item: great_ball, quantity: 4, unit_price: 6, status: 0)

    visit "/merchants/#{pokemart.id}/items"

    within "#top-items-item-#{max_revive.id}" do
      click_link 'Max Revive'
    end
    expect(current_path).to eq("/merchants/#{pokemart.id}/items/#{max_revive.id}")
  end
end
