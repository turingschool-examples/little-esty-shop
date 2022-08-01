require 'rails_helper'

RSpec.describe 'admin invoices show page' do
  before :each do
    @pokemart = Merchant.create!(name: 'PokeMart')
    @potion = @pokemart.items.create!(name: 'Potion', description: 'Recovers 10 HP', unit_price: 2)
    @super_potion = @pokemart.items.create!(name: 'Super Potion', description: 'Recovers 25 HP', unit_price: 5)
    @ultra_ball = @pokemart.items.create!(name: 'Ultra Ball', description: 'High chance of catching a Pokemon',
                                          unit_price: 8)

    @trainer_red = Customer.create!(first_name: 'Red', last_name: 'Trainer')
    @invoice1 = @trainer_red.invoices.create!(status: 2, created_at: '2022-07-26 01:08:32 UTC')
    @invoice2 = @trainer_red.invoices.create!(status: 2)
    @invoice_item1 = InvoiceItem.create!(invoice: @invoice1, item: @ultra_ball, quantity: 2, unit_price: 8,
                                         status: 0)
    @invoice_item2 = InvoiceItem.create!(invoice: @invoice1, item: @super_potion, quantity: 2, unit_price: 5,
                                         status: 0)
    @invoice1.transactions.create!(credit_card_number: 3_395_123_433_951_234, result: 1)
    @invoice1.transactions.create!(credit_card_number: 3_395_123_433_951_234, result: 1)
    @invoice2.transactions.create!(credit_card_number: 3_395_123_433_951_234, result: 1)
    @invoice2.transactions.create!(credit_card_number: 3_395_123_433_951_234, result: 1)

    @pokegarden = Merchant.create!(name: 'PokeGarden')
    @razz_berry = @pokegarden.items.create!(name: 'Razz Berry',
                                            description: 'Feed this to a Pokémon, and it will be easier to catch on your next throw.', unit_price: 2)
    @nanab_berry = @pokegarden.items.create!(name: 'Nanab Berry',
                                             description: 'Feed this to a Pokémon to calm it down, making it less erratic.', unit_price: 5)
    @pinap_berry = @pokegarden.items.create!(name: 'Pinap Berry',
                                             description: 'Feed this to a Pokémon to make it drop more Candy.', unit_price: 8)

    @trainer_blue = Customer.create!(first_name: 'Blue', last_name: 'Trainer')
    @invoice3 = @trainer_blue.invoices.create!(status: 2)
    @invoice4 = @trainer_blue.invoices.create!(status: 2)
    @invoice_item3 = InvoiceItem.create!(invoice: @invoice3, item: @razz_berry, quantity: 2, unit_price: 8,
                                         status: 0)
    @invoice_item4 = InvoiceItem.create!(invoice: @invoice4, item: @pinap_berry, quantity: 2, unit_price: 5,
                                         status: 0)
    @invoice3.transactions.create!(credit_card_number: 1_195_123_411_951_234, result: 1)
    @invoice3.transactions.create!(credit_card_number: 1_195_123_411_951_234, result: 1)
    @invoice4.transactions.create!(credit_card_number: 1_195_123_411_951_234, result: 1)
    @invoice4.transactions.create!(credit_card_number: 1_195_123_411_951_234, result: 1)
  end

  it 'displays invoice attributes' do
    visit "/admin/invoices/#{@invoice1.id}"

    within '#invoice-attributes' do
      expect(page).to have_content("Invoice ID: #{@invoice1.id}")
      expect(page).to have_content("Invoice Status: #{@invoice1.status}")
      expect(page).to have_content('Created At: Tuesday, July 26, 2022')
      expect(page).to have_content('Customer Name: Red Trainer')
    end
  end

  it 'displays invoice item information' do
    visit "/admin/invoices/#{@invoice1.id}"

    within "#invoice-item-#{@invoice_item1.id}" do
      expect(page).to have_content("Item Name: #{@invoice_item1.item.name}")
      expect(page).to have_content("Quantity: #{@invoice_item1.quantity}")
      expect(page).to have_content("Price: #{@invoice_item1.unit_price}")
      expect(page).to have_content("Status: #{@invoice_item1.status}")
    end

    within "#invoice-item-#{@invoice_item2.id}" do
      expect(page).to have_content("Item Name: #{@invoice_item2.item.name}")
      expect(page).to have_content("Quantity: #{@invoice_item2.quantity}")
      expect(page).to have_content("Price: #{@invoice_item2.unit_price}")
      expect(page).to have_content("Status: #{@invoice_item2.status}")
    end
  end
end
