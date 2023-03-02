require 'rails_helper'
RSpec.describe "Admin Invoices Index", type: :feature do 
  let!(:this_gai_ovah_hea) { Customer.create!(first_name: "Dis", last_name: "Gai") }

  let!(:invoice1) { Invoice.create!(customer_id: this_gai_ovah_hea.id) } 
  let!(:invoice2) { Invoice.create!(customer_id: this_gai_ovah_hea.id) } 
  let!(:invoice3) { Invoice.create!(customer_id: this_gai_ovah_hea.id) } 
  let!(:invoice4) { Invoice.create!(customer_id: this_gai_ovah_hea.id) } 
  let!(:invoice5) { Invoice.create!(customer_id: this_gai_ovah_hea.id) } 

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
  describe "As an admin" do
    context "When I visit the admin invoices index (/admin/invoices)" do
      before do
        visit admin_invoices_path
      end

      it "Sees a list of all Invoice ids in the system" do
        expect(page).to have_content("#{invoice1.id}")

        expect(page).to have_content("#{invoice2.id}")

        expect(page).to have_content("#{invoice3.id}")

        expect(page).to have_content("#{invoice4.id}")

        expect(page).to have_content("#{invoice5.id}")
      end

      it "Each id links to the admin invoice show page" do
        within "#invoice-#{invoice1.id}" do
          click_link "#{invoice1.id}"

          expect(page).to have_current_path(admin_invoice_path(invoice1))
        end

        visit admin_invoices_path

        within "#invoice-#{invoice2.id}" do
          click_link "#{invoice2.id}"

          expect(page).to have_current_path(admin_invoice_path(invoice2))
        end
        
        visit admin_invoices_path

        within "#invoice-#{invoice3.id}" do
          click_link "#{invoice3.id}"

          expect(page).to have_current_path(admin_invoice_path(invoice3))
        end

        visit admin_invoices_path

        within "#invoice-#{invoice4.id}" do
          click_link "#{invoice4.id}"

          expect(page).to have_current_path(admin_invoice_path(invoice4))
        end

        visit admin_invoices_path

        within "#invoice-#{invoice5.id}" do
          click_link "#{invoice5.id}"

          expect(page).to have_current_path(admin_invoice_path(invoice5))
        end
      end
    end
  end
end