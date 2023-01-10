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

  describe '5 most popular items' do
    it 'lists top 5 most popular items by total revenue with link to show page' do
      mariah = Merchant.create!(name: 'Mariah Ahmed')
      items = FactoryBot.create_list(:item, 10, merchant_id: mariah.id)
      items.each_with_index do |item, index|
        FactoryBot.create_list(:invoice_item, 2, item_id: item.id, quantity: 1, unit_price: (index * 10))
      end
      Invoice.all.each_with_index do |invoice, _index|
        FactoryBot.create(:transaction, invoice_id: invoice.id, result: 1)
      end

      mariah.top_5_items.each do |item|
        visit merchant_item_index_path(mariah)

        within('#top-5-items') do
          expect(page).to have_content(item.name)
          expect(page).to have_content(item.total_revenue)

          click_link item.name

          expect(current_path).to eq(merchant_item_path(mariah.id, item.id))
        end
      end
    end
  end
end
