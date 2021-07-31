require 'rails_helper'

RSpec.describe 'Merchant Items show page' do
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
    @item2 = @merchant1.items.create!(name: 'Toy Car', description: 'So fast', unit_price: 30000)
    @item3 = @merchant1.items.create!(name: 'Bouncy Ball', description: 'So bouncy', unit_price: 5000)
    @item4 = @merchant2.items.create!(name: 'Dog Bone', description: 'So chewy', unit_price: 8000)

    @invoice1 = @customer1.invoices.create!(status: 2)
    @invoice2 = @customer2.invoices.create!(status: 2)
    @invoice3 = @customer3.invoices.create!(status: 2)
    @invoice4 = @customer4.invoices.create!(status: 2)
    @invoice5 = @customer5.invoices.create!(status: 2)
    @invoice6 = @customer6.invoices.create!(status: 2)
    @invoice7 = @customer5.invoices.create!(status: 1)

    @transaction1 = @invoice5.transactions.create!(credit_card_number: "0123456789", credit_card_expiration_date: '12/31', result: 0)
    @transaction2 = @invoice5.transactions.create!(credit_card_number: "9876543210", credit_card_expiration_date: '01/01', result: 0)
    @transaction3 = @invoice5.transactions.create!(credit_card_number: "4444444444", credit_card_expiration_date: '06/07', result: 0)
    @transaction4 = @invoice5.transactions.create!(credit_card_number: "2222111100", credit_card_expiration_date: '02/02', result: 0)
    @transaction5 = @invoice5.transactions.create!(credit_card_number: "7934759378", credit_card_expiration_date: '03/20', result: 0)
    @transaction6 = @invoice6.transactions.create!(credit_card_number: "7894739999", credit_card_expiration_date: '04/20', result: 0)
    @transaction7 = @invoice6.transactions.create!(credit_card_number: "1231231312", credit_card_expiration_date: '09/34', result: 0)
    @transaction8 = @invoice6.transactions.create!(credit_card_number: "7453534534", credit_card_expiration_date: '12/12', result: 0)
    @transaction9 = @invoice6.transactions.create!(credit_card_number: "7894739999", credit_card_expiration_date: '06/10', result: 0)
    @transaction10 = @invoice2.transactions.create!(credit_card_number: "7894739999", credit_card_expiration_date: '04/20', result: 0)
    @transaction11 = @invoice2.transactions.create!(credit_card_number: "7894739999", credit_card_expiration_date: '04/20', result: 0)
    @transaction12 = @invoice2.transactions.create!(credit_card_number: "7894739999", credit_card_expiration_date: '04/20', result: 0)
    @transaction13 = @invoice4.transactions.create!(credit_card_number: "7894739999", credit_card_expiration_date: '04/20', result: 0)
    @transaction14 = @invoice4.transactions.create!(credit_card_number: "7894739999", credit_card_expiration_date: '04/20', result: 0)
    @transaction15 = @invoice1.transactions.create!(credit_card_number: "7894739999", credit_card_expiration_date: '04/20', result: 0)
    @transaction16 = @invoice1.transactions.create!(credit_card_number: "7894739999", credit_card_expiration_date: '04/20', result: 1)
    @transaction17 = @invoice3.transactions.create!(credit_card_number: "7894739999", credit_card_expiration_date: '04/20', result: 1)
    @transaction18 = @invoice3.transactions.create!(credit_card_number: "7894739999", credit_card_expiration_date: '04/20', result: 1)

    @invoice1.items << [@item1]
    @invoice2.items << [@item1]
    @invoice3.items << [@item1]
    @invoice4.items << [@item2]
    @invoice5.items << [@item2]
    @invoice6.items << [@item1]
  end

  describe 'merchant' do
    it 'displays all the merchants items' do
      visit "merchants/#{@merchant1.id}/items"

      expect(page).to have_content(@item1.name)
      expect(page).to have_content(@item2.name)
      expect(page).to have_content(@item3.name)
      expect(page).to_not have_content(@item4.name)
    end

    it 'can take you to the an items show page' do
      visit "merchants/#{@merchant1.id}/items"

      click_on(@item1.name)

      expect(current_path).to eq("/merchants/#{@merchant1.id}/items/#{@item1.id}")
    end

    it 'can enable and disable items' do
      @item1.update!(status: 0)
      visit "merchants/#{@merchant1.id}/items"

      within(:css, "##{@item1.id}") do
        expect(page).to have_content('Status: enabled')
        click_on('Disable')
      end

      expect(current_path).to eq("/merchants/#{@merchant1.id}/items")

      within(:css, "##{@item1.id}") do
        expect(page).to have_content('Status: disabled')
        click_on('Enable')
      end

      expect(current_path).to eq("/merchants/#{@merchant1.id}/items")

      within(:css, "##{@item1.id}") do
        expect(page).to have_content('Status: enabled')
      end  
    end

    it 'displays items by their status' do
      @item1.update!(status: 0)
      @item2.update!(status: 1)

      visit "merchants/#{@merchant1.id}/items"

      within(:css, "#enabled") do
        expect(page).to have_content('Enabled Items')
        expect(page).to have_content(@item1.name)
        expect(page).to_not have_content(@item2.name)
      end

      within(:css, "#disabled") do
        expect(page).to have_content('Disabled Items')
        expect(page).to have_content(@item2.name)
        expect(page).to_not have_content(@item1.name)
      end
    end
  end
end
