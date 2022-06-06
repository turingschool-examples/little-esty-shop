require 'rails_helper'

RSpec.describe "Merchant Items Index Page" do
  let!(:customer1) { Customer.create!(first_name: "Leanne", last_name: "Braun") }
  let!(:customer2) { Customer.create!(first_name: "Sylvester", last_name: "Nader") }

  let!(:invoice1) { customer1.invoices.create!(status: 2, created_at: '2012-03-21 14:53:59') }
  let!(:invoice2) { customer2.invoices.create!(status: 2, created_at: '2012-03-23 14:53:59') }
  let!(:invoice3) { customer1.invoices.create!(status: 2, created_at: '2012-03-24 14:53:59') }
  let!(:invoice4) { customer1.invoices.create!(status: 2, created_at: '2012-03-25 14:53:59') }
  let!(:invoice5) { customer2.invoices.create!(status: 2, created_at: '2012-03-26 14:53:59') }
  let!(:invoice6) { customer2.invoices.create!(status: 2, created_at: '2012-03-27 14:53:59') }

    it 'displays all invoices' do
      visit admin_invoices_path
      expect(page).to have_content("Invoice: #{invoice1.id}")
      expect(page).to have_link("#{invoice1.id}")
      expect(page).to have_content("Invoice: #{invoice2.id}")
      expect(page).to have_link("#{invoice2.id}")
      expect(page).to have_content("Invoice: #{invoice3.id}")
      expect(page).to have_link("#{invoice3.id}")
      expect(page).to have_content("Invoice: #{invoice4.id}")
      expect(page).to have_link("#{invoice4.id}")
      expect(page).to have_content("Invoice: #{invoice5.id}")
      expect(page).to have_link("#{invoice5.id}")
      expect(page).to have_content("Invoice: #{invoice6.id}")
      expect(page).to have_link("#{invoice6.id}")
    end
end
