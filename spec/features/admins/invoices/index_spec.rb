require "rails_helper"

RSpec.describe "Admin Invoices Index Page" do
  before(:each) do
    contributors_json_response = File.open("./fixtures/contributors.json")
    pulls_json_response = File.open("./fixtures/pulls.json")
    repo_json_response = File.open("./fixtures/repo.json")

    stub_request(:get, "https://api.github.com/repos/aj-bailey/little-esty-shop").
      to_return(status: 200, body: repo_json_response)

    stub_request(:get, "https://api.github.com/repos/aj-bailey/little-esty-shop/pulls?state=closed").
      to_return(status: 200, body: pulls_json_response)

    stub_request(:get, "https://api.github.com/repos/aj-bailey/little-esty-shop/contributors").
      to_return(status: 200, body: contributors_json_response)
  end
  
  describe 'User Story 32' do
    it 'When I visit the admin Invoices index ("/admin/invoices"), then I see a list of all Invoice ids in the system
      with id links to each invoices show page' do

      spendy_customer = create(:customer)

      invoice_1 = create(:invoice, customer: spendy_customer)
      invoice_2 = create(:invoice, customer: spendy_customer)
      invoice_3 = create(:invoice, customer: spendy_customer)
      invoice_4 = create(:invoice, customer: spendy_customer)

      visit admin_invoices_path

      within("#invoice-#{invoice_1.id}") { expect(page).to have_link("##{invoice_1.id}", href: admin_invoice_path(invoice_1)) }
      within("#invoice-#{invoice_2.id}") { expect(page).to have_link("##{invoice_2.id}", href: admin_invoice_path(invoice_2)) }
      within("#invoice-#{invoice_3.id}") { expect(page).to have_link("##{invoice_3.id}", href: admin_invoice_path(invoice_3)) }
      within("#invoice-#{invoice_4.id}") { expect(page).to have_link("##{invoice_4.id}", href: admin_invoice_path(invoice_4)) }
    end
  end
end