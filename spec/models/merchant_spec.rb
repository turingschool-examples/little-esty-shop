require 'rails_helper'

RSpec.describe Merchant do
  describe 'relationships' do
    it { should have_many :items }
  end

  describe 'instance methods' do
    it 'can order items by least recent invoice' do
      merchant = Merchant.create!(name: 'Trinkets and Tinctures')

      customer1 = Customer.create!(first_name: 'Theophania', last_name: 'Fenwick')
      customer2 = Customer.create!(first_name: 'Vera', last_name: 'Wynn')

      item1 = merchant.items.create!(name: 'Copper Bracelet', description: 'Shiny, but not too shiny', unit_price: 20)
      item2 = merchant.items.create!(name: 'Copper Ring', description: 'Shiny, but not too shiny', unit_price: 10)
      item3 = merchant.items.create!(name: 'Lemongrass Extract', description: 'Smells citrus', unit_price: 6)

      invoice1 = customer1.invoices.create!(status: 1)
      invoice2 = customer2.invoices.create!(status: 1)

      invoice_item1 = InvoiceItem.create!(invoice: invoice1, item: item3, quantity: 1, unit_price: 6, status: 1)
      invoice_item2 = InvoiceItem.create!(invoice: invoice2, item: item1, quantity: 1, unit_price: 20, status: 1)
      invoice_item3 = InvoiceItem.create!(invoice: invoice2, item: item2, quantity: 1, unit_price: 10, status: 2)
      invoice_item4 = InvoiceItem.create!(invoice: invoice1, item: item2, quantity: 1, unit_price: 10, status: 1)

      expect(merchant.items_ready_to_ship).to eq([invoice_item1, invoice_item4, invoice_item2])
    end

    it 'can list the top five most popular items' do
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

      expect(pokemart.top_five_most_popular_items).to eq([ultra_ball, max_revive, super_potion, potion, antidote])
    end

    it 'displays #favorite_customers of a merchant' do
      pokemart = Merchant.create!(name: 'PokeMart')
      potion = pokemart.items.create!(name: 'Potion', description: 'Recovers 10 HP', unit_price: 2)
      super_potion = pokemart.items.create!(name: 'Super Potion', description: 'Recovers 25 HP', unit_price: 5)
      ultra_ball = pokemart.items.create!(name: 'Ultra Ball', description: 'High chance of catching a Pokemon',
                                          unit_price: 8)

      trainer_red = Customer.create!(first_name: 'Red', last_name: 'Trainer')
      invoice1 = trainer_red.invoices.create!(status: 2)
      invoice_item1 = InvoiceItem.create!(invoice: invoice1, item: ultra_ball, quantity: 4, unit_price: 8, status: 0)
      invoice1.transactions.create!(credit_card_number: 3_395_123_433_951_234, result: 1)
      invoice1.transactions.create!(credit_card_number: 3_395_123_433_951_234, result: 1)
      invoice1.transactions.create!(credit_card_number: 3_395_123_433_951_234, result: 1)
      invoice1.transactions.create!(credit_card_number: 3_395_123_433_951_234, result: 1)

      trainer_blue = Customer.create!(first_name: 'Blue', last_name: 'Trainer')
      invoice2 = trainer_blue.invoices.create!(status: 2)
      invoice_item2 = InvoiceItem.create!(invoice: invoice2, item: potion, quantity: 4, unit_price: 2, status: 0)
      invoice2.transactions.create!(credit_card_number: 6_695_123_466_951_234, result: 1)
      invoice2.transactions.create!(credit_card_number: 6_695_123_466_951_234, result: 1)
      invoice2.transactions.create!(credit_card_number: 6_695_123_466_951_234, result: 1)
      invoice2.transactions.create!(credit_card_number: 6_695_123_466_951_234, result: 1)

      misty = Customer.create!(first_name: 'Misty', last_name: 'Trainer')
      invoice3 = misty.invoices.create!(status: 2)
      invoice_item3 = InvoiceItem.create!(invoice: invoice3, item: ultra_ball, quantity: 2, unit_price: 8, status: 0)
      invoice3.transactions.create!(credit_card_number: 9_995_123_499_951_234, result: 1)
      invoice3.transactions.create!(credit_card_number: 9_995_123_499_951_234, result: 1)

      brock = Customer.create!(first_name: 'Brock', last_name: 'Trainer')
      invoice4 = brock.invoices.create!(status: 2)
      invoice_item4 = InvoiceItem.create!(invoice: invoice4, item: super_potion, quantity: 2, unit_price: 5, status: 0)
      invoice4.transactions.create!(credit_card_number: 7_795_123_477_951_234, result: 1)
      invoice4.transactions.create!(credit_card_number: 7_795_123_477_951_234, result: 1)

      lance = Customer.create!(first_name: 'Lance', last_name: 'Elite')
      invoice5 = lance.invoices.create!(status: 2)
      invoice_item5 = InvoiceItem.create!(invoice: invoice5, item: potion, quantity: 3, unit_price: 2, status: 0)
      invoice5.transactions.create!(credit_card_number: 1_195_123_411_951_234, result: 1)
      invoice5.transactions.create!(credit_card_number: 1_195_123_411_951_234, result: 1)
      invoice5.transactions.create!(credit_card_number: 1_195_123_411_951_234, result: 1)

      giovanni = Customer.create!(first_name: 'Giovanni', last_name: 'Gym Trainer')
      invoice6 = giovanni.invoices.create!(status: 1)
      invoice_item6 = InvoiceItem.create!(invoice: invoice6, item: ultra_ball, quantity: 99, unit_price: 8, status: 1)
      invoice6.transactions.create!(credit_card_number: 2_295_123_422_951_234, result: 0)
      invoice6.transactions.create!(credit_card_number: 2_295_123_422_951_234, result: 0)

      expect(pokemart.favorite_customers).to eq([trainer_red, trainer_blue, lance, misty, brock])
    end
  end
  describe 'class methods' do
    it 'enabled_merchants returns all merchants with status 1 (Enabled)' do
      merchant1 = Merchant.create!(name: 'Potions and Things', status: 'Enabled')
      merchant2 = Merchant.create!(name: 'Wands and Wigs', status: 'Enabled')
      merchant3 = Merchant.create!(name: 'Berties Beans', status: 'Enabled')
      merchant4 = Merchant.create!(name: 'Butterbeer Superstore', status: 'Disabled')

      actual = Merchant.enabled_merchants.map do |merchant|
        merchant.name
      end
      expected = [merchant1, merchant2, merchant3].map do |merchant|
        merchant.name
      end

      expect(actual).to eq(expected)
    end
    it 'disabled_merchants returns all merchants with status 0 (Disabled)' do
      merchant1 = Merchant.create!(name: 'Potions and Things', status: 'Enabled')
      merchant2 = Merchant.create!(name: 'Wands and Wigs', status: 'Disabled')
      merchant3 = Merchant.create!(name: 'Berties Beans', status: 'Disabled')
      merchant4 = Merchant.create!(name: 'Butterbeer Superstore', status: 'Disabled')

      actual = Merchant.disabled_merchants.map do |merchant|
        merchant.name
      end
      expected = [merchant2, merchant3, merchant4].map do |merchant|
        merchant.name
      end

      expect(actual).to eq(expected)
    end
  end
end
