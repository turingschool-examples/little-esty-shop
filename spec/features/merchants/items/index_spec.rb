require 'rails_helper'

RSpec.describe 'Merchants Item Index Page' do
  before :each do
    @merchant2 = Merchant.create!(name: 'Mary Jane')
    @wrongitem = Item.create!(name: 'upside down kiss', description: 'That Mary jane Swag', unit_price: 15000, merchant_id: @merchant2.id)

    @customer1 = Customer.create!(first_name: 'Ben', last_name: 'Franklin')
    @invoice1 = @customer1.invoices.create!(status: 0)

    @merchant1 = Merchant.create!(name: 'Tom Holland')

    @item1 = Item.create!(name: 'web shooter', description: 'saves lives', unit_price: 10_000, merchant_id: @merchant1.id)
    @item2 = Item.create!(name: 'spider suit', description: 'shoots webs', unit_price: 5000, merchant_id: @merchant1.id)
    @item3 = Item.create!(name: 'asdf', description: '3', unit_price: 7500, merchant_id: @merchant1.id)
    @item4 = Item.create!(name: 'ghjk', description: '4', unit_price: 8500, merchant_id: @merchant1.id)
    @item5 = Item.create!(name: 'qwer', description: '5', unit_price: 9764, merchant_id: @merchant1.id)
    @item6 = Item.create!(name: 'erty', description: '6', unit_price: 4257, merchant_id: @merchant1.id)
    @item7 = Item.create!(name: 'yuio', description: '7', unit_price: 4521, merchant_id: @merchant1.id)
    @item8 = Item.create!(name: 'hjkl', description: '8', unit_price: 8854, merchant_id: @merchant1.id)
    @item9 = Item.create!(name: 'tyiu', description: '9', unit_price: 4212, merchant_id: @merchant1.id)
    @item10 = Item.create!(name: 'vbnm', description: '10', unit_price: 2001, merchant_id: @merchant1.id)
    @item11 = Item.create!(name: 'cvbn', description: '11', unit_price: 4556, merchant_id: @merchant1.id)
    @item12 = Item.create!(name: 'xcvb', description: '12', unit_price: 7510, merchant_id: @merchant1.id)
    @item13 = Item.create!(name: 'zxcv', description: '13', unit_price: 15_000, merchant_id: @merchant1.id)
    @item14 = Item.create!(name: 'sdfg', description: '14', unit_price: 6900, merchant_id: @merchant1.id)
    @item15 = Item.create!(name: 'dfgh', description: '15', unit_price: 4200, merchant_id: @merchant1.id)
    @item16 = Item.create!(name: 'fghj', description: '16', unit_price: 8352, merchant_id: @merchant1.id)
    @item17 = Item.create!(name: 'ytee', description: '17', unit_price: 2540, merchant_id: @merchant1.id)
    @item18 = Item.create!(name: 'rewq', description: '18', unit_price: 1976, merchant_id: @merchant1.id)
    @item19 = Item.create!(name: 'bnbv', description: '19', unit_price: 3675, merchant_id: @merchant1.id)
    @item20 = Item.create!(name: 'poiu', description: '20', unit_price: 9764, merchant_id: @merchant1.id)

    @invoice_item1 = InvoiceItem.create!(item: @item1, invoice: @invoice1, quantity: 10, unit_price: @item1.unit_price, status: 0)
    @invoice_item2 = InvoiceItem.create!(item: @item2, invoice: @invoice1, quantity: 3, unit_price: @item2.unit_price, status: 0)
    @invoice_item3 = InvoiceItem.create!(item: @item3, invoice: @invoice1, quantity: 1, unit_price: @item3.unit_price, status: 0)
    @invoice_item4 = InvoiceItem.create!(item: @item4, invoice: @invoice1, quantity: 7, unit_price: @item4.unit_price, status: 0)
    @invoice_item5 = InvoiceItem.create!(item: @item5, invoice: @invoice1, quantity: 1, unit_price: @item5.unit_price, status: 0)
    @invoice_item6 = InvoiceItem.create!(item: @item6, invoice: @invoice1, quantity: 6, unit_price: @item6.unit_price, status: 0)
    @invoice_item7 = InvoiceItem.create!(item: @item7, invoice: @invoice1, quantity: 5, unit_price: @item7.unit_price, status: 0)
    @invoice_item8 = InvoiceItem.create!(item: @item8, invoice: @invoice1, quantity: 4, unit_price: @item8.unit_price, status: 0)
    @invoice_item9 = InvoiceItem.create!(item: @item9, invoice: @invoice1, quantity: 2, unit_price: @item9.unit_price, status: 0)
    @invoice_item10 = InvoiceItem.create!(item: @item10, invoice: @invoice1, quantity: 11, unit_price: @item10.unit_price, status: 0)
    @invoice_item11 = InvoiceItem.create!(item: @item11, invoice: @invoice1, quantity: 4, unit_price: @item11.unit_price, status: 0)
    @invoice_item12 = InvoiceItem.create!(item: @item12, invoice: @invoice1, quantity: 5, unit_price: @item12.unit_price, status: 0)
    @invoice_item13 = InvoiceItem.create!(item: @item13, invoice: @invoice1, quantity: 3, unit_price: @item13.unit_price, status: 0)
    @invoice_item14 = InvoiceItem.create!(item: @item14, invoice: @invoice1, quantity: 1, unit_price: @item14.unit_price, status: 0)
    @invoice_item15 = InvoiceItem.create!(item: @item15, invoice: @invoice1, quantity: 9, unit_price: @item15.unit_price, status: 0)
    @invoice_item16 = InvoiceItem.create!(item: @item16, invoice: @invoice1, quantity: 4, unit_price: @item16.unit_price, status: 0)
    @invoice_item17 = InvoiceItem.create!(item: @item17, invoice: @invoice1, quantity: 12, unit_price: @item17.unit_price, status: 0)
    @invoice_item18 = InvoiceItem.create!(item: @item18, invoice: @invoice1, quantity: 13, unit_price: @item18.unit_price, status: 0)
    @invoice_item19 = InvoiceItem.create!(item: @item19, invoice: @invoice1, quantity: 8, unit_price: @item19.unit_price, status: 0)
    @invoice_item20 = InvoiceItem.create!(item: @item20, invoice: @invoice1, quantity: 7, unit_price: @item20.unit_price, status: 0)

    @customer1.invoices.first.transactions.create!(credit_card_number: '1234', credit_card_expiration_date: '', result: 0)


    visit merchant_items_path(@merchant1.id)
  end

  it 'is on the correct page' do
    expect(current_path).to eq(merchant_items_path(@merchant1.id))
    expect(page).to have_content("#{@merchant1.name}'s Items")
  end

  it 'can display all of the merchants items' do
    expect(page).to have_content('Merchants Items')

    expect(page).to have_content(@item1.name)
    expect(page).to have_content(@item2.name)
    expect(page).to_not have_content(@wrongitem.name)
  end

  describe "item disable/enable" do
    before :each do
      @item4 = Item.create!(name: 'sweatpants', description: 'comfy', unit_price: 15000, merchant_id: @merchant1.id)

      visit merchant_items_path(@merchant1.id)
    end

    it "displays a button to disable or enable each item" do
      within "#merchant_item-#{@item1.id}" do
        expect(@item1.enable).to eq('enable')
        expect(page).to have_button('Disable Item')
      end
      within "#merchant_item-#{@item2.id}" do
        expect(@item1.enable).to eq('enable')
        expect(page).to have_button('Disable Item')
      end
      within "#merchant_item-#{@item4.id}" do
        expect(@item1.enable).to eq('enable')
        expect(page).to have_button('Disable Item')
      end
    end

    it "clicking enable/disable button redirects back to the index page and the updated status is displayed" do
      within "#merchant_item-#{@item1.id}" do
        expect(@item1.enable).to eq('enable')

        click_button('Disable Item')
        @item1.reload

        expect(page).to have_current_path(merchant_items_path(@merchant1.id))
        expect(@item1.enable).to eq('disable')
      end
    end
  end

  describe "create a new Item" do

    it "displays a link to 'Create a new item'" do
      expect(page).to have_link('Create a new item')
    end

    it "'Create a new item' links to the page to create a new Merchant Item" do
      click_link('Create a new item')

      expect(current_path).to eq(new_merchant_item_path(@merchant1.id))
    end
  end

  describe 'the top five items table for this merchant' do
    it 'shows the names of the top 5 most popular items' do
      within('table#top-item-table') do
        expect(page).to have_content(@item1.name)
        expect(page).to have_content(@item20.name)
        expect(page).to have_content(@item4.name)
        expect(page).to have_content(@item13.name)
        expect(page).to have_content(@item15.name)
      end
    end

    it 'orders those top 5 items by revenue generated' do
      within('table#top-item-table') do
        expect(@item1.name).to appear_before(@item20.name)
        expect(@item20.name).to appear_before(@item4.name)
        expect(@item4.name).to appear_before(@item13.name)
        expect(@item13.name).to appear_before(@item15.name)
      end
    end

    it 'has the top 5 item names as links to their merchant item show pages' do
      within('table#top-item-table') do
        expect(page).to have_link(@item1.name)
        expect(page).to have_link(@item20.name)
        expect(page).to have_link(@item4.name)
        expect(page).to have_link(@item13.name)
        expect(page).to have_link(@item15.name)
      end
    end

    it 'redirects to the merchant item show pages after you click the name links' do
      within('table#top-item-table') do
        click_on "#{@item1.name}"

        expect(current_path).to eq("/merchants/#{@merchant1.id}/items/#{@item1.id}")
      end
    end

    it 'displays the total revenue generated next to each item name' do
      within("tr#item-#{@item1.id}") do
        expect(page).to have_content("$20,000.00")
      end
      within("tr#item-#{@item20.id}") do
        expect(page).to have_content("$13,669.60")
      end
      within("tr#item-#{@item4.id}") do
        expect(page).to have_content("$11,900.00")
      end
      within("tr#item-#{@item13.id}") do
        expect(page).to have_content("$9,000.00")
      end
      within("tr#item-#{@item15.id}") do
        expect(page).to have_content("$7,560.00")
      end
    end


    it 'displays the top selling date for each item next to the item' do
      expected = @item1.created_at.to_date

      within("tr#item-#{@item1.id}") do
        expect(page).to have_content(expected)
      end
    end
  end

  describe "enabled and disabled sections" do
    it 'displays all of the enabled items' do
      merchant1 = Merchant.create!(name: 'Tom Holland')
      item1 = Item.create!(name: 'spider suit', description: 'saves lives', unit_price: 10_000, merchant_id: merchant1.id)
      item2 = Item.create!(name: 'web shooter', description: 'shoots webs', unit_price: 5000, merchant_id: merchant1.id, enable: 'disable')
      item3 = Item.create!(name: 'asdf', description: '3', unit_price: 7500, merchant_id: merchant1.id)
      item4 = Item.create!(name: 'ghjk', description: '4', unit_price: 8500, merchant_id: merchant1.id, enable: 'disable')
      item5 = Item.create!(name: 'qwer', description: '5', unit_price: 9764, merchant_id: merchant1.id)

      visit merchant_items_path(merchant1.id)

      within "#enabled" do
        expect(page).to have_content(item1.name)
        expect(page).to have_content(item3.name)
        expect(page).to have_content(item5.name)
        expect(page).to_not have_content(item2.name)
        expect(page).to_not have_content(item4.name)
      end
    end

    it 'displays all of the disabled items' do
      merchant1 = Merchant.create!(name: 'Tom Holland')
      item1 = Item.create!(name: 'spider suit', description: 'saves lives', unit_price: 10_000, merchant_id: merchant1.id)
      item2 = Item.create!(name: 'web shooter', description: 'shoots webs', unit_price: 5000, merchant_id: merchant1.id, enable: 'disable')
      item3 = Item.create!(name: 'asdf', description: '3', unit_price: 7500, merchant_id: merchant1.id)
      item4 = Item.create!(name: 'ghjk', description: '4', unit_price: 8500, merchant_id: merchant1.id, enable: 'disable')
      item5 = Item.create!(name: 'qwer', description: '5', unit_price: 9764, merchant_id: merchant1.id)

      visit merchant_items_path(merchant1.id)

      within "#disabled" do
        expect(page).to have_content(item2.name)
        expect(page).to have_content(item4.name)
        expect(page).to_not have_content(item1.name)
        expect(page).to_not have_content(item3.name)
        expect(page).to_not have_content(item5.name)
      end
    end
  end

  describe 'Active Record extention 1' do
    it 'can sort items by name and updated date' do
      within('#all-item-table') do
        expect(@item1.name).to appear_before(@item2.name)
        expect(@item2.name).to appear_before(@item3.name)

        click_on "Sort Alphabetically"
      end

      within('#all-item-table') do
        expect(current_path).to eq(merchant_items_path(@merchant1.id))

        expect(@item3.name).to appear_before(@item2.name)
        expect(@item2.name).to appear_before(@item1.name)

        @item1.update(name: 'Dom Tolland')
        click_on "Sort by Updated Date"
      end

      within('#all-item-table') do

        expect(current_path).to eq(merchant_items_path(@merchant1.id))
        expect(@item1.name).to appear_before(@item2.name)
      end
    end
  end
end
