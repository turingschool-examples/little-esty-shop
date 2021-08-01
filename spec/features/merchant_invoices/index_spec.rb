require 'rails_helper'

RSpec.describe 'Merchant Invoices Index Page' do
  before :each do
    @merchant1 = Merchant.create!(name: 'Sparkys Shop')
    @merchant2 = Merchant.create!(name: 'BBs Petstore')

    @customer1 = Customer.create!(first_name: 'Petey', last_name: 'Wimbley')
    @customer2 = Customer.create!(first_name: 'Victoria', last_name: 'Jenkins')
    @customer3 = Customer.create!(first_name: 'Pedro', last_name: 'Oscar')
    @customer4 = Customer.create!(first_name: 'Scarlett', last_name: 'Redsley')
    @customer5 = Customer.create!(first_name: 'Annie', last_name: 'Snip')
    @customer6 = Customer.create!(first_name: 'Goran', last_name: 'Babalia')

    @item1 = @merchant1.items.create!(name: 'Teddy Bear', description: 'So fuzzy', unit_price: 2000)
    @item2 = @merchant1.items.create!(name: 'Toy Car', description: 'So fast', unit_price: 3000)
    @item3 = @merchant1.items.create!(name: 'Bouncy Ball', description: 'So bouncy', unit_price: 500)
    @item4 = @merchant2.items.create!(name: 'Dog Bone', description: 'So chewy', unit_price: 800)

    @invoice1 = @customer1.invoices.create!(status: 0)
    @invoice2 = @customer2.invoices.create!(status: 1)
    @invoice3 = @customer3.invoices.create!(status: 2)
    @invoice4 = @customer4.invoices.create!(status: 0)
    @invoice5 = @customer5.invoices.create!(status: 1)
    @invoice6 = @customer6.invoices.create!(status: 2)

    @transaction1 = @invoice1.transactions.create!(credit_card_number: "0123456789", credit_card_expiration_date: '12/31', result: 0)
    @transaction2 = @invoice2.transactions.create!(credit_card_number: "9876543210", credit_card_expiration_date: '01/01', result: 0)
    @transaction3 = @invoice3.transactions.create!(credit_card_number: "4444444444", credit_card_expiration_date: '06/07', result: 0)
    @transaction4 = @invoice4.transactions.create!(credit_card_number: "2222111100", credit_card_expiration_date: '02/02', result: 0)
    @transaction5 = @invoice5.transactions.create!(credit_card_number: "7934759378", credit_card_expiration_date: '03/20', result: 0)
    @transaction6 = @invoice6.transactions.create!(credit_card_number: "7894739999", credit_card_expiration_date: '04/20', result: 0)

    @invoice1.items << [@item1]
    @invoice2.items << [@item2]
    @invoice3.items << [@item3, @item4]
    @invoice4.items << [@item4]
    @invoice5.items << [@item4]
    @invoice6.items << [@item1, @item2]
  end

  describe 'merchant' do
    it 'displays all invoices with at least one merchant item' do
      visit "/merchants/#{@merchant1.id}/invoices"

      expect(page).to have_content(@invoice1.id.to_s)
      expect(page).to have_content(@invoice2.id.to_s)
      expect(page).to have_content(@invoice3.id.to_s)
      expect(page).to have_content(@invoice6.id.to_s)

      expect(page).to_not have_content(@invoice4.id.to_s)
      expect(page).to_not have_content(@invoice5.id.to_s)
    end

    it 'can link an invoice to its show page' do
      visit "/merchants/#{@merchant1.id}/invoices"

      click_on(@invoice1.id.to_s)

      expect(current_path).to eq("/merchants/#{@merchant1.id}/invoices/#{@invoice1.id}")
    end
  end
end
