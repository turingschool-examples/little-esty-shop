require 'rails_helper'

RSpec.describe 'Merchant Items', type: :feature do
  describe 'Merchant Items Index' do

    let!(:sam) { Merchant.create!(name: "Sam's Sports") }
    let!(:bob) { Merchant.create!(name: "Bob's Beauties") } 

    let!(:dingus) { Customer.create!(first_name: "Dingus", last_name: "Goofsshwertz") } 
    let!(:doofus) { Customer.create!(first_name: "Doofus", last_name: "Ferdinand") } 
    let!(:nkelthuraksyyll) { Customer.create!(first_name: "N'kelthuraksyyll", last_name: "The unboud, Lord of ten Thousand chains unBroken, Vanquisher of KMart") }
    let!(:phil) { Customer.create!(first_name: "Phil", last_name: "Phil") } 

    let!(:arugula) { bob.items.create!(name: "Arugula", description: "This arugula", unit_price: 500) }
    let!(:tomato) { bob.items.create!(name: "Tomato", description: "This a few Tomatos", unit_price: 700) }
    let!(:football) { sam.items.create!(name: "Football", description: "This a football", unit_price: 3000) }
    let!(:baseball) { sam.items.create!(name: "Baseball", description: "This a baseball", unit_price: 2500) }
    let!(:glove) { sam.items.create!(name: "Baseball Glove", description: "This a baseball glove", unit_price: 4000) }
    let!(:owl) { sam.items.create!(name: "Owl", description: "It eats mice. And maybe your face.", unit_price: 54999) }
    let!(:sponge) { sam.items.create!(name: "Sponge", description: "His name is Bob.", unit_price: 99) }
    let!(:vinyl) { sam.items.create!(name: "Unknown Vinyl", description: "A vinyl. Who knows what's on it?", unit_price: 999999) }
    let!(:lunchbox) { sam.items.create!(name: "Lunch Box", description: "Molded sandvich included", unit_price: 5693) }
    let!(:macguffin_muffins) { sam.items.create!(name: "The Macguffin Muffins", description: "https://youtu.be/di7DI6Q7JXA?t=39", unit_price: 99999999) }

    let!(:invoice_arugula) {Invoice.create!(customer_id: dingus.id, status: "cancelled") }
    let!(:invoice_tomato) {Invoice.create!(customer_id: dingus.id, status: "completed") }
    let!(:invoice_football) {Invoice.create!(customer_id: doofus.id) }
    let!(:invoice_baseball) {Invoice.create!(customer_id: doofus.id, status: "completed") }
    let!(:invoice_glove) {Invoice.create!(customer_id: doofus.id, status: "completed") }
    let!(:invoice_owl) {Invoice.create!(customer_id: nkelthuraksyyll.id, status: "cancelled") }
    let!(:invoice_sponge) {Invoice.create!(customer_id: nkelthuraksyyll.id, status: "completed") }
    let!(:invoice_vinyl) {Invoice.create!(customer_id: nkelthuraksyyll.id, status: "completed") }
    let!(:invoice_lunchbox) {Invoice.create!(customer_id: phil.id, status: "cancelled") }
    let!(:invoice_macguffin_muffins) {Invoice.create!(customer_id: phil.id, status: "completed") }

    before (:each) do 
      visit merchant_items_path(sam.id)
      InvoiceItem.create!(invoice: invoice_arugula, item: arugula, quantity: 100, unit_price: 590, status: 0)             #no
      InvoiceItem.create!(invoice: invoice_tomato, item: tomato, quantity: 6, unit_price: 679, status: 2)                #yes  4074
      InvoiceItem.create!(invoice: invoice_football, item: football, quantity: 13, unit_price: 3140, status: 1)         #no?
      InvoiceItem.create!(invoice: invoice_baseball, item: baseball, quantity: 27, unit_price: 2675, status: 0)         #yes   72225
      InvoiceItem.create!(invoice: invoice_glove, item: glove, quantity: 2, unit_price: 4199, status: 2)                #yes    8398
      InvoiceItem.create!(invoice: invoice_owl, item: owl, quantity: 50000, unit_price: 51832, status: 1)                #no
      InvoiceItem.create!(invoice: invoice_sponge, item: sponge, quantity: 10, unit_price: 96732, status: 0)            #yes    967320
      InvoiceItem.create!(invoice: invoice_vinyl, item: vinyl, quantity: 3, unit_price: 9999999, status: 2)             #yes    29999997
      InvoiceItem.create!(invoice: invoice_lunchbox, item: lunchbox, quantity: 500, unit_price: 66666, status: 1)       #no
      InvoiceItem.create!(invoice: invoice_macguffin_muffins, item: macguffin_muffins, quantity: 7, unit_price: 99999, status: 0)   #yes  699993
    end

    describe 'As a merchant' do 
      context 'When I visit my merchant items index page' do
        it 'I see a list of the names of all my items' do
          expect(page).to have_content("#{sam.name}")
          expect(page).to have_content("New Item")

          within 'ul#items_list' do
            expect(page).to have_content("#{football.name}")
            expect(page).to have_content("#{baseball.name}")
            expect(page).to have_content("#{glove.name}")
          end
          
          expect(page).to_not have_content("#{arugula.name}")
          expect(page).to_not have_content("#{tomato.name}")
        end

        it "each item name is a link to that merchant's item's show page " do
          within 'ul#items_list' do
            click_link football.name
            expect(current_path).to eq(merchant_item_path(sam.id, football.id))
          end
        end

        it "each item name is a link to that merchant's item's show page " do
          within 'ul#items_list' do
            click_link baseball.name
            expect(current_path).to eq(merchant_item_path(sam.id, baseball.id))
          end
        end

        it "each item name is a link to that merchant's item's show page " do
          within 'ul#items_list' do
            click_link glove.name
            expect(current_path).to eq(merchant_item_path(sam.id, glove.id))
          end
        end

        it "I see the top 5 most popular items ranked by total revenue generated" do
          expect(page).to have_content("#{vinyl.name}")
          expect(page).to have_content("#{sponge.name}")
          expect(page).to have_content("#{macguffin_muffins.name}")
          expect(page).to have_content("#{baseball.name}")
          expect(page).to have_content("#{glove.name}")
        end

        it "I see that each item name links to my merchant show page for said item" do
          click_link vinyl.name
          expect(current_path).to eq(merchant_item_path(sam.id, vinyl.id))

          click_link sponge.name
          expect(current_path).to eq(merchant_item_path(sam.id, sponge.id))

          click_link macguffin_muffins.name
          expect(current_path).to eq(merchant_item_path(sam.id, macguffin_muffins.id))

          click_link baseball.name
          expect(current_path).to eq(merchant_item_path(sam.id, baseball.id))

          click_link glove.name
          expect(current_path).to eq(merchant_item_path(sam.id, glove.id))
        end

        it "I see total revenue generate next to each item name" do
          expect(page).to have_content("#{vinyl.name} $299999.97")
          expect(page).to have_content("#{sponge.name} $9673.20")
          expect(page).to have_content("#{macguffin_muffins.name} $6999.93")
          expect(page).to have_content("#{baseball.name} $722.25")
          expect(page).to have_content("#{glove.name} $83.98")
        end
      end
    end
  end
end