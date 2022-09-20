require "rails_helper"

RSpec.describe("the merchant items index") do
  it("I see the name of my merchant") do
    merchant1 = Merchant.create!(    name: "Bob")
    visit("/merchants/#{merchant1.id}/items")
    expect(page).to(have_content("#{merchant1.name} Items"))
  end

  it("I see all the items associated with that merchant") do
    merchant1 = Merchant.create!(    name: "Bob")
    merchant2 = Merchant.create!(    name: "Jolene")
    item1 = merchant1.items.create!(    name: "item1",     description: "this is item1 description",     unit_price: 1)
    item2 = merchant1.items.create!(    name: "item2",     description: "this is item2 description",     unit_price: 2)
    item3 = merchant1.items.create!(    name: "item3",     description: "this is item3 description",     unit_price: 3)
    item4 = merchant2.items.create!(    name: "item3",     description: "this is item4 description",     unit_price: 3)
    visit("/merchants/#{merchant1.id}/items")
    expect(page).to(have_content("item1"))
    expect(page).to(have_content("item2"))
    expect(page).to(have_content("item3"))
    expect(page).to_not(have_content("item4"))
  end

  it("directs to the merchant index page") do
    merchant1 = Merchant.create!(    name: "Bob")
    merchant2 = Merchant.create!(    name: "Jolene")
    item1 = merchant1.items.create!(    name: "item1",     description: "this is item1 description",     unit_price: 1)
    item2 = merchant1.items.create!(    name: "item2",     description: "this is item2 description",     unit_price: 2)
    item3 = merchant1.items.create!(    name: "item3",     description: "this is item3 description",     unit_price: 3)
    item4 = merchant2.items.create!(    name: "item3",     description: "this is item4 description",     unit_price: 3)
    visit("/merchants/#{merchant1.id}/items")
    click_on("#{item1.name}")
    expect(current_path).to(eq("/merchants/#{merchant1.id}/items/#{item1.id}"))
  end

  describe 'I see the names of the top 5 most popular items ranked by total revenue generated' do
    let!(:merchant_1) {create(:random_merchant)}
    let!(:merchant_2) {create(:random_merchant)}

    let!(:item_1) {create(:random_item, merchant_id: merchant_1.id)}
    let!(:item_2) {create(:random_item, merchant_id: merchant_1.id)}
    let!(:item_3) {create(:random_item, merchant_id: merchant_1.id)}
    let!(:item_4) {create(:random_item, merchant_id: merchant_1.id)}
    let!(:item_5) {create(:random_item, merchant_id: merchant_1.id)}
    let!(:item_6) {create(:random_item, merchant_id: merchant_1.id)}
    let!(:item_7) {create(:random_item, merchant_id: merchant_1.id)}
    let!(:item_8) {create(:random_item, merchant_id: merchant_1.id)}
    let!(:item_9) {create(:random_item, merchant_id: merchant_1.id)}
    let!(:item_10) {create(:random_item, merchant_id: merchant_2.id)}

    let!(:customer_1) {create(:random_customer)}
    let!(:customer_2) {create(:random_customer)}
    let!(:customer_3) {create(:random_customer)}
    let!(:customer_4) {create(:random_customer)}
  
    let!(:invoice_1) {Invoice.create!(customer_id: customer_1.id, status: 'completed', created_at: Time.new(2016, 9, 1, 12, 11, 9))}
    let!(:invoice_2) {Invoice.create!(customer_id: customer_2.id, status: 'completed', created_at: Time.new(2016, 9, 1, 12, 11, 9))}
    let!(:invoice_3) {Invoice.create!(customer_id: customer_3.id, status: 'cancelled', created_at: Time.new(2016, 9, 1, 12, 11, 9))}
    let!(:invoice_4) {Invoice.create!(customer_id: customer_4.id, status: 'completed', created_at: Time.new(2016, 9, 1, 12, 11, 9))}
    let!(:invoice_5) {Invoice.create!(customer_id: customer_4.id, status: 'completed', created_at: Time.new(2016, 9, 1, 12, 11, 9))}
    let!(:invoice_6) {Invoice.create!(customer_id: customer_4.id, status: 'completed', created_at: Time.new(2016, 9, 1, 12, 11, 9))}

    let!(:transaction_1) {Transaction.create!(invoice_id: invoice_1.id, credit_card_number: 4654405418249632, credit_card_expiration_date: '', result: 'failed')}
    let!(:transaction_2) {Transaction.create!(invoice_id: invoice_1.id, credit_card_number: 4654405418249632, credit_card_expiration_date: '', result: 'failed')}
    let!(:transaction_3) {Transaction.create!(invoice_id: invoice_2.id, credit_card_number: 4654405418249632, credit_card_expiration_date: '', result: 'success')}
    let!(:transaction_4) {Transaction.create!(invoice_id: invoice_2.id, credit_card_number: 4654405418249632, credit_card_expiration_date: '', result: 'failed')}
    let!(:transaction_5) {Transaction.create!(invoice_id: invoice_3.id, credit_card_number: 4654405418249632, credit_card_expiration_date: '', result: 'failed')}
    let!(:transaction_6) {Transaction.create!(invoice_id: invoice_3.id, credit_card_number: 4654405418249632, credit_card_expiration_date: '', result: 'success')}
    let!(:transaction_7) {Transaction.create!(invoice_id: invoice_4.id, credit_card_number: 4654405418249632, credit_card_expiration_date: '', result: 'success')}
    let!(:transaction_8) {Transaction.create!(invoice_id: invoice_5.id, credit_card_number: 4654405418249632, credit_card_expiration_date: '', result: 'success')}

    let!(:invoice_item_1) { InvoiceItem.create!(item_id: item_1.id, invoice_id: invoice_1.id, quantity: 3, unit_price: 2000, status: 'shipped') } #6000
    let!(:invoice_item_2) { InvoiceItem.create!(item_id: item_2.id, invoice_id: invoice_1.id, quantity: 3, unit_price: 2000, status: 'packaged') }#6000
    let!(:invoice_item_3) { InvoiceItem.create!(item_id: item_3.id, invoice_id: invoice_2.id, quantity: 3, unit_price: 300, status: 'shipped') }#900
    let!(:invoice_item_4) { InvoiceItem.create!(item_id: item_4.id, invoice_id: invoice_2.id, quantity: 3, unit_price: 400, status: 'pending') }#1200
    let!(:invoice_item_5) { InvoiceItem.create!(item_id: item_5.id, invoice_id: invoice_4.id, quantity: 3, unit_price: 500, status: 'pending') }#1500
    let!(:invoice_item_6) { InvoiceItem.create!(item_id: item_6.id, invoice_id: invoice_3.id, quantity: 3, unit_price: 600, status: 'pending') }#1800
    let!(:invoice_item_7) { InvoiceItem.create!(item_id: item_7.id, invoice_id: invoice_3.id, quantity: 3, unit_price: 700, status: 'pending') }#2100
    let!(:invoice_item_8) { InvoiceItem.create!(item_id: item_8.id, invoice_id: invoice_4.id, quantity: 3, unit_price: 800, status: 'pending') }#2400
    let!(:invoice_item_9) { InvoiceItem.create!(item_id: item_9.id, invoice_id: invoice_5.id, quantity: 3, unit_price: 900, status: 'pending') }#2700
    let!(:invoice_item_10) { InvoiceItem.create!(item_id: item_10.id, invoice_id: invoice_5.id, quantity: 3, unit_price: 1000, status: 'pending') }#3000

    describe 'Each item name links to the merchant item show page for that item' do
      describe 'and I see the total revenue generated next to each item name' do
        it 'displays the top 5 most popular items ranked by total revenue' do
          visit merchant_items_path(merchant_1)
          
          expect(page).to have_content("Top 5 most popular items:")
          expect('$27.0 in sales').to appear_before('$24.0 in sales')
          expect('$24.0 in sales').to appear_before('$21.0 in sales')
          expect('$21.0 in sales').to appear_before('$18.0 in sales')
          expect('$18.0 in sales').to appear_before('$15.0 in sales')
          expect('$15.0 in sales').to_not appear_before('$27.0 in sales')
          
          within "#item-#{item_9.id}" do
            expect(page).to have_link(item_9.name)
          end

          within "#item-#{item_8.id}" do
            expect(page).to have_link(item_8.name)
            expect(page).to_not have_link(item_7.name)
          end

          within "#item-#{item_7.id}" do
            expect(page).to have_link(item_7.name)
          end

          within "#item-#{item_6.id}" do
            expect(page).to have_link(item_6.name)
          end

          within "#item-#{item_5.id}" do
            expect(page).to have_link(item_5.name)
          end 
        end

        it 'links each item to the merchant item show page for that item and displays total revenue generated' do
          visit merchant_items_path(merchant_1)

          expect(page).to have_link(item_8.name)

          within "#item-#{item_8.id}" do
            click_link "#{item_8.name}"
          end

          expect(current_path).to eq("/merchants/#{merchant_1.id}/items/#{item_8.id}")

          expect(page).to have_content(item_8.name)
          expect(page).to have_content(item_8.unit_price)
        end
      end
    end

    it "I see all the items associated with that merchant, divided into enabled and disabled items" do
        merchant1 = Merchant.create!(name: "Bob")
        merchant2 = Merchant.create!(name: "Jolene")
        item1 = merchant1.items.create!(name: "item1", description: "this is item1 description", unit_price: 1)
        item2 = merchant1.items.create!(name: "item2", description: "this is item2 description", unit_price: 2)
        item3 = merchant1.items.create!(name: "item3", description: "this is item3 description", unit_price: 3)
        item4 = merchant2.items.create!(name: "item3", description: "this is item4 description", unit_price: 3)

        visit "/merchants/#{merchant1.id}/items"

        expect(page).to have_content("item1")
        expect(page).to have_content("item2")
        expect(page).to have_content("item3")
        expect(page).to_not have_content("item4")
    end

    describe "enable/disable items" do
        before(:each) do

            @merchant1 = Merchant.create!(name: "Bob")
            @merchant2 = Merchant.create!(name: "Jolene")
            @item1 = @merchant1.items.create!(name: "Crows", description: "this is item1 description", unit_price: 1)
            @item2 = @merchant1.items.create!(name: "Bees", description: "this is item2 description", unit_price: 2)
            @item3 = @merchant1.items.create!(name: "Swamp Monsters", description: "this is item3 description", unit_price: 3)
            @item4 = @merchant2.items.create!(name: "Diamonds", description: "this is item4 description", unit_price: 3)

            visit merchant_items_path(@merchant1)
        end

        it "has a button next to each item to change the enabled status of the item" do
            #add within block here
            expect(page).to have_button("Disable #{@item1.name}")
        end

        it "when I click that button, I am redirected to the merchant item index page" do
            #add within block here
            click_button("Disable #{@item1.name}")
            expect(current_path).to eq merchant_items_path(@merchant1)
        end

        it "and I see that the status of the item has changed" do
            click_button("Disable #{@item2.name}")
            expect(page).to have_button("Enable #{@item2.name}")
        end
    end
    
    describe 'Next to each of the 5 most popular items I see the date with the most sales for each item' do
      describe "I see a label 'top selling date for __ was" do
        it 'displays the date with the most sales for each most popular item' do
          visit merchant_items_path(merchant_1)
          
          expect(page).to have_content("Top day for #{item_9.name} was 9/1/16")
        end
      end
    end
  end
end


