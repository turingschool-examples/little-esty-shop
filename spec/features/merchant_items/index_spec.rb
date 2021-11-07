require 'rails_helper'
FactoryBot.find_definitions

RSpec.describe 'Merchant Items Index' do
  before :each do
    @merchant = create(:merchant)

    @item_1 = create(:item, merchant: @merchant)
    @item_2 = create(:item, merchant: @merchant)
    @item_3 = create(:item, merchant: @merchant)
    @item_4 = create(:item, merchant: @merchant)
    @item_5 = create(:item, merchant: @merchant)
    @item_6 = create(:item, merchant: @merchant)

    @invoice = create(:invoice)

    @transaction = create(:transaction, result: 'success', invoice: @invoice)

    @invitem_1 = create(:invoice_item, quantity: 10, unit_price: 1, invoice: @invoice, item: @item_1)
    @invitem_2 = create(:invoice_item, quantity: 10, unit_price: 2, invoice: @invoice, item: @item_2)
    @invitem_3 = create(:invoice_item, quantity: 10, unit_price: 3, invoice: @invoice, item: @item_3)
    @invitem_4 = create(:invoice_item, quantity: 10, unit_price: 4, invoice: @invoice, item: @item_4)
    @invitem_5 = create(:invoice_item, quantity: 10, unit_price: 5, invoice: @invoice, item: @item_5)
    @invitem_6 = create(:invoice_item, quantity: 10, unit_price: 6, invoice: @invoice, item: @item_6)
  end

  it 'lists the names of all the items' do

    visit "/merchants/#{@merchant.id}/items"

    expect(page).to have_content(@item_1.name)
    expect(page).to have_content(@item_2.name)

  end

  it 'links to items show page' do

    visit "/merchants/#{@merchant.id}/items"

    within('#item-0') do
      click_link
      expect(current_path).to eq("/merchants/#{@merchant.id}/items/#{@item_1.id}")
    end
  end

  it 'can create a new item' do
    visit "/merchants/#{@merchant.id}/items"

    click_link('Create New Item')

    expect(current_path).to eq("/merchants/#{@merchant.id}/items/new")

    fill_in 'name', with: "bob the skull"
    fill_in 'description', with: "a witty skull"
    fill_in 'unit_price', with: "100"

    click_button

    expect(page).to have_content 'bob the skull'
  end

  it 'can enable/disable an item' do
    visit "/merchants/#{@merchant.id}/items"

    within('#disabled-items') do
      expect(page).to_not have_button('Disable')

      within('#item-0') do
        click_on('Enable')
      end
    end

    within('#enabled-items') do
      expect(page).to_not have_button('Enable')

      within('#item-0') do
        click_on('Disable')
      end
    end
  end

  it 'lists the top five items' do
    visit "/merchants/#{@merchant.id}/items"

    within('#top_five_items') do
      expect(page).to have_content(@item_6.name)
      expect(page).to have_content(@item_5.name)
      expect(page).to have_content(@item_4.name)
      expect(page).to have_content(@item_3.name)
      expect(page).to have_content(@item_2.name)

      expect(page).to_not have_content(@item_1.name)

      expect(@item_6.name).to appear_before(@item_5.name)
    end
  end
end
