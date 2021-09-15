require 'rails_helper'

RSpec.describe 'merchants items index page' do
  describe 'enable and disable' do
    before :each do
      @merchant = Merchant.create!(name: "Steve")
      @merchant2 = Merchant.create!(name: "Kevin")
      @item1 = @merchant.items.create!(name: "Lamp", description: "Sheds light", unit_price: 5, enable: 0)
      @item2 = @merchant.items.create!(name: "Toy", description: "Played with", unit_price: 10, enable: 0)
      @item3 = @merchant.items.create!(name: "Chair", description: "Sit on it", unit_price: 50)
      @item4 = @merchant2.items.create!(name: "Table", description: "Eat on it", unit_price: 100, enable: 0)
      visit "/merchants/#{@merchant.id}/items"
    end

    it 'displays merchant item names' do
      expect(page).to have_content(@item1.name)
      expect(page).to have_content(@item2.name)
      expect(page).to have_content(@item3.name)
    end

    it 'has a link to items show page' do
      click_on "#{@item1.name}"

      expect(current_path).to eq("/merchants/#{@merchant.id}/items/#{@item1.id}")
    end

    it 'has a button for enable/disable item' do
      expect(page).to have_button("Enable")
      expect(page).to have_button("Disable")
    end

    it 'allows you to click enable' do
      within("#item-#{@item3.id}") do
        click_on "Enable"
      end

      @item3.reload
      expect(@item3.enable).to eq("enabled")
    end

    it 'allows you to click disable' do
      within("#item-#{@item2.id}") do
        click_on "Disable"
      end

      @item2.reload

      expect(current_path).to eq("/merchants/#{@merchant.id}/items/")
      expect(@item2.enable).to eq("disabled")
    end

    it 'has an enabled only section' do
      within("#enabled") do
        within("#item-#{@item2.id}") do
          expect(@item2.enable).to eq("enabled")
          expect(page).to have_content("#{@item2.name}")
          click_on "Disable"
        end
      end
    end

    it 'has an disabled only section' do
      within("#disabled") do
        within("#item-#{@item3.id}") do
          expect(@item3.enable).to eq("disabled")
          expect(page).to have_content("#{@item3.name}")
        end
      end
    end

    it 'has a link to create a new item' do
      expect(page).to have_link("Create new item")
      click_link "Create new item"
      expect(current_path).to eq("/merchants/#{@merchant.id}/items/new")
    end
  end

  describe 'most popular items' do
    before :each do
      @merch1 = create(:merchant)
      @cust1 = create(:customer)
      @cust2 = create(:customer)
      @cust3 = create(:customer)
      @cust4 = create(:customer)
      @cust5 = create(:customer)
      @cust6 = create(:customer)
      @item1 = create(:item, merchant: @merch1, unit_price: 100)
      @item2 = create(:item, merchant: @merch1, unit_price: 200)
      @item3 = create(:item, merchant: @merch1, unit_price: 500)
      @item4 = create(:item, merchant: @merch1, unit_price: 600)
      @item5 = create(:item, merchant: @merch1, unit_price: 1000)
      @item6 = create(:item, merchant: @merch1, unit_price: 2000)
      @item7 = create(:item, merchant: @merch1, unit_price: 5000)
      @invoice1 = create(:invoice, customer: @cust1)
      @invoice2 = create(:invoice, customer: @cust2)
      @invoice3 = create(:invoice, customer: @cust3)
      @invoice4 = create(:invoice, customer: @cust4)
      @invoice5 = create(:invoice, customer: @cust5)
      @invoice6 = create(:invoice, customer: @cust6)
      @invoice7 = create(:invoice, customer: @cust6)
      @invoice8 = create(:invoice, customer: @cust6)
      @invoice9 = create(:invoice, customer: @cust6)
      @invoice10 = create(:invoice, customer: @cust6)
      @invoice11 = create(:invoice, customer: @cust6)
      @invoice12 = create(:invoice, customer: @cust6)
      @invoice13 = create(:invoice, customer: @cust6)
      @invoice14 = create(:invoice, customer: @cust6)
      InvoiceItem.create(item: @item1, invoice: @invoice1, quantity: 1, unit_price: @item1.unit_price)
      InvoiceItem.create(item: @item1, invoice: @invoice2, quantity: 2, unit_price: @item1.unit_price)
      InvoiceItem.create(item: @item2, invoice: @invoice4, quantity: 4, unit_price: @item2.unit_price)
      InvoiceItem.create(item: @item2, invoice: @invoice3, quantity: 3, unit_price: @item2.unit_price)
      InvoiceItem.create(item: @item3, invoice: @invoice5, quantity: 5, unit_price: @item3.unit_price)
      InvoiceItem.create(item: @item3, invoice: @invoice6, quantity: 6, unit_price: @item3.unit_price)
      InvoiceItem.create(item: @item4, invoice: @invoice7, quantity: 7, unit_price: @item4.unit_price)
      InvoiceItem.create(item: @item4, invoice: @invoice8, quantity: 8, unit_price: @item4.unit_price)
      InvoiceItem.create(item: @item5, invoice: @invoice9, quantity: 9, unit_price: @item5.unit_price)
      InvoiceItem.create(item: @item5, invoice: @invoice10, quantity: 10, unit_price: @item5.unit_price)
      InvoiceItem.create(item: @item6, invoice: @invoice11, quantity: 11, unit_price: @item6.unit_price)
      InvoiceItem.create(item: @item6, invoice: @invoice12, quantity: 12, unit_price: @item6.unit_price)
      InvoiceItem.create(item: @item7, invoice: @invoice13, quantity: 13, unit_price: @item7.unit_price)
      InvoiceItem.create(item: @item7, invoice: @invoice14, quantity: 14, unit_price: @item7.unit_price)
      create(:transaction, invoice: @invoice1, result: 'success')
      create(:transaction, invoice: @invoice1, result: 'success')
      create(:transaction, invoice: @invoice1, result: 'success')
      create(:transaction, invoice: @invoice2, result: 'success')
      create(:transaction, invoice: @invoice2, result: 'success')
      create(:transaction, invoice: @invoice3, result: 'success')
      create(:transaction, invoice: @invoice3, result: 'success')
      create(:transaction, invoice: @invoice4, result: 'success')
      create(:transaction, invoice: @invoice4, result: 'success')
      create(:transaction, invoice: @invoice4, result: 'success')
      create(:transaction, invoice: @invoice5, result: 'success')
      create(:transaction, invoice: @invoice5, result: 'success')
      create(:transaction, invoice: @invoice6, result: 'success')
      create(:transaction, invoice: @invoice7, result: 'success')
      create(:transaction, invoice: @invoice8, result: 'success')
      create(:transaction, invoice: @invoice9, result: 'success')
      create(:transaction, invoice: @invoice10, result: 'success')
      create(:transaction, invoice: @invoice11, result: 'success')
      create(:transaction, invoice: @invoice12, result: 'success')
      create(:transaction, invoice: @invoice13, result: 'success')
      create(:transaction, invoice: @invoice14, result: 'success')
      visit "/merchants/#{@merch1.id}/items"
    end

    it 'shows the 5 most popular items on the page' do

      expect(page).to have_content("Most Popular Items")
      expect(page).to have_content(@item7.name)
      expect(page).to have_content(@item6.name)
      expect(page).to have_content(@item5.name)
      expect(page).to have_content(@item4.name)
      expect(page).to have_content(@item3.name)
    end

    it 'has links to all 5 popular items' do
      expect(page).to have_link(@item7.name)
      expect(page).to have_link(@item6.name)
      expect(page).to have_link(@item5.name)
      expect(page).to have_link(@item4.name)
      expect(page).to have_link(@item3.name)

      within("#popular-#{@item4.id}") do
        click_link "#{@item4.name}"
      end

      expect(current_path).to eq("/merchants/#{@merch1.id}/items/#{@item4.id}")
    end
  end

  describe 'top items best day' do
    before :each do
      @merch1 = create(:merchant)
      @cust1 = create(:customer)
      @cust2 = create(:customer)
      @cust3 = create(:customer)
      @cust4 = create(:customer)
      @cust5 = create(:customer)
      @cust6 = create(:customer)
      @item1 = create(:item, merchant: @merch1, unit_price: 100)
      @item2 = create(:item, merchant: @merch1, unit_price: 200)
      @item3 = create(:item, merchant: @merch1, unit_price: 500)
      @item4 = create(:item, merchant: @merch1, unit_price: 600)
      @item5 = create(:item, merchant: @merch1, unit_price: 1000)
      @item6 = create(:item, merchant: @merch1, unit_price: 2000)
      @item7 = create(:item, merchant: @merch1, unit_price: 5000)
      @invoice1 = create(:invoice, customer: @cust1, created_at: '2012-03-25 09:54:09 UTC')
      @invoice2 = create(:invoice, customer: @cust2, created_at: '2012-03-26 09:54:09 UTC')
      @invoice3 = create(:invoice, customer: @cust3, created_at: '2012-03-26 09:54:09 UTC')
      @invoice4 = create(:invoice, customer: @cust4, created_at: '2012-03-25 09:54:09 UTC')
      @invoice5 = create(:invoice, customer: @cust5, created_at: '2012-03-25 09:54:09 UTC')
      @invoice6 = create(:invoice, customer: @cust6, created_at: '2012-03-26 09:54:09 UTC')
      @invoice7 = create(:invoice, customer: @cust6, created_at: '2012-03-26 09:54:09 UTC')
      @invoice8 = create(:invoice, customer: @cust6, created_at: '2012-03-25 09:54:09 UTC')
      @invoice9 = create(:invoice, customer: @cust6, created_at: '2012-03-25 09:54:09 UTC')
      @invoice10 = create(:invoice, customer: @cust6, created_at: '2012-03-26 09:54:09 UTC')
      @invoice11 = create(:invoice, customer: @cust6, created_at: '2012-03-26 09:54:09 UTC')
      @invoice12 = create(:invoice, customer: @cust6, created_at: '2012-03-25 09:54:09 UTC')
      @invoice13 = create(:invoice, customer: @cust6, created_at: '2012-03-25 09:54:09 UTC')
      @invoice14 = create(:invoice, customer: @cust6, created_at: '2012-03-26 09:54:09 UTC')
      InvoiceItem.create(item: @item1, invoice: @invoice1, quantity: 1, unit_price: @item1.unit_price)
      InvoiceItem.create(item: @item1, invoice: @invoice2, quantity: 2, unit_price: @item1.unit_price)
      InvoiceItem.create(item: @item2, invoice: @invoice3, quantity: 3, unit_price: @item2.unit_price)
      InvoiceItem.create(item: @item2, invoice: @invoice4, quantity: 4, unit_price: @item2.unit_price)
      InvoiceItem.create(item: @item3, invoice: @invoice5, quantity: 5, unit_price: @item3.unit_price)
      InvoiceItem.create(item: @item3, invoice: @invoice6, quantity: 6, unit_price: @item3.unit_price)
      InvoiceItem.create(item: @item4, invoice: @invoice7, quantity: 7, unit_price: @item4.unit_price)
      InvoiceItem.create(item: @item4, invoice: @invoice8, quantity: 8, unit_price: @item4.unit_price)
      InvoiceItem.create(item: @item5, invoice: @invoice9, quantity: 9, unit_price: @item5.unit_price)
      InvoiceItem.create(item: @item5, invoice: @invoice10, quantity: 10, unit_price: @item5.unit_price)
      InvoiceItem.create(item: @item6, invoice: @invoice11, quantity: 11, unit_price: @item6.unit_price)
      InvoiceItem.create(item: @item6, invoice: @invoice12, quantity: 12, unit_price: @item6.unit_price)
      InvoiceItem.create(item: @item7, invoice: @invoice13, quantity: 13, unit_price: @item7.unit_price)
      InvoiceItem.create(item: @item7, invoice: @invoice14, quantity: 14, unit_price: @item7.unit_price)
      create(:transaction, invoice: @invoice1, result: 'success')
      create(:transaction, invoice: @invoice1, result: 'success')
      create(:transaction, invoice: @invoice1, result: 'success')
      create(:transaction, invoice: @invoice2, result: 'success')
      create(:transaction, invoice: @invoice2, result: 'success')
      create(:transaction, invoice: @invoice3, result: 'success')
      create(:transaction, invoice: @invoice3, result: 'success')
      create(:transaction, invoice: @invoice4, result: 'success')
      create(:transaction, invoice: @invoice4, result: 'success')
      create(:transaction, invoice: @invoice4, result: 'success')
      create(:transaction, invoice: @invoice5, result: 'success')
      create(:transaction, invoice: @invoice5, result: 'success')
      create(:transaction, invoice: @invoice6, result: 'success')
      create(:transaction, invoice: @invoice7, result: 'success')
      create(:transaction, invoice: @invoice8, result: 'success')
      create(:transaction, invoice: @invoice9, result: 'success')
      create(:transaction, invoice: @invoice10, result: 'success')
      create(:transaction, invoice: @invoice11, result: 'success')
      create(:transaction, invoice: @invoice12, result: 'success')
      create(:transaction, invoice: @invoice13, result: 'success')
      create(:transaction, invoice: @invoice14, result: 'success')
      visit "/merchants/#{@merch1.id}/items"
    end
# 7 6 5 4 3
    it 'top items best day' do
      within("#popular-#{@item1.id}") do
        save_and_open_page
        expect(page).to have_content("Top selling date for #{@item3.name} was #{@invoice6.created_at_short_format}")
      end
    end
  end
end
