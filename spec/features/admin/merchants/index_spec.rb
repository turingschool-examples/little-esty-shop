#     As an admin,
# When I visit the admin merchants index (/admin/merchants)
# Then I see the name of each merchant in the system
require 'rails_helper'

RSpec.describe 'As an admin, when I visit the admin merchant index' do

  describe "page" do
    let!(:merchant_1) { Merchant.create!(name: "Klein, Rempel and Jones")}
    let!(:merchant_2) { Merchant.create!(name: "Cummings-Thiel")}
    let!(:merchant_3) { Merchant.create!(name: "Williamson Group")}

    let!(:customer_1) { Customer.create!(first_name: 'Matt', last_name: 'Duttko') }
    let!(:customer_2) { Customer.create!(first_name: 'Jon', last_name: 'Duttko') }
    let!(:customer_3) { Customer.create!(first_name: 'Emily', last_name: 'Elder') }
    let!(:customer_4) { Customer.create!(first_name: 'Erik', last_name: 'Konner') }


    let!(:invoice_1)  { Invoice.create!(customer_id: customer_1.id, status: 'completed') }
    let!(:invoice_2)  { Invoice.create!(customer_id: customer_2.id, status: 'completed') }
    let!(:invoice_3) { Invoice.create!(customer_id: customer_3.id, status: 'completed') }
    let!(:invoice_4) { Invoice.create!(customer_id: customer_4.id, status: 'completed') }

    let!(:item_1) { Item.create!(name: 'Chicken', description: 'poulet', unit_price: 75107, merchant_id: merchant_1.id) }
    let!(:item_2) { Item.create!(name: 'Cow', description: 'vache', unit_price: 75107, merchant_id: merchant_1.id) }
    let!(:item_3) { Item.create!(name: 'Sheep', description: 'mutton', unit_price: 75107, merchant_id: merchant_1.id) }
    let!(:item_4) { Item.create!(name: 'Donkey', description: 'burro', unit_price: 75107, merchant_id: merchant_2.id) }


    let!(:invoice_item_1) { InvoiceItem.create!(item_id: item_1.id, invoice_id: invoice_1.id, quantity: 3, unit_price: 3635, status: 'shipped') }
    let!(:invoice_item_2) { InvoiceItem.create!(item_id: item_2.id, invoice_id: invoice_2.id, quantity: 31, unit_price: 13635, status: 'packaged') }
    let!(:invoice_item_3) { InvoiceItem.create!(item_id: item_3.id, invoice_id: invoice_3.id, quantity: 13, unit_price: 1335, status: 'shipped') }
    let!(:invoice_item_4) { InvoiceItem.create!(item_id: item_4.id, invoice_id: invoice_4.id, quantity: 30, unit_price: 1335, status: 'pending') }

    it 'directs to the admin merchant index page' do
      visit admin_merchants_path
      expect(current_path).to eq("/admin/merchants")
    end

    it 'displays the name of each merchant in the system' do
      visit admin_merchants_path
      expect(page).to have_content(merchant_1.name)
      expect(page).to have_content(merchant_2.name)
      expect(page).to have_content(merchant_3.name)
    end

    it 'has links to the show page for each merchant' do
      visit admin_merchants_path

      expect(page).to have_link(merchant_1.name)
      expect(page).to have_link(merchant_2.name)
      expect(page).to have_link(merchant_3.name)
    end
  end
end






