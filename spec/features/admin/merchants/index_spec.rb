require 'rails_helper'

RSpec.describe 'admin/merchants index page' do
  before :each do
    @merchant_1 = Merchant.create!(name: "Marvel", status: 'enabled')
    @merchant_2 = Merchant.create!(name: "D.C.", status: 'disabled')
    @merchant_3 = Merchant.create!(name: "Darkhorse", status: 'enabled')
    @merchant_4 = Merchant.create!(name: "Image", status: 'disabled')
    @merchant_5 = Merchant.create!(name: "Wonders", status: 'enabled')
    @merchant_6 = Merchant.create!(name: "Disney", status: 'enabled')

    @customer1 = Customer.create!(first_name: 'Peter', last_name: 'Parker') # 1/1
    @customer2 = Customer.create!(first_name: 'Clark', last_name: 'Kent') # 3/0
    @customer3 = Customer.create!(first_name: 'Louis', last_name: 'Lane') # 2/0
    @customer4 = Customer.create!(first_name: 'Lex', last_name: 'Luther') # 0/0
    @customer5 = Customer.create!(first_name: 'Frank', last_name: 'Castle') # 1/0
    @customer6 = Customer.create!(first_name: 'Matt', last_name: 'Murdock') # 1/0
    @customer7 = Customer.create!(first_name: 'Bruce', last_name: 'Wayne') # 0/1

    @invoice1 = Invoice.create!(status: 'completed', customer_id: @customer1.id) # marvel
    @invoice2 = Invoice.create!(status: 'completed', customer_id: @customer2.id) # marvel
    @invoice3 = Invoice.create!(status: 'completed', customer_id: @customer3.id) # marvel
    @invoice4 = Invoice.create!(status: 'cancelled', customer_id: @customer4.id) # marvel
    @invoice5 = Invoice.create!(status: 'completed', customer_id: @customer5.id) # marvel
    @invoice6 = Invoice.create!(status: 'completed', customer_id: @customer6.id) # marvel
    @invoice7 = Invoice.create!(status: 'completed', customer_id: @customer7.id) # D.C.
    @invoice8 = Invoice.create!(status: 'completed', customer_id: @customer1.id) # D.C.
    @invoice9 = Invoice.create!(status: 'completed', customer_id: @customer2.id) # marvel
    @invoice10 = Invoice.create!(status: 'completed', customer_id: @customer2.id) # marvel
    @invoice11 = Invoice.create!(status: 'completed', customer_id: @customer3.id) # marvel

    @item1 = Item.create!(name: 'Beanie Babies', description: 'Investments', unit_price: 100, merchant_id: @merchant_1.id)
    @item2 = Item.create!(name: 'Bat-A-Rangs', description: 'Weapons', unit_price: 500, merchant_id: @merchant_2.id)
    @item3 = Item.create!(name: 'Bat Mask', description: 'Identity Protection', unit_price: 800, merchant_id: @merchant_2.id)
    @item4 = Item.create!(name: 'Leotard', description: 'Costume', unit_price: 1850, merchant_id: @merchant_3.id)
    @item5 = Item.create!(name: 'Cape', description: 'Fully Functional', unit_price: 900, merchant_id: @merchant_4.id)
    @item6 = Item.create!(name: 'Black Makeup', description: 'Gallon Sized', unit_price: 50, merchant_id: @merchant_5.id)
    @item7 = Item.create!(name: 'Batmobile', description: 'Only one left in stock', unit_price: 1000000, merchant_id: @merchant_5.id)
    @item8 = Item.create!(name: 'Night-Vision Goggles', description: 'Required for night activities', unit_price: 15000, merchant_id: @merchant_6.id)
    @item9 = Item.create!(name: 'Bat-Cave', description: 'Bats not included', unit_price: 10000000, merchant_id: @merchant_6.id)

    InvoiceItem.create!(quantity: 5, unit_price: 500, status: 'packaged', item_id: @item1.id, invoice_id: @invoice1.id)
    InvoiceItem.create!(quantity: 1, unit_price: 100, status: 'shipped', item_id: @item1.id, invoice_id: @invoice2.id)
    InvoiceItem.create!(quantity: 6, unit_price: 600, status: 'pending', item_id: @item1.id, invoice_id: @invoice3.id)
    InvoiceItem.create!(quantity: 12, unit_price: 1200, status: 'packaged', item_id: @item1.id, invoice_id: @invoice4.id)
    InvoiceItem.create!(quantity: 8, unit_price: 800, status: 'packaged', item_id: @item1.id, invoice_id: @invoice5.id)
    InvoiceItem.create!(quantity: 20, unit_price: 2000, status: 'packaged', item_id: @item1.id, invoice_id: @invoice6.id)
    InvoiceItem.create!(quantity: 15, unit_price: 1500, status: 'shipped', item_id: @item1.id, invoice_id: @invoice9.id)
    InvoiceItem.create!(quantity: 15, unit_price: 1500, status: 'shipped', item_id: @item1.id, invoice_id: @invoice10.id)
    InvoiceItem.create!(quantity: 15, unit_price: 1500, status: 'shipped', item_id: @item1.id, invoice_id: @invoice11.id)

    InvoiceItem.create!(quantity: 50, unit_price: 5000, status: 'shipped', item_id: @item2.id, invoice_id: @invoice7.id)
    InvoiceItem.create!(quantity: 15, unit_price: 1500, status: 'shipped', item_id: @item2.id, invoice_id: @invoice8.id)

    InvoiceItem.create!(quantity: 15, unit_price: 1500, status: 'shipped', item_id: @item3.id, invoice_id: @invoice11.id)
    InvoiceItem.create!(quantity: 15, unit_price: 1500, status: 'shipped', item_id: @item3.id, invoice_id: @invoice11.id)
    InvoiceItem.create!(quantity: 15, unit_price: 1500, status: 'shipped', item_id: @item3.id, invoice_id: @invoice11.id)

    InvoiceItem.create!(quantity: 15, unit_price: 1500, status: 'shipped', item_id: @item4.id, invoice_id: @invoice11.id)
    InvoiceItem.create!(quantity: 15, unit_price: 1500, status: 'shipped', item_id: @item4.id, invoice_id: @invoice11.id)
    InvoiceItem.create!(quantity: 15, unit_price: 1500, status: 'shipped', item_id: @item4.id, invoice_id: @invoice11.id)

    InvoiceItem.create!(quantity: 15, unit_price: 1500, status: 'shipped', item_id: @item5.id, invoice_id: @invoice11.id)

    InvoiceItem.create!(quantity: 30, unit_price: 1500, status: 'shipped', item_id: @item6.id, invoice_id: @invoice11.id)
    InvoiceItem.create!(quantity: 15, unit_price: 1500, status: 'shipped', item_id: @item6.id, invoice_id: @invoice11.id)
    InvoiceItem.create!(quantity: 15, unit_price: 1500, status: 'shipped', item_id: @item6.id, invoice_id: @invoice11.id)

    InvoiceItem.create!(quantity: 15, unit_price: 1500, status: 'shipped', item_id: @item7.id, invoice_id: @invoice11.id)
    InvoiceItem.create!(quantity: 5, unit_price: 1500, status: 'shipped', item_id: @item7.id, invoice_id: @invoice11.id)

    InvoiceItem.create!(quantity: 10, unit_price: 100, status: 'shipped', item_id: @item8.id, invoice_id: @invoice11.id)
    InvoiceItem.create!(quantity: 15, unit_price: 100, status: 'shipped', item_id: @item8.id, invoice_id: @invoice11.id)
    
    InvoiceItem.create!(quantity: 11, unit_price: 1350, status: 'shipped', item_id: @item9.id, invoice_id: @invoice11.id)
    InvoiceItem.create!(quantity: 4, unit_price: 1350, status: 'shipped', item_id: @item9.id, invoice_id: @invoice11.id)

    @transaction1 = Transaction.create!(credit_card_number: '4801647818676136', credit_card_expiration_date: nil, result: 'failed', invoice_id: @invoice1.id)
    @transaction2 = Transaction.create!(credit_card_number: '4654405418249632', credit_card_expiration_date: nil, result: 'success', invoice_id: @invoice1.id)
    @transaction3 = Transaction.create!(credit_card_number: '4800749911485986', credit_card_expiration_date: nil, result: 'success', invoice_id: @invoice2.id)
    @transaction4 = Transaction.create!(credit_card_number: '4923661117104166', credit_card_expiration_date: nil, result: 'success', invoice_id: @invoice3.id)
    @transaction5 = Transaction.create!(credit_card_number: '4536896899874279', credit_card_expiration_date: nil, result: 'failed', invoice_id: @invoice4.id)
    @transaction6 = Transaction.create!(credit_card_number: '4536896899874280', credit_card_expiration_date: nil, result: 'failed', invoice_id: @invoice4.id)
    @transaction7 = Transaction.create!(credit_card_number: '4536896899874281', credit_card_expiration_date: nil, result: 'success', invoice_id: @invoice5.id)
    @transaction8 = Transaction.create!(credit_card_number: '4536896899874286', credit_card_expiration_date: nil, result: 'failed', invoice_id: @invoice6.id)
    @transaction9 = Transaction.create!(credit_card_number: '4636896899874290', credit_card_expiration_date: nil, result: 'success', invoice_id: @invoice6.id)
    @transaction10 = Transaction.create!(credit_card_number: '4636896899874291', credit_card_expiration_date: nil, result: 'success', invoice_id: @invoice7.id)
    @transaction11 = Transaction.create!(credit_card_number: '4636896899874298', credit_card_expiration_date: nil, result: 'success', invoice_id: @invoice8.id)
    @transaction12 = Transaction.create!(credit_card_number: '4636896899878732', credit_card_expiration_date: nil, result: 'success', invoice_id: @invoice9.id)
    @transaction13 = Transaction.create!(credit_card_number: '4636896899878732', credit_card_expiration_date: nil, result: 'success', invoice_id: @invoice10.id)
    @transaction14 = Transaction.create!(credit_card_number: '4636896899845752', credit_card_expiration_date: nil, result: 'success', invoice_id: @invoice11.id)
  end
  # US 24 As an admin,
  # When I visit the admin merchants index (/admin/merchants)
  # Then I see the name of each merchant in the system
  describe 'when i visit the merchant index I see a name for each merchant' do
    it 'shows the name of each merchant' do
      visit '/admin/merchants'

      expect(page).to have_content(@merchant_1.name)
      expect(page).to have_content(@merchant_2.name)
      expect(page).to have_content(@merchant_3.name)
      expect(page).to have_content(@merchant_4.name)
    end

    it "each name links to an merchants' show page" do
      visit '/admin/merchants'

      within("#disabled_merchants") do
        expect(page).to have_link(@merchant_2.name)
        expect(page).to have_link(@merchant_4.name)
      end

      within("#enabled_merchants") do
        expect(page).to have_link(@merchant_1.name)
        expect(page).to have_link(@merchant_3.name)
        expect(page).to have_link(@merchant_5.name)
        expect(page).to have_link(@merchant_6.name)
        click_on "#{@merchant_1.name}"
      end

      expect(current_path).to eq("/admin/merchants/#{@merchant_1.id}")
    end
  end

  # US 27 As an admin,
  # When I visit the admin merchants index
  # Then next to each merchant name I see a button to disable or enable that merchant.
  # When I click this button
  # Then I am redirected back to the admin merchants index
  # And I see that the merchant's status has changed
  describe 'as an admin I see a button to update a merchants status' do
    it 'has a buttons next to each merchant to enable or disable' do
      visit '/admin/merchants'

      within("#merchant-#{@merchant_1.id}") do
        expect(page).to have_content(@merchant_1.name)
        expect(page).to_not have_button('Enable')
        expect(page).to have_button('Disable')
      end

      within("#merchant-#{@merchant_2.id}") do
        expect(page).to have_content(@merchant_2.name)
        expect(page).to have_button('Enable')
        expect(page).to_not have_button('Disable')
      end

      within("#merchant-#{@merchant_3.id}") do
        expect(page).to have_content(@merchant_3.name)
        expect(page).to_not have_button('Enable')
        expect(page).to have_button('Disable')
      end

      within("#merchant-#{@merchant_4.id}") do
        expect(page).to have_content(@merchant_4.name)
        expect(page).to have_button('Enable')
        expect(page).to_not have_button('Disable')
      end
    end

    it 'can disable a merchant by clicking disable button' do
      visit '/admin/merchants'

      within("#merchant-#{@merchant_1.id}") do
        expect(page).to have_content(@merchant_1.name)
        expect(page).to_not have_button('Enable')
        expect(page).to have_button('Disable')

        click_button 'Disable'
        expect(current_path).to eq('/admin/merchants')
        expect(page).to have_button('Enable')
        expect(page).to_not have_button('Disable')
      end

      within("#merchant-#{@merchant_2.id}") do
        expect(page).to have_content(@merchant_2.name)
        expect(page).to have_button('Enable')
        expect(page).to_not have_button('Disable')
      end

      within("#merchant-#{@merchant_3.id}") do
        expect(page).to have_content(@merchant_3.name)
        expect(page).to_not have_button('Enable')
        expect(page).to have_button('Disable')
      end

      within("#merchant-#{@merchant_4.id}") do
        expect(page).to have_content(@merchant_4.name)
        expect(page).to have_button('Enable')
        expect(page).to_not have_button('Disable')
      end
    end

    it 'can enable a merchant by clicking enable button' do
      visit '/admin/merchants'

      within("#merchant-#{@merchant_1.id}") do
        expect(page).to have_content(@merchant_1.name)
        expect(page).to_not have_button('Enable')
        expect(page).to have_button('Disable')
      end

      within("#merchant-#{@merchant_2.id}") do
        expect(page).to have_content(@merchant_2.name)
        expect(page).to have_button('Enable')
        expect(page).to_not have_button('Disable')

        click_button 'Enable'
        expect(current_path).to eq('/admin/merchants')
        expect(page).to_not have_button('Enable')
        expect(page).to have_button('Disable')
      end

      within("#merchant-#{@merchant_3.id}") do
        expect(page).to have_content(@merchant_3.name)
        expect(page).to_not have_button('Enable')
        expect(page).to have_button('Disable')
      end

      within("#merchant-#{@merchant_4.id}") do
        expect(page).to have_content(@merchant_4.name)
        expect(page).to have_button('Enable')
        expect(page).to_not have_button('Disable')
      end
    end
  end

  describe 'top 5 merchants displayed on admin merchants index' do
    it 'displays top 5 merchants with highest total revenue based on unit_price * quantity' do 
      visit '/admin/merchants'
      
      within("#top_merchants") do
        expect("#{@merchant_2.name}").to appear_before("#{@merchant_1.name}")
        expect("#{@merchant_1.name}").to appear_before("#{@merchant_5.name}")
        expect("#{@merchant_5.name}").to appear_before("#{@merchant_3.name}")
        expect("#{@merchant_3.name}").to appear_before("#{@merchant_6.name}")
        expect(page).to_not have_content(@merchant_4)
      end
    end

    it 'has links to the show page of each top merchant' do
      visit '/admin/merchants'

      within("#top_merchants") do
        expect(page).to have_link(@merchant_1.name)
        expect(page).to have_link(@merchant_2.name)
        expect(page).to have_link(@merchant_3.name)
        expect(page).to have_link(@merchant_5.name)
        expect(page).to have_link(@merchant_6.name)
        expect(page).to_not have_link(@merchant_4.name)
      end
    end
  end
end
