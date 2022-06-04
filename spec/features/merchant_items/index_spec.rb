require 'rails_helper'

RSpec.describe 'Merchant Items Index Page' do
  let!(:merchant) { create(:merchant) }
  let!(:item) { create(:item, merchant: merchant, status: 1) }
  let!(:item2) { create(:item, merchant: merchant, status: 0) }
  let!(:item4) { create(:item, merchant: merchant, status: 1) }
  let!(:item5) { create(:item, merchant: merchant, status: 0) }
  let!(:item3) { create(:item, status: 0) }

  describe 'merchant items' do
    it 'has list of items for a specific merchant' do
      visit "/merchants/#{merchant.id}/items"
      # save_and_open_page
      expect(page).to have_content(item.name)
      expect(page).to have_content(item2.name)
      expect(page).to_not have_content(item3.name)
    end
  end

  describe 'merchant items links on index page' do
    it 'has links for the item names' do
      visit "/merchants/#{merchant.id}/items"
      within '.merchant-items-disabled' do
        click_link item2.name.to_s
      end
      expect(current_path).to eq("/merchants/#{merchant.id}/items/#{item2.id}")

      visit "/merchants/#{merchant.id}/items"
      within '.merchant-items-enabled' do
        click_link item.name.to_s
      end
      expect(current_path).to eq("/merchants/#{merchant.id}/items/#{item.id}")
    end
  end

  describe 'merchant item disable/enable' do
    it 'has a button to enable and a button to disable item' do
      visit "/merchants/#{merchant.id}/items"
      # save_and_open_page
      within '.merchant-items-enabled' do
        expect(page).to have_button('Disable')
        expect(page).to_not have_button('Enable')
      end
      within '.merchant-items-disabled' do
        expect(page).to have_button('Enable')
        expect(page).to_not have_button('Disable')
      end
    end

    it 'redirects back to items index with changed status when clicked' do
      visit "/merchants/#{merchant.id}/items"

      within '.merchant-items-enabled' do
        expect(page).to have_content(item.name)
        expect(item.status).to eq('Enabled')
        click_button(item.id.to_s)
      end
      expect(current_path).to eq("/merchants/#{merchant.id}/items")

      within '.merchant-items-enabled' do
        expect(page).to_not have_content(item.name)
        item.reload
        expect(item.status).to eq('Disabled')
      end

      within '.merchant-items-disabled' do
        expect(page).to have_content(item2.name)
        expect(item2.status).to eq('Disabled')
        click_button(item2.id.to_s)
      end
      expect(current_path).to eq("/merchants/#{merchant.id}/items")

      within '.merchant-items-disabled' do
        expect(page).to_not have_content(item2.name)
        item2.reload
        expect(item2.status).to eq('Enabled')
      end
    end

    it 'can group by status' do
      visit "/merchants/#{merchant.id}/items"

      within '.merchant-items-enabled' do
        expect(page).to have_content('Enabled Items')
        expect(page).to have_content(item.name)
        expect(page).to have_content(item4.name)
        expect(page).to_not have_content(item2.name)
        expect(page).to_not have_content(item5.name)
      end

      within '.merchant-items-disabled' do
        expect(page).to have_content('Disabled Items')
        expect(page).to have_content(item2.name)
        expect(page).to have_content(item5.name)
        expect(page).to_not have_content(item.name)
        expect(page).to_not have_content(item4.name)
      end
    end
  end

  describe 'merchant item create' do
    it 'has a link to create a new item' do
      visit "/merchants/#{merchant.id}/items"

      expect(page).to have_link('Create New Item')
    end
  end

  describe "Merchant Items Index: 5 most popular items" do
    let!(:merchant) { create(:merchant) }
    let!(:customer) { create(:customer) }
    let!(:items) { create_list(:item, 6, merchant: merchant) }
    let!(:invoices) { create_list(:invoice, 3, customer: customer) }

    let!(:transaction1) { create(:transaction, invoice: invoices[0], result: 1) }
    let!(:transaction2) { create(:transaction, invoice: invoices[0], result: 1) }
    let!(:transaction3) { create(:transaction, invoice: invoices[1], result: 0) }
    let!(:transaction4) { create(:transaction, invoice: invoices[1], result: 1) }
    let!(:transaction5) { create(:transaction, invoice: invoices[2], result: 0) }
    let!(:transaction6) { create(:transaction, invoice: invoices[2], result: 0) }

    let!(:invoice_item1) { create(:invoice_item, item: items[0], invoice: invoices[0], quantity: 42, unit_price: 500000000) }
    let!(:invoice_item2) { create(:invoice_item, item: items[1], invoice: invoices[1], quantity: 3, unit_price: 2000) }
    let!(:invoice_item3) { create(:invoice_item, item: items[2], invoice: invoices[1], quantity: 5, unit_price: 3000) }
    let!(:invoice_item4) { create(:invoice_item, item: items[3], invoice: invoices[2], quantity: 16, unit_price: 4000) }
    let!(:invoice_item5) { create(:invoice_item, item: items[4], invoice: invoices[1], quantity: 2, unit_price: 6000) }
    let!(:invoice_item6) { create(:invoice_item, item: items[5], invoice: invoices[2], quantity: 4, unit_price: 5000) }
    let!(:invoice_item7) { create(:invoice_item, item: items[0], invoice: invoices[0], quantity: 6, unit_price: 1) }
    let!(:invoice_item8) { create(:invoice_item, item: items[1], invoice: invoices[2], quantity: 22, unit_price: 2) }
    let!(:invoice_item9) { create(:invoice_item, item: items[2], invoice: invoices[2], quantity: 63, unit_price: 3) }
    let!(:invoice_item10) { create(:invoice_item, item: items[3], invoice: invoices[2], quantity: 1, unit_price: 4) }
    let!(:invoice_item11) { create(:invoice_item, item: items[4], invoice: invoices[1], quantity: 7, unit_price: 5) }
    let!(:invoice_item12) { create(:invoice_item, item: items[5], invoice: invoices[1], quantity: 9, unit_price: 6) }

    # Then I see the names of the top 5 most popular items ranked by total revenue generated
    # And I see that each item name links to my merchant item show page for that item
    # And I see the total revenue generated next to each item name
    #
    it "has the top 5 most popular items ranked by total revenue generated" do
      visit "/merchants/#{merchant.id}/items"
      save_and_open_page
      within "#rightSide2" do
        expect(page).to have_content("Top Items")
        expect(items[3].name).to appear_before(items[5].name)
        expect(items[5].name).to appear_before(items[2].name)
        expect(items[2].name).to appear_before(items[4].name)
        expect(items[4].name).to appear_before(items[1].name)
      end

      within "#topItem-#{items[1].id}" do
        expect(page).to have_link("#{items[1].name}")
        expect(page).to have_content("#{items[1].name} - $60.00 in sales")
      end

      within "#topItem-#{items[2].id}" do
        expect(page).to have_link("#{items[2].name}")
        expect(page).to have_content("#{items[2].name} - $153.00 in sales")
      end

      within "#topItem-#{items[3].id}" do
        expect(page).to have_link("#{items[3].name}")
        expect(page).to have_content("#{items[3].name} - $1,280.00 in sales")
      end

      within "#topItem-#{items[4].id}" do
        expect(page).to have_link("#{items[4].name}")
        expect(page).to have_content("#{items[4].name} - $120.00 in sales")
      end

      within "#topItem-#{items[5].id}" do
        expect(page).to have_link("#{items[5].name}")
        expect(page).to have_content("#{items[5].name} - $400.00 in sales")
        click_link "#{items[5].name}"
      end
      expect(current_path).to eq("/merchants/#{merchant.id}/items/#{items[5].id}")
    end
  end

  describe "Merchant Items Index: Top Item's Best Day" do
    let!(:merchant) { create(:merchant) }
    let!(:customer) { create(:customer) }
    let!(:items) { create_list(:item, 6, merchant: merchant) }
    # let!(:invoices) { create_list(:invoice, 3, customer: customer) }

    let!(:invoice1) { create(:invoice, customer: customer, created_at: "2012-03-10 00:54:09 UTC") }
    let!(:invoice2) { create(:invoice, customer: customer, created_at: "2012-03-10 00:54:09 UTC") }
    let!(:invoice3) { create(:invoice, customer: customer, created_at: "2022-03-10 00:54:09 UTC") }

    # let!(:transaction1) { create(:transaction, invoice: invoices[0], result: 1) }
    # let!(:transaction2) { create(:transaction, invoice: invoices[0], result: 1) }
    # let!(:transaction3) { create(:transaction, invoice: invoices[1], result: 0) }
    # let!(:transaction4) { create(:transaction, invoice: invoices[1], result: 1) }
    # let!(:transaction5) { create(:transaction, invoice: invoices[2], result: 0) }
    # let!(:transaction6) { create(:transaction, invoice: invoices[2], result: 0) }

    # let!(:invoice_item1) { create(:invoice_item, item: items[0], invoice: invoices[0], quantity: 42, unit_price: 500000000) }
    # let!(:invoice_item2) { create(:invoice_item, item: items[1], invoice: invoices[1], quantity: 3, unit_price: 2000) }
    # let!(:invoice_item3) { create(:invoice_item, item: items[2], invoice: invoices[1], quantity: 5, unit_price: 3000) }
    # let!(:invoice_item4) { create(:invoice_item, item: items[3], invoice: invoices[2], quantity: 16, unit_price: 4000) }
    # let!(:invoice_item5) { create(:invoice_item, item: items[4], invoice: invoices[1], quantity: 2, unit_price: 6000) }
    # let!(:invoice_item6) { create(:invoice_item, item: items[5], invoice: invoices[2], quantity: 4, unit_price: 5000) }
    # let!(:invoice_item7) { create(:invoice_item, item: items[0], invoice: invoices[0], quantity: 6, unit_price: 1) }
    # let!(:invoice_item8) { create(:invoice_item, item: items[1], invoice: invoices[2], quantity: 22, unit_price: 2) }
    # let!(:invoice_item9) { create(:invoice_item, item: items[2], invoice: invoices[2], quantity: 63, unit_price: 3) }
    # let!(:invoice_item10) { create(:invoice_item, item: items[3], invoice: invoices[2], quantity: 1, unit_price: 4) }
    # let!(:invoice_item11) { create(:invoice_item, item: items[4], invoice: invoices[1], quantity: 7, unit_price: 5) }
    # let!(:invoice_item12) { create(:invoice_item, item: items[5], invoice: invoices[1], quantity: 9, unit_price: 6) }

    let!(:invoice_item1) { create(:invoice_item, item: items[0], invoice: invoice1, quantity: 1, unit_price: 500000000) }
    let!(:invoice_item2) { create(:invoice_item, item: items[0], invoice: invoice2, quantity: 1, unit_price: 2000) }
    let!(:invoice_item3) { create(:invoice_item, item: items[1], invoice: invoice1, quantity: 1, unit_price: 3000) }
    let!(:invoice_item4) { create(:invoice_item, item: items[1], invoice: invoice2, quantity: 1, unit_price: 4000) }
    let!(:invoice_item5) { create(:invoice_item, item: items[2], invoice: invoice1, quantity: 1, unit_price: 6000) }
    let!(:invoice_item6) { create(:invoice_item, item: items[2], invoice: invoice3, quantity: 1, unit_price: 5000) }
    let!(:invoice_item7) { create(:invoice_item, item: items[3], invoice: invoice1, quantity: 2, unit_price: 1) }
    let!(:invoice_item8) { create(:invoice_item, item: items[3], invoice: invoice3, quantity: 1, unit_price: 2) }
    let!(:invoice_item9) { create(:invoice_item, item: items[4], invoice: invoice1, quantity: 1, unit_price: 3) }
    let!(:invoice_item10) { create(:invoice_item, item: items[4], invoice: invoice3, quantity: 2, unit_price: 4) }
    let!(:invoice_item11) { create(:invoice_item, item: items[5], invoice: invoice3, quantity: 1, unit_price: 5) }
    let!(:invoice_item12) { create(:invoice_item, item: items[5], invoice: invoice3, quantity: 1, unit_price: 6) }
    # Note: use the invoice date. If there are multiple days with equal number of sales, return the most recent day.
    it "has the date with the most sales for each item" do
      visit "/merchants/#{merchant.id}/items"

      within "#topItem-#{items[1].id}" do
        expect(page).to have_content("Top selling date for #{items[1].name} was #{invoice2.created_at}")
      end

      within "#topItem-#{items[2].id}" do
        expect(page).to have_content("Top selling date for #{items[2].name} was #{invoice3.created_at}")
      end

      within "#topItem-#{items[3].id}" do
        expect(page).to have_content("Top selling date for #{items[3].name} was #{invoice1.created_at}")
      end

      within "#topItem-#{items[4].id}" do
        expect(page).to have_content("Top selling date for #{items[4].name} was #{invoice3.created_at}")
      end

      within "#topItem-#{items[5].id}" do
        expect(page).to have_content("Top selling date for #{items[5].name} was #{invoice3.created_at}")
      end
    end
  end
end
