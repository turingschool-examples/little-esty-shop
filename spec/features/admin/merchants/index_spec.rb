require 'rails_helper'

RSpec.describe 'Admin::Merchants' do
  describe 'index page' do
    before(:each) do
      @merchant1 = create(:merchant)
      @merchant2 = create(:merchant)
      @merchant3 = create(:merchant)
      @merchant4 = create(:merchant)
      @merchant5 = create(:merchant, enabled: false)

      visit '/admin/merchants'
    end

    describe 'Admin Invoices Index Page' do

      it 'displays the name of each merchant in the systems' do

        expect(page).to have_content(@merchant1.name)
        expect(page).to have_content(@merchant2.name)
        expect(page).to have_content(@merchant3.name)
        expect(page).to have_content(@merchant4.name)
        expect(page).to have_content(@merchant5.name)
      end
    end

    describe 'Link to Merchant Show page' do
      it 'when clicking the name of the merchant, visitor is redirected to merchant show page' do
        expect(page).to have_link(@merchant1.name)
        expect(page).to have_link(@merchant2.name)
        expect(page).to have_link(@merchant3.name)
        expect(page).to have_link(@merchant4.name)
        expect(page).to have_link(@merchant5.name)

        click_on @merchant1.name

        expect(current_path).to eq(admin_merchant_path(@merchant1.id))
      end
    end

    describe 'Merchant Enable Button' do
      it 'has a button to disable/enable each merchant' do
        expect(page).to have_button("Disable #{@merchant1.name}")
        expect(page).to have_button("Enable #{@merchant5.name}")

        click_on "Enable #{@merchant5.name}"

        expect(current_path).to eq(admin_merchants_path)
        expect(page).to have_button("Disable #{@merchant5.name}")
      end
    end

    describe 'group by status' do
      it 'page shows 2 sections enabled merchants and diabled merchants' do

        within('#green') do
          expect(page).to have_content("Enabled Merchants")
        end

        within('#red')
        expect(page).to have_content("Disabled Merchants")
      end
    end

    describe 'Admin Merchant Create' do
      it 'has a link to create a new Merchant' do

        expect(page).to have_link('Create Merchant')

        click_link 'Create Merchant'

        expect(current_path).to eq(new_admin_merchant_path)

        fill_in 'Name', with: "Darry 'Big J' Johnson"
        click_on 'Submit'

        expect(current_path).to eq(admin_merchants_path)

        expect(page).to have_content("Darry 'Big J' Johnson")

        within('#red')
        expect(page).to have_button("Enable Darry 'Big J' Johnson")
      end
    end
  end

  describe 'Top 5 Merchants by Revenue' do

    it 'Displays the top 5 merchants by Revenue' do
      merchant1 = create(:merchant)
      merchant2 = create(:merchant)
      merchant3 = create(:merchant)
      merchant4 = create(:merchant)
      merchant5 = create(:merchant)
      merchant6 = create(:merchant)
      merchant7 = create(:merchant)
      merchant8 = create(:merchant)
      merchant9 = create(:merchant)
      merchant10 = create(:merchant)

      customer1 = create(:customer)
      customer2 = create(:customer)
      customer3 = create(:customer)
      customer4 = create(:customer)
      customer5 = create(:customer)
      customer6 = create(:customer)

      invoice1 = create(:invoice, customer_id: customer1.id)
      invoice2 = create(:invoice, customer_id: customer2.id)
      invoice3 = create(:invoice, customer_id: customer3.id)
      invoice4 = create(:invoice, customer_id: customer4.id)
      invoice5 = create(:invoice, customer_id: customer5.id)
      invoice6 = create(:invoice, customer_id: customer1.id)
      invoice7 = create(:invoice, customer_id: customer3.id)
      invoice8 = create(:invoice, customer_id: customer5.id)
      invoice9 = create(:invoice, customer_id: customer1.id)
      invoice10 = create(:invoice, customer_id: customer2.id)

      item1 = create(:item, unit_price: 10, merchant_id: merchant1.id)
      item2 = create(:item, unit_price: 14, merchant_id: merchant2.id)
      item3 = create(:item, unit_price: 16, merchant_id: merchant3.id)
      item4 = create(:item, unit_price: 18, merchant_id: merchant4.id)
      item5 = create(:item, unit_price: 20, merchant_id: merchant5.id)
      item6 = create(:item, unit_price: 7, merchant_id: merchant6.id)
      item7 = create(:item, unit_price: 4, merchant_id: merchant7.id)
      item8 = create(:item, unit_price: 4, merchant_id: merchant8.id)
      item9 = create(:item, unit_price: 8, merchant_id: merchant9.id)
      item10 = create(:item, unit_price: 7, merchant_id: merchant10.id)

      invoice_item1 = create(:invoice_item, quantity: 2, unit_price: 10, item_id: item1.id, invoice_id: invoice1.id, status: 0)
      invoice_item2 = create(:invoice_item, quantity: 2, unit_price: 14, item_id: item2.id, invoice_id: invoice2.id, status: 0)
      invoice_item3 = create(:invoice_item, quantity: 2, unit_price: 16, item_id: item3.id, invoice_id: invoice3.id, status: 0)
      invoice_item4 = create(:invoice_item, quantity: 2, unit_price: 18, item_id: item4.id, invoice_id: invoice4.id, status: 0)
      invoice_item5 = create(:invoice_item, quantity: 2, unit_price: 20, item_id: item5.id, invoice_id: invoice5.id, status: 0)
      invoice_item6 = create(:invoice_item, quantity: 1, unit_price: 7, item_id: item6.id, invoice_id: invoice6.id, status: 0)
      invoice_item7 = create(:invoice_item, quantity: 1, unit_price: 4, item_id: item7.id, invoice_id: invoice7.id, status: 0)
      invoice_item8 = create(:invoice_item, quantity: 1, unit_price: 4, item_id: item8.id, invoice_id: invoice8.id, status: 0)
      invoice_item9 = create(:invoice_item, quantity: 1, unit_price: 8, item_id: item9.id, invoice_id: invoice9.id, status: 0)
      invoice_item10 = create(:invoice_item, quantity: 1, unit_price: 7, item_id: item10.id, invoice_id: invoice10.id, status: 0)

      transaction1 = create(:transaction, invoice_id: invoice1.id, result: 0)
      transaction2 = create(:transaction, invoice_id: invoice2.id, result: 0)
      transaction3 = create(:transaction, invoice_id: invoice3.id, result: 0)
      transaction4 = create(:transaction, invoice_id: invoice4.id, result: 0)
      transaction5 = create(:transaction, invoice_id: invoice5.id, result: 0)
      transaction6 = create(:transaction, invoice_id: invoice6.id, result: 0)
      transaction7 = create(:transaction, invoice_id: invoice7.id, result: 0)
      transaction8 = create(:transaction, invoice_id: invoice8.id, result: 0)
      transaction9 = create(:transaction, invoice_id: invoice9.id, result: 0)
      transaction10 = create(:transaction, invoice_id: invoice10.id, result: 0)

      visit '/admin/merchants'

      within '#top-merchants' do
        expect(merchant5.name).to appear_before(merchant4.name)
        expect(merchant4.name).to appear_before(merchant3.name)
        expect(merchant3.name).to appear_before(merchant2.name)
        expect(merchant2.name).to appear_before(merchant1.name)
      end
    end
  end
end
