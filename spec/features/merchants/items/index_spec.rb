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
    let!(:glove) { sam.items.create!(name: "Baseball Glove", description: "This a baseball glove", unit_price: 4000, status: 1) }
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

    let!(:transaction_arugula1) { invoice_arugula.transactions.create!(result: 1) }
    let!(:transaction_tomato1) { invoice_tomato.transactions.create!(result: 0) }
    let!(:transaction_football1) { invoice_football.transactions.create!(result: 1) }
    let!(:transaction_baseball1) { invoice_baseball.transactions.create!(result: 0) }
    let!(:transaction_baseball2) { invoice_baseball.transactions.create!(result: 1) }
    let!(:transaction_glove1) { invoice_glove.transactions.create!(result: 0) }
    let!(:transaction_owl1) { invoice_owl.transactions.create!(result: 1) }
    let!(:transaction_sponge1) { invoice_sponge.transactions.create!(result: 0) }
    let!(:transaction_vinyl1) { invoice_vinyl.transactions.create!(result: 0) }
    let!(:transaction_lunchbox1) { invoice_lunchbox.transactions.create!(result: 1) }
    let!(:transaction_macguffin_muffins1) { invoice_macguffin_muffins.transactions.create!(result: 0) }

    before (:each) do 
      InvoiceItem.create!(invoice: invoice_arugula, item: arugula, quantity: 100, unit_price: 590, status: 0)            
      InvoiceItem.create!(invoice: invoice_tomato, item: tomato, quantity: 6, unit_price: 679, status: 2)               
      InvoiceItem.create!(invoice: invoice_football, item: football, quantity: 13, unit_price: 3140, status: 1)         
      InvoiceItem.create!(invoice: invoice_baseball, item: baseball, quantity: 27, unit_price: 2675, status: 0)        
      InvoiceItem.create!(invoice: invoice_glove, item: glove, quantity: 2, unit_price: 4199, status: 2)               
      InvoiceItem.create!(invoice: invoice_owl, item: owl, quantity: 50000, unit_price: 51832, status: 1)             
      InvoiceItem.create!(invoice: invoice_sponge, item: sponge, quantity: 10, unit_price: 96732, status: 0)            
      InvoiceItem.create!(invoice: invoice_vinyl, item: vinyl, quantity: 3, unit_price: 9999999, status: 2)            
      InvoiceItem.create!(invoice: invoice_lunchbox, item: lunchbox, quantity: 500, unit_price: 66666, status: 1)     
      InvoiceItem.create!(invoice: invoice_macguffin_muffins, item: macguffin_muffins, quantity: 7, unit_price: 99999, status: 0)  
      visit merchant_items_path(sam.id)
    end

    describe 'As a merchant' do 
      context 'When I visit my merchant items index page' do
        before (:each) do 
          visit merchant_items_path(sam.id)
        end

        it 'I see a list of the names of all my items' do
          expect(page).to have_content("#{sam.name}")
          expect(page).to have_content("New Item")
            
            expect(page).to have_content("#{football.name}")
            expect(page).to have_content("#{baseball.name}")
            expect(page).to have_content("#{glove.name}")
          
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

        it 'next to each item I see a button to disable or enable that item' do 
          within "div#enabled_items-#{football.id}" do
            expect(page).to have_button('Disable')
          end

          within "div#enabled_items-#{baseball.id}" do
            expect(page).to have_button('Disable')
          end

          within "div#disabled_items-#{glove.id}" do
            expect(page).to have_button('Enable')
          end
        end

        it 'changes the status of the item after the button click' do
     
          within "div#enabled_items-#{football.id}" do
            click_button 'Disable'
            football.reload
            expect(football.status).to eq('disabled')
            expect(current_path).to eq(merchant_items_path(sam))
          end
          
          within "div#enabled_items-#{baseball.id}" do
            click_button 'Disable'
            baseball.reload
            expect(baseball.status).to eq('disabled')
            expect(current_path).to eq(merchant_items_path(sam))

          end

          within "div#disabled_items-#{football.id}" do
            click_button 'Enable'
            glove.reload
            expect(glove.status).to eq('disabled')
            expect(current_path).to eq(merchant_items_path(sam))
          end
        end

        it 'displays enabled items in the enabled items section' do
         
          within "div#enabled_items-#{football.id}" do
            expect(page).to have_content(football.name)
          end

          within "div#enabled_items-#{baseball.id}" do
            expect(page).to have_content(baseball.name)
          end
        end

        it 'displays the disabled items in the disabled items section' do
          within "div#disabled_items-#{glove.id}" do
            expect(page).to have_content(glove.name)
          end
        end

        it 'displays items in correct sections after button click' do 
          within "div#enabled_items-#{football.id}" do
            expect(page).to have_content(football.name)
            click_on 'Disable'
          end

          football.reload
          
          within "div#disabled_items-#{football.id}" do
            expect(page).to have_content(football.name)
          end
        end

        it "I see a link to create a new item." do
          within('section#my_items') do
            expect(page).to have_link("New Item")
          end
        end
      end

      context 'When I visit my merchant items edit page' do
        before (:each) do 
          visit merchant_items_path(sam.id)
        end

        it "When I click on the link, I am taken to a form that allows me to add item information." do
          click_link "Create New Item"

          expect(current_path).to eq(new_merchant_item_path(sam.id))

          within ("section#new_item") do
            expect(page).to have_field("Name")
            expect(page).to have_field("Description")
            expect(page).to have_field("Unit Price")
          end
        end

        context "When I visit the Merchant Item Edit Form" do
          before (:each) do 
            visit new_merchant_item_path(sam.id)
          end

          it "When I fill out the form I click ‘Submit’ Then I am taken back to the items index page" do
            within("section#new_item") do
              fill_in "Name:", with: "Marijuana Tapestry"
              fill_in "Description", with: "Crushed velvet, 51.2 x 59.1 inches"
              fill_in "Unit Price", with: "7110"
              
              click_button "Submit"
            end
            
            expect(current_path).to eq(merchant_items_path(sam.id))
          end

          it 'when leave a form field blank, I get an error message and am returned to that Items edit page' do
            
            fill_in 'Name', with: 'Marijuana Tapestry'
            fill_in 'Description', with: ''
            fill_in 'Unit Price', with: ''
            click_button 'Submit'

            expect(current_path).to eq(new_merchant_item_path(sam.id))
            expect(page).to have_content("Description can't be blank")
            expect(page).to have_content("Unit price can't be blank")
          end
        end

        it "I see the top 5 most popular items ranked by total revenue generated" do
          within 'ul#top_list' do
            expect("#{vinyl.name}").to appear_before("#{sponge.name}")
            expect("#{sponge.name}").to appear_before("#{macguffin_muffins.name}")
            expect("#{macguffin_muffins.name}").to appear_before("#{baseball.name}")
            expect("#{baseball.name}").to appear_before("#{glove.name}")
            expect("#{glove.name}").to_not appear_before("#{baseball.name}")
          end
        end

        it "I see that each item name links to my merchant show page for said item" do
          within 'ul#top_list' do
            click_link vinyl.name
            expect(current_path).to eq(merchant_item_path(sam.id, vinyl.id))
          end

          visit merchant_items_path(sam.id)
          
          within 'ul#top_list' do
            click_link sponge.name
            expect(current_path).to eq(merchant_item_path(sam.id, sponge.id))
          end

          visit merchant_items_path(sam.id)

          within 'ul#top_list' do
            click_link macguffin_muffins.name
            expect(current_path).to eq(merchant_item_path(sam.id, macguffin_muffins.id))
          end

          visit merchant_items_path(sam.id)

          within 'ul#top_list' do
            click_link baseball.name
            expect(current_path).to eq(merchant_item_path(sam.id, baseball.id))
          end

          visit merchant_items_path(sam.id)

          within 'ul#top_list' do
            click_link glove.name
            expect(current_path).to eq(merchant_item_path(sam.id, glove.id))
          end
        end

        it "I see total revenue generate next to each item name" do
          expect(page).to have_content("$299,999.97")
          expect(page).to have_content("$9,673.20")
          expect(page).to have_content("$6,999.93")
          expect(page).to have_content("$722.25")
          expect(page).to have_content("$83.98")
        end
      end
    end
  end
end