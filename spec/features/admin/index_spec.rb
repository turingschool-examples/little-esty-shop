require 'rails_helper'

RSpec.describe 'Admin Dashboard:', type: :feature do 
  before(:each) do
    visit '/admin'  
  end

  let!(:this_gai_ovah_hea) { Customer.create!(first_name: "Dis", last_name: "Gai") }
  let!(:invoice1) { Invoice.create!(customer_id: this_gai_ovah_hea.id, status: 0 ) } 
  let!(:invoice2) { Invoice.create!(customer_id: this_gai_ovah_hea.id, status: 1) } 
  let!(:invoice3) { Invoice.create!(customer_id: this_gai_ovah_hea.id, status: 2) } 

  describe 'As an Admin,' do
    context 'when I visit the admin dashboard (/admin),' do
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

      it "I see a section for 'Incomplete Invoices'," do

        within 'section#incomplete_invoices' do
          expect(page).to have_content("Incomplete Invoices")
        end
      end

      it "In that section I see a list of the ids of all invoices that have items that have not yet been shipped" do

        within('section#incomplete_invoices') do
          expect(page).to have_content()
        end
      end
    end
  end
end