require 'rails_helper'

RSpec.describe 'admin invoices index page' do
    before :each do
        @pokemart = Merchant.create!(name: 'PokeMart')
        @potion = @pokemart.items.create!(name: 'Potion', description: 'Recovers 10 HP', unit_price: 2)
        @super_potion = @pokemart.items.create!(name: 'Super Potion', description: 'Recovers 25 HP', unit_price: 5)
        @ultra_ball = @pokemart.items.create!(name: 'Ultra Ball', description: 'High chance of catching a Pokemon', unit_price: 8)

        @trainer_red = Customer.create!(first_name: 'Red', last_name: 'Trainer')
        @invoice1 = @trainer_red.invoices.create!(status: 2)
        @invoice2 = @trainer_red.invoices.create!(status: 2)
        @invoice_item1 = InvoiceItem.create!(invoice: @invoice1, item: @ultra_ball, quantity: 2, unit_price: 8, status: 0)
        @invoice_item2 = InvoiceItem.create!(invoice: @invoice2, item: @super_potion, quantity: 2, unit_price: 5, status: 0)
        @invoice1.transactions.create!(credit_card_number: 3395123433951234, result: 1)
        @invoice1.transactions.create!(credit_card_number: 3395123433951234, result: 1)
        @invoice2.transactions.create!(credit_card_number: 3395123433951234, result: 1)
        @invoice2.transactions.create!(credit_card_number: 3395123433951234, result: 1)

        @pokegarden = Merchant.create!(name: 'PokeGarden')
        @razz_berry = @pokegarden.items.create!(name: 'Razz Berry', description: 'Feed this to a Pokémon, and it will be easier to catch on your next throw.', unit_price: 2)
        @nanab_berry = @pokegarden.items.create!(name: 'Nanab Berry', description: 'Feed this to a Pokémon to calm it down, making it less erratic.', unit_price: 5)
        @pinap_berry = @pokegarden.items.create!(name: 'Pinap Berry', description: 'Feed this to a Pokémon to make it drop more Candy.', unit_price: 8)

        @trainer_blue = Customer.create!(first_name: 'Blue', last_name: 'Trainer')
        @invoice3 = @trainer_blue.invoices.create!(status: 2)
        @invoice4 = @trainer_blue.invoices.create!(status: 2)
        @invoice_item3 = InvoiceItem.create!(invoice: @invoice3, item: @razz_berry, quantity: 2, unit_price: 8, status: 0)
        @invoice_item4 = InvoiceItem.create!(invoice: @invoice4, item: @pinap_berry, quantity: 2, unit_price: 5, status: 0)
        @invoice3.transactions.create!(credit_card_number: 1195123411951234, result: 1)
        @invoice3.transactions.create!(credit_card_number: 1195123411951234, result: 1)
        @invoice4.transactions.create!(credit_card_number: 1195123411951234, result: 1)
        @invoice4.transactions.create!(credit_card_number: 1195123411951234, result: 1)
    end
    
    it 'lists all invoice IDs in the system' do
        visit "/admin/invoices"

        expect(page).to have_content(@invoice1.id)
    end

    it 'invoice id links to show page' do
        visit "/admin/invoices"

        expect(page).to have_link(@invoice1.id.to_s)
        click_link @invoice1.id.to_s
        expect(current_path).to eq("/admin/invoices/#{@invoice1.id}")
    end
end