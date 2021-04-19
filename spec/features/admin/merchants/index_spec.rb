require 'rails_helper'

RSpec.describe 'admin merchants index page', type: :feature do
  it 'displays the names of each merchant as a link' do 
    merchant1 = Merchant.create!(name: "Abe")
    merchant2 = Merchant.create!(name: "Bel")
    merchant3 = Merchant.create!(name: "Cat")
    
    visit '/admin/merchants'
    
    within "#merchant-#{merchant1.id}" do
      expect(page).to have_link(merchant1.name)
    end
    within "#merchant-#{merchant2.id}" do
      expect(page).to have_link(merchant2.name)
    end
    within "#merchant-#{merchant3.id}" do
      expect(page).to have_link(merchant3.name)
    end
  end
  
  it 'has a button to disable the merchant if it is enabled, vise versa' do
    merchant1 = Merchant.create!(name: "Abe")
    merchant2 = Merchant.create!(name: "Bel", status: :enabled)
    merchant3 = Merchant.create!(name: "Cat", status: :disabled)
    
    visit '/admin/merchants'
    
    within "#merchant-#{merchant1.id}" do
      expect(page).to have_button("Disable")
      expect(page).to_not have_button("Enable")
      click_button "Disable"
      expect(current_path).to eq('/admin/merchants')
      expect(page).to have_button("Enable")
      expect(page).to_not have_button("Disable")
    end
    
    within "#merchant-#{merchant2.id}" do
      expect(page).to have_button("Disable")
      expect(page).to_not have_button("Enable")
      click_button "Disable"
      expect(current_path).to eq('/admin/merchants')
      expect(page).to have_button("Enable")
      expect(page).to_not have_button("Disable")
    end
    
    within "#merchant-#{merchant3.id}" do
      expect(page).to have_button("Enable")
      expect(page).to_not have_button("Disable")
      click_button "Enable"
      expect(current_path).to eq('/admin/merchants')
      expect(page).to have_button("Disable")
      expect(page).to_not have_button("Enable")
    end
  end

  it 'has a section for enabled merchants and a section for disabled merchants' do
    merchant1 = Merchant.create!(name: "Abe")
    merchant2 = Merchant.create!(name: "Bel", status: :enabled)
    merchant3 = Merchant.create!(name: "Cat", status: :disabled)

    visit '/admin/merchants'

    expect(page).to have_content("Enabled Merchants")
    expect(page).to have_content("Disabled Merchants")

    within("#enabled_merchants") do
      expect(page).to have_content(merchant1.name)
      expect(page).to have_content(merchant2.name)
    end

    within("#disabled_merchants") do
      expect(page).to have_content(merchant3.name)
    end
  end

  it 'has a link to create a new merchant' do
   visit '/admin/merchants'

   expect(page).to have_link("Create New Merchant") 
   click_link("Create New Merchant")
   expect(current_path).to eq("/admin/merchants/new")
  end

  describe 'top five merchants by revenue section' do
    it 'displays the top five merchants names as links' do
      customer = Customer.create!(first_name: "Very", last_name: "Rich")
      
      merchant3 = Merchant.create!(name: "CCC")
      item3 = merchant3.items.create!(name: "thing", description: "thingy", unit_price: 10)
      invoice3 = customer.invoices.create!(status: 0)
      transaction3 = invoice3.transactions.create!(credit_card_number: 1111222233334444, credit_card_expiration_date: '', result: 1)
      invoice_item7 = InvoiceItem.create!(item: item3, invoice: invoice3, quantity: 3, unit_price: 5, status: 2)
      invoice_item8 = InvoiceItem.create!(item: item3, invoice: invoice3, quantity: 3, unit_price: 5, status: 2)
      invoice_item9 = InvoiceItem.create!(item: item3, invoice: invoice3, quantity: 3, unit_price: 5, status: 2)
      
      merchant5 = Merchant.create!(name: "EEE")
      item5 = merchant5.items.create!(name: "thing", description: "thingy", unit_price: 10)
      invoice5 = customer.invoices.create!(status: 0)
      transaction5 = invoice5.transactions.create!(credit_card_number: 1111222233334444, credit_card_expiration_date: '', result: 1)
      invoice_item13 = InvoiceItem.create!(item: item5, invoice: invoice5, quantity: 5, unit_price: 5, status: 2)
      invoice_item14 = InvoiceItem.create!(item: item5, invoice: invoice5, quantity: 5, unit_price: 5, status: 2)
      invoice_item15 = InvoiceItem.create!(item: item5, invoice: invoice5, quantity: 5, unit_price: 5, status: 2)
      
      merchant1 = Merchant.create!(name: "AAA")
      item1 = merchant1.items.create!(name: "thing", description: "thingy", unit_price: 10)
      invoice1 = customer.invoices.create!(status: 0)
      transaction1 = invoice1.transactions.create!(credit_card_number: 1111222233334444, credit_card_expiration_date: '', result: 1)
      invoice_item1 = InvoiceItem.create!(item: item1, invoice: invoice1, quantity: 1, unit_price: 5, status: 2)
      invoice_item2 = InvoiceItem.create!(item: item1, invoice: invoice1, quantity: 1, unit_price: 5, status: 0)
      invoice_item3 = InvoiceItem.create!(item: item1, invoice: invoice1, quantity: 1, unit_price: 5, status: 1)
      
      merchant6 = Merchant.create!(name: "FFF")
      item6 = merchant6.items.create!(name: "thing", description: "thingy", unit_price: 10)
      invoice6 = customer.invoices.create!(status: 0)
      transaction6 = invoice6.transactions.create!(credit_card_number: 1111222233334444, credit_card_expiration_date: '', result: 0)
      invoice_item16 = InvoiceItem.create!(item: item6, invoice: invoice6, quantity: 6, unit_price: 5, status: 2)
      invoice_item17 = InvoiceItem.create!(item: item6, invoice: invoice6, quantity: 6, unit_price: 5, status: 2)
      invoice_item18 = InvoiceItem.create!(item: item6, invoice: invoice6, quantity: 6, unit_price: 5, status: 2)
      
      merchant7 = Merchant.create!(name: "GGG")
      item7 = merchant7.items.create!(name: "thing", description: "thingy", unit_price: 10)
      invoice7 = customer.invoices.create!(status: 0)
      transaction7 = invoice7.transactions.create!(credit_card_number: 1111222233334444, credit_card_expiration_date: '', result: 1)
      invoice_item19 = InvoiceItem.create!(item: item7, invoice: invoice7, quantity: 7, unit_price: 5, status: 2)
      invoice_item20 = InvoiceItem.create!(item: item7, invoice: invoice7, quantity: 7, unit_price: 5, status: 2)
      invoice_item21 = InvoiceItem.create!(item: item7, invoice: invoice7, quantity: 7, unit_price: 5, status: 2)
      
      merchant4 = Merchant.create!(name: "DDD")
      item4 = merchant4.items.create!(name: "thing", description: "thingy", unit_price: 10)
      invoice4 = customer.invoices.create!(status: 0)
      transaction4 = invoice4.transactions.create!(credit_card_number: 1111222233334444, credit_card_expiration_date: '', result: 1)
      invoice_item10 = InvoiceItem.create!(item: item4, invoice: invoice4, quantity: 4, unit_price: 5, status: 2)
      invoice_item11 = InvoiceItem.create!(item: item4, invoice: invoice4, quantity: 4, unit_price: 5, status: 2)
      invoice_item12 = InvoiceItem.create!(item: item4, invoice: invoice4, quantity: 4, unit_price: 5, status: 2)
      
      merchant2 = Merchant.create!(name: "BBB")
      item2 = merchant2.items.create!(name: "thing", description: "thingy", unit_price: 10)
      invoice2 = customer.invoices.create!(status: 0)
      transaction2 = invoice2.transactions.create!(credit_card_number: 1111222233334444, credit_card_expiration_date: '', result: 1)
      invoice_item4 = InvoiceItem.create!(item: item2, invoice: invoice2, quantity: 2, unit_price: 5, status: 2)
      invoice_item5 = InvoiceItem.create!(item: item2, invoice: invoice2, quantity: 2, unit_price: 5, status: 2)
      invoice_item6 = InvoiceItem.create!(item: item2, invoice: invoice2, quantity: 2, unit_price: 5, status: 2)

      visit '/admin/merchants'
      
      within("#top_five_by_revenue") do
        within("#top_merchant-#{merchant7.id}") do
          expect(page).to have_link(merchant7.name)
        end

        within("#top_merchant-#{merchant5.id}") do
          expect(page).to have_link(merchant5.name)
        end

        within("#top_merchant-#{merchant4.id}") do
          expect(page).to have_link(merchant4.name)
        end

        within("#top_merchant-#{merchant3.id}") do
          expect(page).to have_link(merchant3.name)
        end

        within("#top_merchant-#{merchant2.id}") do
          expect(page).to have_link(merchant2.name)
        end
      end
    end

    it 'displays the total revenue generated by each merchant' do
      customer = Customer.create!(first_name: "Very", last_name: "Rich")
      
      merchant3 = Merchant.create!(name: "CCC")
      item3 = merchant3.items.create!(name: "thing", description: "thingy", unit_price: 10)
      invoice3 = customer.invoices.create!(status: 0)
      transaction3 = invoice3.transactions.create!(credit_card_number: 1111222233334444, credit_card_expiration_date: '', result: 1)
      invoice_item7 = InvoiceItem.create!(item: item3, invoice: invoice3, quantity: 3, unit_price: 5, status: 2)
      invoice_item8 = InvoiceItem.create!(item: item3, invoice: invoice3, quantity: 3, unit_price: 5, status: 2)
      invoice_item9 = InvoiceItem.create!(item: item3, invoice: invoice3, quantity: 3, unit_price: 5, status: 2)
      
      merchant5 = Merchant.create!(name: "EEE")
      item5 = merchant5.items.create!(name: "thing", description: "thingy", unit_price: 10)
      invoice5 = customer.invoices.create!(status: 0)
      transaction5 = invoice5.transactions.create!(credit_card_number: 1111222233334444, credit_card_expiration_date: '', result: 1)
      invoice_item13 = InvoiceItem.create!(item: item5, invoice: invoice5, quantity: 5, unit_price: 5, status: 2)
      invoice_item14 = InvoiceItem.create!(item: item5, invoice: invoice5, quantity: 5, unit_price: 5, status: 2)
      invoice_item15 = InvoiceItem.create!(item: item5, invoice: invoice5, quantity: 5, unit_price: 5, status: 2)
      
      merchant1 = Merchant.create!(name: "AAA")
      item1 = merchant1.items.create!(name: "thing", description: "thingy", unit_price: 10)
      invoice1 = customer.invoices.create!(status: 0)
      transaction1 = invoice1.transactions.create!(credit_card_number: 1111222233334444, credit_card_expiration_date: '', result: 1)
      invoice_item1 = InvoiceItem.create!(item: item1, invoice: invoice1, quantity: 1, unit_price: 5, status: 2)
      invoice_item2 = InvoiceItem.create!(item: item1, invoice: invoice1, quantity: 1, unit_price: 5, status: 0)
      invoice_item3 = InvoiceItem.create!(item: item1, invoice: invoice1, quantity: 1, unit_price: 5, status: 1)
      
      merchant6 = Merchant.create!(name: "FFF")
      item6 = merchant6.items.create!(name: "thing", description: "thingy", unit_price: 10)
      invoice6 = customer.invoices.create!(status: 0)
      transaction6 = invoice6.transactions.create!(credit_card_number: 1111222233334444, credit_card_expiration_date: '', result: 0)
      invoice_item16 = InvoiceItem.create!(item: item6, invoice: invoice6, quantity: 6, unit_price: 5, status: 2)
      invoice_item17 = InvoiceItem.create!(item: item6, invoice: invoice6, quantity: 6, unit_price: 5, status: 2)
      invoice_item18 = InvoiceItem.create!(item: item6, invoice: invoice6, quantity: 6, unit_price: 5, status: 2)
      
      merchant7 = Merchant.create!(name: "GGG")
      item7 = merchant7.items.create!(name: "thing", description: "thingy", unit_price: 10)
      invoice7 = customer.invoices.create!(status: 0)
      transaction7 = invoice7.transactions.create!(credit_card_number: 1111222233334444, credit_card_expiration_date: '', result: 1)
      invoice_item19 = InvoiceItem.create!(item: item7, invoice: invoice7, quantity: 7, unit_price: 5, status: 2)
      invoice_item20 = InvoiceItem.create!(item: item7, invoice: invoice7, quantity: 7, unit_price: 5, status: 2)
      invoice_item21 = InvoiceItem.create!(item: item7, invoice: invoice7, quantity: 7, unit_price: 5, status: 2)
      
      merchant4 = Merchant.create!(name: "DDD")
      item4 = merchant4.items.create!(name: "thing", description: "thingy", unit_price: 10)
      invoice4 = customer.invoices.create!(status: 0)
      transaction4 = invoice4.transactions.create!(credit_card_number: 1111222233334444, credit_card_expiration_date: '', result: 1)
      invoice_item10 = InvoiceItem.create!(item: item4, invoice: invoice4, quantity: 4, unit_price: 5, status: 2)
      invoice_item11 = InvoiceItem.create!(item: item4, invoice: invoice4, quantity: 4, unit_price: 5, status: 2)
      invoice_item12 = InvoiceItem.create!(item: item4, invoice: invoice4, quantity: 4, unit_price: 5, status: 2)
      
      merchant2 = Merchant.create!(name: "BBB")
      item2 = merchant2.items.create!(name: "thing", description: "thingy", unit_price: 10)
      invoice2 = customer.invoices.create!(status: 0)
      transaction2 = invoice2.transactions.create!(credit_card_number: 1111222233334444, credit_card_expiration_date: '', result: 1)
      invoice_item4 = InvoiceItem.create!(item: item2, invoice: invoice2, quantity: 2, unit_price: 5, status: 2)
      invoice_item5 = InvoiceItem.create!(item: item2, invoice: invoice2, quantity: 2, unit_price: 5, status: 2)
      invoice_item6 = InvoiceItem.create!(item: item2, invoice: invoice2, quantity: 2, unit_price: 5, status: 2)

      visit '/admin/merchants'

      within("#top_five_by_revenue") do
        within("#top_merchant-#{merchant7.id}") do
          expect(page).to have_content(105)
        end

        within("#top_merchant-#{merchant5.id}") do
          expect(page).to have_content(75)
        end

        within("#top_merchant-#{merchant4.id}") do
          expect(page).to have_content(60)
        end

        within("#top_merchant-#{merchant3.id}") do
          expect(page).to have_content(45)
        end

        within("#top_merchant-#{merchant2.id}") do
          expect(page).to have_content(30)
        end
      end
    end

    it 'displays the date of the merchants top day by revenue' do
      customer = Customer.create!(first_name: "Very", last_name: "Rich")
      merchant = Merchant.create!(name: "CCC")
      item = merchant.items.create!(name: "thing", description: "thingy", unit_price: 10)
      invoice1 = customer.invoices.create!(status: 0, created_at: "2012-03-07 12:54:10 UTC")
      invoice2 = customer.invoices.create!(status: 0, created_at: "2012-03-25 09:54:09 UTC")
      invoice3 = customer.invoices.create!(status: 0, created_at: "2011-03-25 09:54:09 UTC")
      invoice_item1 = InvoiceItem.create!(item: item, invoice: invoice2, quantity: 3, unit_price: 5, status: 2)
      invoice_item2 = InvoiceItem.create!(item: item, invoice: invoice2, quantity: 3, unit_price: 5, status: 2)
      invoice_item3 = InvoiceItem.create!(item: item, invoice: invoice1, quantity: 3, unit_price: 5, status: 2)
      invoice_item4 = InvoiceItem.create!(item: item, invoice: invoice3, quantity: 3, unit_price: 50, status: 2)
      transaction1 = invoice1.transactions.create!(credit_card_number: 1111222233334444, credit_card_expiration_date: '', result: 1)
      transaction2 = invoice2.transactions.create!(credit_card_number: 1111222233334444, credit_card_expiration_date: '', result: 1)
      transaction3 = invoice3.transactions.create!(credit_card_number: 1111222233334444, credit_card_expiration_date: '', result: 0)
      
      visit '/admin/merchants'
      
      within("#top_five_by_revenue") do
        within("#top_merchant-#{merchant.id}") do
          expect(page).to have_content("03/25/12")
        end
      end
    end
  end
end