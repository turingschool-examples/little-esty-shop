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
    let!(:merchant1) { create(:merchant) }

    let!(:item1) { create(:item, merchant: merchant1) }
    let!(:item2) { create(:item, merchant: merchant1) }
    let!(:item3) { create(:item, merchant: merchant1) }
    let!(:item4) { create(:item, merchant: merchant1) }
    let!(:item5) { create(:item, merchant: merchant1) }
    let!(:item6) { create(:item, merchant: merchant1) }

    let!(:customer1) { create(:customer) }

    let!(:invoice1) { create(:invoice, customer: customer1) } #no success
    let!(:invoice2) { create(:invoice, customer: customer1) } #one success
    let!(:invoice3) { create(:invoice, customer: customer1) } #successful

    let!(:transaction1) { create(:transaction, invoice: invoice1, result: 1) }
    let!(:transaction2) { create(:transaction, invoice: invoice1, result: 1) }
    let!(:transaction3) { create(:transaction, invoice: invoice2, result: 0) }
    let!(:transaction4) { create(:transaction, invoice: invoice2, result: 1) }
    let!(:transaction5) { create(:transaction, invoice: invoice3, result: 0) }
    let!(:transaction6) { create(:transaction, invoice: invoice3, result: 0) }

    let!(:invoice_item1) { create(:invoice_item, item: item1, invoice: invoice1, unit_price: 500000000) }
    let!(:invoice_item2) { create(:invoice_item, item: item2, invoice: invoice2, unit_price: 2000) }
    let!(:invoice_item3) { create(:invoice_item, item: item3, invoice: invoice2, unit_price: 3000) }
    let!(:invoice_item4) { create(:invoice_item, item: item4, invoice: invoice3, unit_price: 4000) }
    let!(:invoice_item5) { create(:invoice_item, item: item5, invoice: invoice2, unit_price: 6000) }
    let!(:invoice_item6) { create(:invoice_item, item: item6, invoice: invoice3, unit_price: 5000) }
    let!(:invoice_item7) { create(:invoice_item, item: item1, invoice: invoice1, unit_price: 1) }
    let!(:invoice_item8) { create(:invoice_item, item: item2, invoice: invoice3, unit_price: 2) }
    let!(:invoice_item9) { create(:invoice_item, item: item3, invoice: invoice3, unit_price: 3) }
    let!(:invoice_item10) { create(:invoice_item, item: item4, invoice: invoice3, unit_price: 4) }
    let!(:invoice_item11) { create(:invoice_item, item: item5, invoice: invoice2, unit_price: 5) }
    let!(:invoice_item12) { create(:invoice_item, item: item6, invoice: invoice2, unit_price: 6) }

    # Then I see the names of the top 5 most popular items ranked by total revenue generated
    # And I see that each item name links to my merchant item show page for that item
    # And I see the total revenue generated next to each item name
    #
    # Notes on Revenue Calculation:
    # - Only invoices with at least one successful transaction should count towards revenue
    # - Revenue for an invoice should be calculated as the sum of the revenue of all invoice items
    # - Revenue for an invoice item should be calculated as the invoice item unit price multiplied by the quantity (do not use the item unit price)
    it "has the top 5 most popular items ranked by total revenue generated" do
      visit "/merchants/#{merchant.id}/items"

      within "#topItems" do
        expect(page).to have_content("Top Items")

        expect(item5.name).to appear_before(item6.name)
        expect(item6.name).to appear_before(item4.name)
        expect(item4.name).to appear_before(item3.name)
        expect(item3.name).to appear_before(item2.name)

        expect(item5.name).to have_link("#{item5.name}")
        expect(item5.name).to have_link("#{item6.name}")
        expect(item5.name).to have_link("#{item4.name}")
        expect(item5.name).to have_link("#{item3.name}")
        expect(item5.name).to have_link("#{item2.name}")

        expect(page).to have_content("#{item5.name} - #{item5.total_revenue} in sales")
        expect(page).to have_content("#{item6.name} - #{item6.total_revenue} in sales")
        expect(page).to have_content("#{item4.name} - #{item4.total_revenue} in sales")
        expect(page).to have_content("#{item3.name} - #{item3.total_revenue} in sales")
        expect(page).to have_content("#{item2.name} - #{item2.total_revenue} in sales")
        # need to create a method for Item#total_revenue here...
        # also thinking we can create a method called Item.top_5_by_revenue or something...
        # like that and it could use the total_revenue method (or at least the logic)

        click_link "#{item5.name}"
      end

      expect(current_path).to eq("/merchants/#{merchant.id}/items/#{item5.id}")
    end
  end
end