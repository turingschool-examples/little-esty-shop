require 'rails_helper'

RSpec.describe 'Admin Merchants Index Page', type: :feature do

    it 'can list the name of each merchant in the system' do
      merchant1 = Merchant.create!(name: "Poke Retirement homes",status: "enabled")
      merchant2 = Merchant.create!(name: "Rendolyn Guiz's poke stops", status: "enabled")
      merchant3 = Merchant.create!(name: "Dhirley Secasrio's knits and bits", status: "disabled")
      merchant4 = Merchant.create!(name: "Eandace Ceckels toys'R'us", status: "disabled")
      merchant5 = Merchant.create!(name: "Tarker Phomson manga emporium", status: "enabled")
      merchant6 = Merchant.create!(name: "Mlex Aora rods and reels", status: "disabled")

      visit '/admin/merchants'

      expect(page).to have_content("Poke Retirement homes")
      expect(page).to have_content("Rendolyn Guiz's poke stops")
      expect(page).to have_content("Dhirley Secasrio's knits and bits")
      expect(page).to have_content("Eandace Ceckels toys'R'us")
      expect(page).to have_content("Tarker Phomson manga emporium")
      expect(page).to have_content("Mlex Aora rods and reels")
    end

    it "each merchant has a button to disable or enable the merchant" do
      merchant1 = Merchant.create!(name: "Poke Retirement homes", status: "enabled")
      merchant2 = Merchant.create!(name: "Rendolyn Guiz's poke stops", status: "enabled")
      merchant3 = Merchant.create!(name: "Dhirley Secasrio's knits and bits", status: "disabled")
      merchant4 = Merchant.create!(name: "Eandace Ceckels toys'R'us", status: "disabled")

      visit '/admin/merchants'

      within "div#merchant-#{merchant1.id}" do
        expect(page).to have_content("Poke Retirement homes")
        expect(page).to have_content("Status: enabled")
        expect(page).to have_button('Enable/Disable')
        click_button('Enable/Disable')
        expect(current_path).to eq('/admin/merchants')
        expect(page).to have_content("Status: disabled")
      end

      visit "/admin/merchants"

      within "div#merchant-#{merchant2.id}" do
        expect(page).to have_content("Rendolyn Guiz's poke stops")
        expect(page).to have_content("Status: enabled")
        expect(page).to have_button('Enable/Disable')
        click_button('Enable/Disable')
        expect(current_path).to eq('/admin/merchants')
        expect(page).to have_content("Status: disabled")
      end

      visit "/admin/merchants"

      within "div#merchant-#{merchant3.id}" do
        expect(page).to have_content("Dhirley Secasrio's knits and bits")
        expect(page).to have_content("Status: disabled")
        expect(page).to have_button('Enable/Disable')
        click_button('Enable/Disable')
        expect(current_path).to eq('/admin/merchants')
        expect(page).to have_content("Status: enabled")
      end

       within "div#merchant-#{merchant4.id}" do
        expect(page).to have_content("Eandace Ceckels toys'R'us")
        expect(page).to have_content("Status: disabled")
        expect(page).to have_button('Enable/Disable')
        click_button('Enable/Disable')
        expect(current_path).to eq('/admin/merchants')
        expect(page).to have_content("Status: enabled")
      end
    end

  it "can group merchants into disabled/enabled section based on status" do
    merchant1 = Merchant.create!(name: "Poke Retirement homes", status: "disabled")
    merchant2 = Merchant.create!(name: "Rendolyn Guiz's poke stops", status: "disabled")
    merchant3 = Merchant.create!(name: "Dhirley Secasrio's knits and bits", status: "disabled")
    merchant4 = Merchant.create!(name: "Eandace Ceckels toys'R'us", status: "enabled")
    merchant5 = Merchant.create!(name: "Tarker Phomson manga emporium", status: "enabled")
    merchant6 = Merchant.create!(name: "Mlex Aora rods and reels", status: "enabled")

    visit '/admin/merchants'

    within "div#merchant-disabled" do
      expect(page).to have_content("Poke Retirement homes")
      expect(page).to have_content("Rendolyn Guiz's poke stops")
      expect(page).to have_content("Dhirley Secasrio's knits and bits")
    end

    within "div#merchant-enabled" do
      expect(page).to have_content("Eandace Ceckels toys'R'us")
      expect(page).to have_content("Tarker Phomson manga emporium")
      expect(page).to have_content("Mlex Aora rods and reels")
    end
  end

  it "can create a new merchant with a form with a disabled status" do
      merchant2 = Merchant.create!(name: "Rendolyn Guiz's poke stops", status: 'enabled')
      merchant3 = Merchant.create!(name: "Dhirley Secasrio's knits and bits", status: 'enabled')
      merchant4 = Merchant.create!(name: "Eandace Ceckels toys'R'us", status: 'enabled')
      merchant5 = Merchant.create!(name: "Tarker Phomson manga emporium", status: 'enabled')

      visit '/admin/merchants'

      expect(page).to have_content("Rendolyn Guiz's poke stops")
      expect(page).to have_content("Dhirley Secasrio's knits and bits")
      expect(page).to have_content("Eandace Ceckels toys'R'us")
      expect(page).to have_content("Tarker Phomson manga emporium")

      expect(page).to have_link('Create Merchant')
      click_on('Create Merchant')
      expect(current_path).to eq("/admin/merchants/new")

      fill_in 'name', with: 'Hai Sall'
      expect(page).to have_button('Submit')
      click_on('Submit')
      expect(current_path).to eq("/admin/merchants")

      expect(page).to have_content('Hai Sall')
      expect(page).to have_button{'disabled'}
      expect(page).to have_content("Rendolyn Guiz's poke stops")
      expect(page).to have_content("Dhirley Secasrio's knits and bits")
      expect(page).to have_content("Eandace Ceckels toys'R'us")
      expect(page).to have_content("Tarker Phomson manga emporium")
  end

  it "can show me the top 5 merchants by total revenue" do
    merchant1 = Merchant.create!(name: 'Poke pics', status: 'enabled')
    merchant2 = Merchant.create!(name: 'Daily Dungeons', status: 'enabled')
    merchant3 = Merchant.create!(name: 'One item', status: 'enabled')
    merchant4 = Merchant.create!(name: 'More than one item', status: 'enabled')
    merchant5 = Merchant.create!(name: '2 doller store', status: 'enabled')
    merchant6 = Merchant.create!(name: '5 above', status: 'enabled')
    merchant7 = Merchant.create!(name: 'Malwart', status: 'enabled')

    item1 = Item.create!(name: 'Pikachu Pics', description: 'Pics with PIKACHU', unit_price: 1500, merchant_id: merchant1.id)
    item2 = Item.create!(name: 'Pikachu Pics', description: 'Pics with PIKACHU', unit_price: 2500, merchant_id: merchant2.id)
    item3 = Item.create!(name: 'Pikachu Pics', description: 'Pics with PIKACHU', unit_price: 3500, merchant_id: merchant3.id)
    item4 = Item.create!(name: 'Pikachu Pics', description: 'Pics with PIKACHU', unit_price: 4500, merchant_id: merchant4.id)
    item5 = Item.create!(name: 'Pikachu Pics', description: 'Pics with PIKACHU', unit_price: 5500, merchant_id: merchant5.id)
    item6 = Item.create!(name: 'Pikachu Pics', description: 'Pics with PIKACHU', unit_price: 6500, merchant_id: merchant6.id)
    item7 = Item.create!(name: 'Pikachu Pics', description: 'Pics with PIKACHU', unit_price: 7500, merchant_id: merchant7.id)

    customer1 = Customer.create!(first_name: 'Beannah', last_name: 'Durke')

    invoice1 = Invoice.create!(status: 'completed', customer_id: customer1.id)
    invoice2 = Invoice.create!(status: 'completed', customer_id: customer1.id)
    invoice3 = Invoice.create!(status: 'completed', customer_id: customer1.id)
    invoice4 = Invoice.create!(status: 'completed', customer_id: customer1.id)
    invoice5 = Invoice.create!(status: 'completed', customer_id: customer1.id)
    invoice6 = Invoice.create!(status: 'completed', customer_id: customer1.id)
    invoice7 = Invoice.create!(status: 'completed', customer_id: customer1.id)

    invoice_item1 = InvoiceItem.create!(quantity: 100, unit_price: 1000, status: 'shipped', item_id: item1.id, invoice_id: invoice1.id)
    invoice_item2 = InvoiceItem.create!(quantity: 100, unit_price: 2000, status: 'shipped', item_id: item2.id, invoice_id: invoice2.id)
    invoice_item3 = InvoiceItem.create!(quantity: 100, unit_price: 3000, status: 'shipped', item_id: item3.id, invoice_id: invoice3.id)
    invoice_item4 = InvoiceItem.create!(quantity: 100, unit_price: 4000, status: 'shipped', item_id: item4.id, invoice_id: invoice4.id)
    invoice_item5 = InvoiceItem.create!(quantity: 100, unit_price: 5000, status: 'shipped', item_id: item5.id, invoice_id: invoice5.id)
    invoice_item6 = InvoiceItem.create!(quantity: 100, unit_price: 6000, status: 'shipped', item_id: item6.id, invoice_id: invoice6.id)
    invoice_item7 = InvoiceItem.create!(quantity: 100, unit_price: 7000, status: 'shipped', item_id: item7.id, invoice_id: invoice7.id)

    transaction1 = Transaction.create!(result: 'success', invoice_id: invoice1.id)
    transaction2 = Transaction.create!(result: 'success', invoice_id: invoice2.id)
    transaction3 = Transaction.create!(result: 'success', invoice_id: invoice3.id)
    transaction4 = Transaction.create!(result: 'success', invoice_id: invoice4.id)
    transaction5 = Transaction.create!(result: 'success', invoice_id: invoice5.id)
    transaction6 = Transaction.create!(result: 'success', invoice_id: invoice6.id)
    transaction7 = Transaction.create!(result: 'success', invoice_id: invoice7.id)

    visit '/admin/merchants'

    expect(page).to have_content("Top 5 Merchants by Revenue:")

    within "div#revenue" do

      expect('Malwart').to appear_before('5 above')
      expect('5 above').to appear_before('2 doller store')
      expect('2 doller store').to appear_before('More than one item')
      expect('More than one item').to appear_before('One item')
      expect('One item').to_not appear_before('Malwart')
      expect(page).to_not have_content('Daily Dungeons')
      expect(page).to_not have_content('Poke pics')
      expect(page).to have_link("#{merchant7.name}")
      expect(page).to_not have_link("#{merchant1.name}")
      click_on("#{merchant7.name}")
      expect(current_path).to eq("/admin/merchants/#{merchant7.id}")
    end
  end

  it "shows a merchants top day" do
    merchant1 = Merchant.create!(name: 'Poke pics', status: 'enabled')
    merchant2 = Merchant.create!(name: 'Daily Dungeons', status: 'enabled')
    merchant3 = Merchant.create!(name: 'One item', status: 'enabled')

    item1 = Item.create!(name: 'Pikachu Pics', description: 'Pics with PIKACHU', unit_price: 1500, merchant_id: merchant1.id)
    item2 = Item.create!(name: 'Dragontie Pics', description: 'Pics with Dragontie', unit_price: 2500, merchant_id: merchant2.id)
    item3 = Item.create!(name: 'Blastoise Pics', description: 'Pics with Blastoise', unit_price: 3500, merchant_id: merchant3.id)

    customer1 = Customer.create!(first_name: 'Beannah', last_name: 'Durke')
    customer2 = Customer.create!(first_name: 'Tarker', last_name: 'Phomson')
    customer3 = Customer.create!(first_name: 'Hai', last_name: 'Sall')
    customer4 = Customer.create!(first_name: 'Pach', last_name: 'Zrince')
    customer5 = Customer.create!(first_name: 'Fasey', last_name: 'Cazio')
    customer6 = Customer.create!(first_name: 'Rendolyn', last_name: 'Guiz')

    invoice1 = Invoice.create!(status: 'completed', customer_id: customer1.id, updated_at: Time.parse('2012-03-25 09:54:09 UTC'))
    invoice2 = Invoice.create!(status: 'completed', customer_id: customer2.id, updated_at: Time.parse('2012-04-25 09:54:09 UTC'))
    invoice3 = Invoice.create!(status: 'completed', customer_id: customer3.id, updated_at: Time.parse('2012-05-25 09:54:09 UTC'))
    invoice4 = Invoice.create!(status: 'completed', customer_id: customer4.id, updated_at: Time.parse('2012-06-25 09:54:09 UTC'))
    invoice5 = Invoice.create!(status: 'completed', customer_id: customer5.id, updated_at: Time.parse('2012-07-25 09:54:09 UTC'))
    invoice6 = Invoice.create!(status: 'completed', customer_id: customer6.id, updated_at: Time.parse('2012-08-25 09:54:09 UTC'))

    invoice_item1 = InvoiceItem.create!(quantity: 100, unit_price: 1000, status: 'shipped', item_id: item1.id, invoice_id: invoice1.id)
    invoice_item2 = InvoiceItem.create!(quantity: 100, unit_price: 2000, status: 'shipped', item_id: item1.id, invoice_id: invoice2.id)
    invoice_item3 = InvoiceItem.create!(quantity: 100, unit_price: 6000, status: 'shipped', item_id: item2.id, invoice_id: invoice3.id)
    invoice_item4 = InvoiceItem.create!(quantity: 100, unit_price: 4000, status: 'shipped', item_id: item2.id, invoice_id: invoice4.id)
    invoice_item5 = InvoiceItem.create!(quantity: 100, unit_price: 5000, status: 'shipped', item_id: item3.id, invoice_id: invoice5.id)
    invoice_item6 = InvoiceItem.create!(quantity: 100, unit_price: 5000, status: 'shipped', item_id: item3.id, invoice_id: invoice6.id)

    transaction1 = Transaction.create!(result: 'success', invoice_id: invoice1.id)
    transaction2 = Transaction.create!(result: 'success', invoice_id: invoice2.id)
    transaction3 = Transaction.create!(result: 'success', invoice_id: invoice3.id)
    transaction4 = Transaction.create!(result: 'success', invoice_id: invoice4.id)
    transaction5 = Transaction.create!(result: 'success', invoice_id: invoice5.id)
    transaction6 = Transaction.create!(result: 'success', invoice_id: invoice6.id)

    visit 'admin/merchants'

    within "div#revenue" do
      expect(page).to have_content("Top selling date for #{merchant1.name} was #{invoice2.updated_at.strftime('%B %e, %Y')}")
      expect(page).to have_content("Top selling date for #{merchant2.name} was #{invoice3.updated_at.strftime('%B %e, %Y')}")
      expect(page).to have_content("Top selling date for #{merchant3.name} was #{invoice5.updated_at.strftime('%B %e, %Y')}")
      expect('Daily Dungeons').to appear_before('One item')
      expect('One item').to appear_before('Poke pics')
      expect('Poke pics').to_not appear_before('Daily Dungeons')
    end
  end
end
