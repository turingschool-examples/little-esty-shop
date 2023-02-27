require 'rails_helper'

RSpec.describe 'Admin Dashboard:', type: :feature do
  describe 'As an Admin,' do
    context 'when I visit the admin dashboard (/admin),' do
    
      let!(:moira) { Customer.create!(first_name: "Moira", last_name: "Rose") }
      let!(:alexis) { Customer.create!(first_name: "Alexis", last_name: "Rose") }
      let!(:david) { Customer.create!(first_name: "David", last_name: "Rose") }
      let!(:johnny) { Customer.create!(first_name: "Johnny", last_name: "Rose") }
      let!(:roland) { Customer.create!(first_name: "Roland", last_name: "Schitt") }
      let!(:josalyn) { Customer.create!(first_name: "Josalyn", last_name: "Schitt") }
      let!(:stevie) { Customer.create!(first_name: "Stevie", last_name: "Budd") }

      let!(:black_dress){ moira.invoices.create!(customer_id: moira.id, status: "completed") }
      let!(:black_sunglasses){ moira.invoices.create!(customer_id: moira.id, status: "completed") }
      let!(:black_feather_boa){ moira.invoices.create!(customer_id: moira.id, status: "completed") }
      let!(:obsidian_ring){ moira.invoices.create!(customer_id: moira.id, status: "completed") }

      let!(:gold_bangle){ alexis.invoices.create!(customer_id: alexis.id, status: "completed") }
      let!(:boho_dress){ alexis.invoices.create!(customer_id: alexis.id, status: "completed") }
      let!(:headband){ alexis.invoices.create!(customer_id: alexis.id, status: "completed") }

      let!(:titanium_ring){ david.invoices.create!(customer_id: david.id, status: "completed") }
      let!(:hand_cream){ david.invoices.create!(customer_id: david.id, status: "completed") }
      let!(:goat_cheese){ david.invoices.create!(customer_id: david.id, status: "completed") }

      let!(:cuff_links){ johnny.invoices.create!(customer_id: johnny.id, status: "completed") }
      let!(:tie){ johnny.invoices.create!(customer_id: johnny.id, status: "completed") }

      let!(:floral_shirt){ josalyn.invoices.create!(customer_id: josalyn.id, status: "completed") }
      let!(:kitty_statue){ josalyn.invoices.create!(customer_id: josalyn.id, status: "completed") }

      let!(:flannel_shirt){ stevie.invoices.create!(customer_id: roland.id, status: "completed") }

      let!(:fishnet_tights){ roland.invoices.create!(customer_id: roland.id, status: "cancelled") }

      before (:each) do
        Transaction.create!(invoice_id: black_dress.id, credit_card_number: 4654405418249632, credit_card_expiration_date: "09/01/2026", result: "success")
        Transaction.create!(invoice_id: black_sunglasses.id, credit_card_number: 4654405418249632, credit_card_expiration_date: "09/01/2026", result: "success")
        Transaction.create!(invoice_id: black_feather_boa.id, credit_card_number: 4654405418249632, credit_card_expiration_date: "09/01/2026", result: "success")
        Transaction.create!(invoice_id: obsidian_ring.id, credit_card_number: 4654405418249632, credit_card_expiration_date: "09/01/2026", result: "success")

        Transaction.create!(invoice_id: gold_bangle.id, credit_card_number: 45802512365152012, credit_card_expiration_date: "09/01/2026", result: "success")
        Transaction.create!(invoice_id: boho_dress.id, credit_card_number: 45802512365152012, credit_card_expiration_date: "09/01/2026", result: "success")
        Transaction.create!(invoice_id: headband.id, credit_card_number: 45802512365152012, credit_card_expiration_date: "09/01/2026", result: "success")

        Transaction.create!(invoice_id: titanium_ring.id, credit_card_number: 45802512365152012, credit_card_expiration_date: "09/01/2026", result: "success")
        Transaction.create!(invoice_id: hand_cream.id, credit_card_number: 45802512365152012, credit_card_expiration_date: "09/01/2026", result: "success")
        Transaction.create!(invoice_id: goat_cheese.id, credit_card_number: 45802512365152012, credit_card_expiration_date: "09/01/2026", result: "success")

        Transaction.create!(invoice_id: cuff_links.id, credit_card_number: 45802512365152012, credit_card_expiration_date: "09/01/2026", result: "success")
        Transaction.create!(invoice_id: tie.id, credit_card_number: 45802512365152012, credit_card_expiration_date: "09/01/2026", result: "success")

        Transaction.create!(invoice_id: floral_shirt.id, credit_card_number: 45802512365152012, credit_card_expiration_date: "09/01/2026", result: "success")
        Transaction.create!(invoice_id: kitty_statue.id, credit_card_number: 45802512365152012, credit_card_expiration_date: "09/01/2026", result: "success")

        Transaction.create!(invoice_id: flannel_shirt.id, credit_card_number: 45802512365152012, credit_card_expiration_date: "09/01/2026", result: "success")

        Transaction.create!(invoice_id: fishnet_tights.id, credit_card_number: 45802512365152012, credit_card_expiration_date: "09/01/2026", result: "failed")

        visit '/admin'
      end

      it 'I see a header indicating that I am on the admin dashboard.' do

        expect(current_path).to eq('/admin')

        within('#admin_header') do
          expect(page).to have_content("Admin Dashboard")
        end
      end

      it 'I see a link to the admin merchants index (/admin/merchants), and a link to the admin invoices index (/admin/invoices)' do

        within('#admin_nav') do
          expect(page).to have_link('Merchants')
          expect(page).to have_link('Invoices')
        end
      end

      it 'I see a section for Top Customers' do 
  
        within('section#top_customers') do 
          expect(page).to have_content("Top Customers")
        end
      end

      it 'displays names and number of purchases of the top 5 customers who have the largest number of successful transactions' do        expect(page).to have_content("Top Customers")
        within('section#top_customers') do 

          expect("Moira Rose- 4 purchases").to appear_before("Alexis Rose- 3 purchases")
          expect("Alexis Rose- 3 purchases").to appear_before("David Rose- 3 purchases")
          expect("David Rose- 3 purchases").to appear_before("Johnny Rose- 2 purchases")
          expect("Johnny Rose- 2 purchases").to appear_before("Josalyn Schitt- 2 purchases")

          expect(page).to_not have_content("Stevie Budd")
          expect(page).to_not have_content("Roland Schitt")
        end
      end

      describe "Incomplete Invoices" do
      
        before(:each) do
          merchant = Merchant.create!(name: "Cabbage Merchant")
          dis_gai_ovah_hea = Customer.create!(first_name: "Dis", last_name: "Gai")

          item1 = merchant.items.create!(name: "Ramen Noodles", description: "A dang good pack-a ramen", unit_price: 99)
          item2 = merchant.items.create!(name: "Cabbages", description: "NOT MY CABBAGES!!!", unit_price: 500)
          item3 = merchant.items.create!(name: "Freesh Avacadoo", description: "Cream Freesh", unit_price: 200)

          @invoice1 = Invoice.create!(customer_id: dis_gai_ovah_hea.id, status: 0, created_at: Date.tomorrow )
          @invoice2 = Invoice.create!(customer_id: dis_gai_ovah_hea.id, status: 0, created_at: Date.yesterday )
          @invoice3 = Invoice.create!(customer_id: dis_gai_ovah_hea.id, status: 2 ) 

          InvoiceItem.create!(item_id: item1.id, invoice_id: @invoice1.id, quantity: 100, unit_price: item1.unit_price, status: 0 )
          InvoiceItem.create!(item_id: item2.id, invoice_id: @invoice2.id, quantity: 100, unit_price: item2.unit_price, status: 1 )
          InvoiceItem.create!(item_id: item3.id, invoice_id: @invoice3.id, quantity: 100, unit_price: item3.unit_price, status: 2 )



          visit '/admin'  
        end

        it "I see a section for 'Incomplete Invoices'," do

          within 'section#incomplete_invoices' do
            expect(page).to have_content("Incomplete Invoices")
          end
        end

        it "In that section I see a list of the ids of all invoices that have items that have not yet been shipped" do

          within('section#incomplete_invoices') do
            expect(page).to have_link("#{@invoice1.id}")
            expect(page).to have_link("#{@invoice2.id}")
            expect(page).to_not have_link("#{@invoice3.id}")
          end
        end

        it "And each invoice id links to that invoice's admin show page." do

          click_link "#{@invoice1.id}"
          expect(current_path).to eq("/admin/invoices/#{@invoice1.id}")
        
          visit '/admin'
          click_link "#{@invoice2.id}"
          expect(current_path).to eq("/admin/invoices/#{@invoice2.id}")
        end

        it 'next to each invoice id I see the date that invoice was created ordered oldest to newest' do
          expect("#{@invoice2.id}").to appear_before("#{@invoice1.id}")
        end
      end
    end
  end
end