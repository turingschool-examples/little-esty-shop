require 'rails_helper'

RSpec.describe 'Item show page' do
  before :each do
    @merchant1 = Merchant.create!(name: 'Sparkys Shop')

    @customer1 = Customer.create!(first_name: 'Petey', last_name: 'Wimbley')
    @customer2 = Customer.create!(first_name: 'Victoria', last_name: 'Jenkins')

    @item1 = @merchant1.items.create!(name: 'Teddy Bear', description: 'So fuzzy', unit_price: 2000)
    @item2 = @merchant1.items.create!(name: 'Toy Car', description: 'So fast', unit_price: 3000)

    @invoice1 = @customer1.invoices.create!(status: 2)
    @invoice2 = @customer2.invoices.create!(status: 2)


    @transaction10 = @invoice2.transactions.create!(credit_card_number: "7894739999", credit_card_expiration_date: '04/20', result: 1)


    @transaction15 = @invoice1.transactions.create!(credit_card_number: "7894739999", credit_card_expiration_date: '04/20', result: 0)


    @invoice1.items << [@item1]
    @invoice2.items << [@item1]
  end

  describe 'merchant' do
    it 'displays item and its attributes' do
      visit "/merchants/#{@merchant1.id}/items/#{@item1.id}"

      expect(page).to have_content(@item1.name)
      expect(page).to have_content(@item1.description)
      expect(page).to have_content("$#{@item1.price_to_dollars}")
    end
  end
end
