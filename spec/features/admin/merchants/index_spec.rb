require 'rails_helper'

RSpec.describe 'Admin_Merchants Index Page' do
  it 'displays all merchant names in the system' do
    merchant = create(:merchant, name: "Willy's Bakery")
    visit "/admin/merchants"

    expect(page).to have_content("Willy's Bakery")
  end

  it "groups merchants by either diabled or enabled" do
    merchant1 = create(:merchant, name: "Matthew", status: 1)
    merchant2 = create(:merchant, name: "Mark", status: 1)
    merchant3 = create(:merchant, name: "Luke")
    merchant4 = create(:merchant, name: "John")
    visit "/admin/merchants"

    expect("Enabled Merchants:").to appear_before("Disabled Merchants:")
    expect("Enabled Merchants:").to appear_before(merchant1.name)
    expect(merchant1.name).to appear_before("Disabled Merchants:")
    expect(merchant2.name).to appear_before("Disabled Merchants:")
    expect("Disabled Merchants").to appear_before(merchant3.name)
    expect("Disabled Merchants").to appear_before(merchant4.name)
  end

  it "has a link to create a new Admin_Merchant" do
    visit "/admin/merchants"

    click_link "Create New Admin Merchant"

    expect(current_path).to eq("/admin/merchants/new")
  end

  describe 'top merchants section' do
    it "lists the top five merchants by total revenue" do
      merchant_1 = create(:merchant_with_transactions, name: 'Zach', invoice_item_quantity: 3, invoice_item_unit_price: 10)
      merchant_2 = create(:merchant_with_transactions, name: 'Abe', invoice_item_quantity: 15, invoice_item_unit_price: 100000)
      merchant_3 = create(:merchant_with_transactions, name: 'Nobody', invoice_item_quantity: 3, invoice_item_unit_price: 1)
      merchant_4 = create(:merchant_with_transactions, name: 'Jenny', invoice_item_quantity: 3, invoice_item_unit_price: 100)
      merchant_5 = create(:merchant_with_transactions, name: 'Bob', invoice_item_quantity: 3, invoice_item_unit_price: 10000)
      merchant_6 = create(:merchant_with_transactions, name: 'Charlie', invoice_item_quantity: 3, invoice_item_unit_price: 1000)

      visit "/admin/merchants"

      within "div.top_merchants" do
        expect('Abe').to appear_before('Bob')
        expect('Bob').to appear_before('Charlie')
        expect('Charlie').to appear_before('Jenny')
        expect('Jenny').to appear_before('Zach')
        expect(page).to_not have_content('Nobody')
      end
    end

    it "the name is a link to each admin merchant show page" do
      merchant_1 = create(:merchant_with_transactions, name: 'Zach', invoice_item_quantity: 3, invoice_item_unit_price: 10)

      visit "/admin/merchants"

      within "div.top_merchants" do
        click_link "Zach"
        expect(current_path).to be("/admin/merchants/#{merchant_1.id}")
      end
    end
  end
end
