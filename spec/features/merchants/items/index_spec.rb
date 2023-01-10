require 'rails_helper'

RSpec.describe 'merchant items index page' do
  it 'lists all items for a merchant' do
    mariah = Merchant.create!(name: 'Mariah Ahmed')
    terry = Merchant.create!(name: 'Terry Peeples')

    pen = mariah.items.create!(name: 'pen', description: 'writes stuff', unit_price: 33)
    marker = mariah.items.create!(name: 'marker', description: 'writes stuff', unit_price: 23)
    pencil = mariah.items.create!(name: 'pencil', description: 'writes stuff', unit_price: 13)

    socks = terry.items.create!(name: 'socks', description: 'keeps feet warm', unit_price: 8)
    shoes = terry.items.create!(name: 'shoes', description: 'provides arch support', unit_price: 68)

    visit merchant_item_index_path(mariah)

    expect(page).to have_content(pen.name)
    expect(page).to have_content(marker.name)
    expect(page).to have_content(pencil.name)
    expect(page).to have_no_content(socks.name)
  end

  describe 'story 9' do
    it 'has a button to disable or enable item' do
      mariah = Merchant.create!(name: 'Mariah Ahmed')
      terry = Merchant.create!(name: 'Terry Peeples')

      pen = mariah.items.create!(name: 'pen', description: 'writes stuff', unit_price: 33)
      marker = mariah.items.create!(name: 'marker', description: 'writes stuff', unit_price: 23)
      pencil = mariah.items.create!(name: 'pencil', description: 'writes stuff', unit_price: 13)

      socks = terry.items.create!(name: 'socks', description: 'keeps feet warm', unit_price: 8)
      shoes = terry.items.create!(name: 'shoes', description: 'provides arch support', unit_price: 68)

      visit merchant_item_index_path(mariah)
      expect(page).to have_button('Enable')
    end
    it 'will take me back to the items index page when the button is clicked' do
      mariah = Merchant.create!(name: 'Mariah Ahmed')
      terry = Merchant.create!(name: 'Terry Peeples')

      pen = mariah.items.create!(name: 'pen', description: 'writes stuff', unit_price: 33)
      socks = terry.items.create!(name: 'socks', description: 'keeps feet warm', unit_price: 8)
      shoes = terry.items.create!(name: 'shoes', description: 'provides arch support', unit_price: 68)

      visit merchant_item_index_path(mariah)
      click_button 'Enable'

      expect(page).to have_current_path(merchant_item_index_path(mariah))
    end
    it 'changes the items status' do
      mariah = Merchant.create!(name: 'Mariah Ahmed')
      terry = Merchant.create!(name: 'Terry Peeples')

      pen = mariah.items.create!(name: 'pen', description: 'writes stuff', unit_price: 33)
      marker = mariah.items.create!(name: 'marker', description: 'writes stuff', unit_price: 23)
      pencil = mariah.items.create!(name: 'pencil', description: 'writes stuff', unit_price: 13)

      socks = terry.items.create!(name: 'socks', description: 'keeps feet warm', unit_price: 8)
      shoes = terry.items.create!(name: 'shoes', description: 'provides arch support', unit_price: 68)

      visit merchant_item_index_path(mariah)

      expect(pen.status).to eq(0)

      within("#item-#{pen.id}") do
        click_button 'Enable'
      end

      pen.reload

      expect(page).to have_current_path(merchant_item_index_path(mariah))
      expect(pen.status).to eq(1)
      expect(page).to have_button('Disable')
    end
  end

  describe 'merchant item create' do
    it 'creates new item with status disabled' do
      mariah = Merchant.create!(name: 'Mariah Ahmed')
      mariah.items.create!(name: 'pen', description: 'writes stuff', unit_price: 33)
      mariah.items.create!(name: 'marker', description: 'writes stuff', unit_price: 23)
      mariah.items.create!(name: 'pencil', description: 'writes stuff', unit_price: 13)

      visit merchant_item_index_path(mariah)

      click_link 'New Item'

      fill_in 'Name', with: 'gloves'
      fill_in 'Description', with: 'keeps hands warm'
      fill_in 'Unit price', with: 40

      click_button 'Submit'

      expect(current_path).to eq(merchant_item_index_path(mariah))
      expect(page).to have_content('gloves')

      gloves = Item.all.last
      expect(gloves.status).to eq(0)
    end
  end

  describe 'story 10' do
    #     As a merchant,
    # When I visit my merchant items index page
    # Then I see two sections, one for "Enabled Items" and one for "Disabled Items"
    # And I see that each Item is listed in the appropriate section

    it 'has has a section for enabled and one for disabled items' do
      mariah = Merchant.create!(name: 'Mariah Ahmed')
      terry = Merchant.create!(name: 'Terry Peeples')

      pen = mariah.items.create!(name: 'pen', description: 'writes stuff', unit_price: 33)
      marker = mariah.items.create!(name: 'marker', description: 'writes stuff', unit_price: 23)
      pencil = mariah.items.create!(name: 'pencil', description: 'writes stuff', unit_price: 13)

      socks = terry.items.create!(name: 'socks', description: 'keeps feet warm', unit_price: 8)
      shoes = terry.items.create!(name: 'shoes', description: 'provides arch support', unit_price: 68)

      visit merchant_item_index_path(mariah)

      expect(page).to have_content('Enabled')
      expect(page).to have_content('Disabled')
    end
  end

  # Then I see the names of the top 5 most popular items ranked by total revenue generated
  # And I see that each item name links to my merchant item show page for that item
  # And I see the total revenue generated next to each item name

  # before :each do
  #   FactoryBot.reload
  #   @customers = FactoryBot.create_list(:customer_with_invoice, 10)
  #   @invoices = Invoice.all
  #   FactoryBot.create_list(:transaction, 6, result: 'success', invoice_id: @invoices[0].id)
  #   FactoryBot.create_list(:transaction, 5, result: 'success', invoice_id: @invoices[3].id)
  #   FactoryBot.create_list(:transaction, 4, result: 'success', invoice_id: @invoices[1].id)
  #   FactoryBot.create_list(:transaction, 3, result: 'success', invoice_id: @invoices[4].id)
  #   FactoryBot.create_list(:transaction, 2, result: 'success', invoice_id: @invoices[2].id)
  # end
  describe '5 most popular items' do
    #     Merchant Items Index: 5 most popular items
    # As a merchant
    # When I visit my items index page
    # Then I see the names of the top 5 most popular items ranked by total revenue generated
    # And I see that each item name links to my merchant item show page for that item
    # And I see the total revenue generated next to each item name

    # Notes on Revenue Calculation:

    # Only invoices with at least one successful transaction should count towards revenue
    # Revenue for an invoice should be calculated as the sum of the revenue of all invoice items
    # Revenue for an invoice item should be calculated as the invoice item unit price multiplied by the quantity (do not use the item unit price)
    it 'shows names of top 5 most popular items ranked by total revenue generated' do
      mariah = Merchant.create!(name: 'Mariah Ahmed')
      items = FactoryBot.create_list(:item, 10, merchant_id: mariah.id)
      items.each_with_index do |item, index|
        FactoryBot.create_list(:invoice_item, 2, item_id: item.id, quantity: 1, unit_price: (index * 10))
      end
      Invoice.all.each_with_index do |invoice, _index|
        FactoryBot.create(:transaction, invoice_id: invoice.id, result: 1)
      end
      top_5 = mariah.top_5_items
      visit merchant_item_index_path(mariah)

      within('#top-5-items') do
        expect(page).to have_content(top_5.first.name)
        click_link top_5.first.name
        expect(current_path).to eq(merchant_item_path(mariah.id, top_5.first.id))
      end
      visit merchant_item_index_path(mariah)
      within('#top-5-items') do
        expect(page).to have_content(top_5.second.name)
        click_link top_5.second.name
        expect(current_path).to eq(merchant_item_path(mariah.id, top_5.second.id))
      end
      visit merchant_item_index_path(mariah)
      within('#top-5-items') do
        expect(page).to have_content(top_5.third.name)
        click_link top_5.third.name
        expect(current_path).to eq(merchant_item_path(mariah.id, top_5.third.id))
      end
      visit merchant_item_index_path(mariah)
      within('#top-5-items') do
        expect(page).to have_content(top_5.fourth.name)
        click_link top_5.fourth.name
        expect(current_path).to eq(merchant_item_path(mariah.id, top_5.fourth.id))
      end
      visit merchant_item_index_path(mariah)
      within('#top-5-items') do
        expect(page).to have_content(top_5.fifth.name)
        click_link top_5.fifth.name
        expect(current_path).to eq(merchant_item_path(mariah.id, top_5.fifth.id))
      end
    end
  end
end
