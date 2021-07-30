require 'rails_helper'

RSpec.describe 'Admin::Merchants' do

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

  describe 'Top 5 Merchants byvRevenue' do

    it 'Displays the top 5 merchants by Revenue' do
      merchant1 = create(:merchant)
      merchant2 = create(:merchant)
      merchant3 = create(:merchant)
      merchant4 = create(:merchant)
      merchant5 = create(:merchant, enabled: false)

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
      invoice6 = create(:invoice, customer_id: customer6.id)

      item1 = create(:item, merchant_id: merchant.id)
      item2 = create(:item, merchant_id: merchant.id)

      invoice_item1 = create(:invoice_item, item_id: item1.id, invoice_id: invoice1.id, status: 0)
      invoice_item2 = create(:invoice_item, item_id: item1.id, invoice_id: invoice2.id, status: 0)
      invoice_item3 = create(:invoice_item, item_id: item1.id, invoice_id: invoice3.id, status: 1)
      invoice_item4 = create(:invoice_item, item_id: item2.id, invoice_id: invoice4.id, status: 1)
      invoice_item5 = create(:invoice_item, item_id: item2.id, invoice_id: invoice5.id, status: 2)
      invoice_item6 = create(:invoice_item, item_id: item2.id, invoice_id: invoice6.id, status: 0)

      transaction1 = create(:transaction, invoice_id: invoice1.id, result: 0)
      transaction2 = create(:transaction, invoice_id: invoice1.id, result: 0)
      transaction3 = create(:transaction, invoice_id: invoice2.id, result: 0)
      transaction4 = create(:transaction, invoice_id: invoice3.id, result: 0)
      transaction5 = create(:transaction, invoice_id: invoice4.id, result: 1)
      transaction6 = create(:transaction, invoice_id: invoice5.id, result: 1)
      transaction7 = create(:transaction, invoice_id: invoice6.id, result: 1)

      within 
    end
  end  
  end
