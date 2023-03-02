require 'rails_helper'

RSpec.describe 'Merchant Invoices', type: :feature do
  describe 'Merchant Invoices Index' do

    let!(:this_gai_ovah_hea) { Customer.create!(first_name: "Dis", last_name: "Gai") }
    let!(:invoice1) { Invoice.create!(customer_id: this_gai_ovah_hea.id) } 
    let!(:invoice2) { Invoice.create!(customer_id: this_gai_ovah_hea.id) } 
    let!(:invoice3) { Invoice.create!(customer_id: this_gai_ovah_hea.id) } 

    let!(:sam) { Merchant.create!(name: "Sam's Sports") }
    let!(:football) { sam.items.create!(name: "Football", description: "This a football", unit_price: 3000) }
    let!(:baseball) { sam.items.create!(name: "Baseball", description: "This a baseball", unit_price: 2500) }
    let!(:glove) { sam.items.create!(name: "Baseball Glove", description: "This a baseball glove", unit_price: 4000) }

    before :each do
        repo_call = File.read('spec/fixtures/repo_call.json')
        collaborators_call = File.read('spec/fixtures/collaborators_call.json')
        pulls_call = File.read('spec/fixtures/pulls_call.json')

        stub_request(:get, "https://api.github.com/repos/4D-Coder/little-esty-shop").
            with(
              headers: {
              'Accept'=>'*/*',
              'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
              'Authorization'=>"Bearer #{ENV["github_token"]}",
              'User-Agent'=>'Faraday v2.7.4'
              }).
            to_return(status: 200, body: repo_call, headers: {})


        stub_request(:get, "https://api.github.com/repos/4D-Coder/little-esty-shop/assignees").
            with(
              headers: {
              'Accept'=>'*/*',
              'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
              'Authorization'=>"Bearer #{ENV["github_token"]}",
              'User-Agent'=>'Faraday v2.7.4'
              }).
            to_return(status: 200, body: collaborators_call, headers: {})

        stub_request(:get, "https://api.github.com/repos/4D-Coder/little-esty-shop/pulls?state=all&merged_at&per_page=100").
            with(
              headers: {
              'Accept'=>'*/*',
              'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
              'Authorization'=>"Bearer #{ENV["github_token"]}",
              'User-Agent'=>'Faraday v2.7.4'
              }).
            to_return(status: 200, body: pulls_call, headers: {})
    end

    before (:each) do
      InvoiceItem.create!(invoice_id: invoice1.id, item_id: football.id)
      InvoiceItem.create!(invoice_id: invoice1.id, item_id: baseball.id)
      InvoiceItem.create!(invoice_id: invoice2.id, item_id: glove.id)

      visit merchant_invoices_path(sam.id)
    end

    describe 'As a merchant' do 
      context 'When I visit my merchant invoices index page' do
        it "I should see a list of invoices include at least one of my merchant's items" do
          expect(page).to have_content("#{sam.name}")
          expect(page).to have_content("My Invoices")

          within 'div#invoices_list' do
            expect(page).to have_content("Invoice ##{invoice1.id}")
            expect(page).to have_content("Invoice ##{invoice2.id}")
            expect(page).to_not have_content("Invoice ##{invoice3.id}")
          end
        end

        it "I see that each invoice id is a link to that merchant's invoice's show page" do
          within 'div#invoices_list' do
            expect(page).to have_link("#{invoice1.id}")
            expect(page).to have_link("#{invoice2.id}")
            expect(page).to_not have_link("#{invoice3.id}")
          end
        end
      end
    end
  end
end