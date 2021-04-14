require 'rails_helper'

RSpec.describe 'admin index page', type: :feature do
  it 'has a header indicating i am on the admin dashboard' do

    visit '/admin'
    
    within("#admin_header") do
      expect(page).to have_content("Admin Dashboard")
    end
  end
  
  it 'has a link to the admin merchants index' do
    visit '/admin'
    within ("#links") do
      expect(page).to have_link("Merchants")
      click_link("Merchants")
      expect(current_path).to eq("/admin/merchants")
    end
  end
  
  it 'has a link to the admin invoices index' do
    visit '/admin'
    within ("#links") do
      expect(page).to have_link("Invoices")  
      click_link("Invoices")
      expect(current_path).to eq("/admin/invoices")
    end
  end

  describe 'it has an incomplete invoices section' do
    it 'lists all incomplete invoices' do
      customer = Customer.create!(first_name: "Abe", last_name: "Oldman")
      invoice1 = customer.invoices.create!(status: 0)
      invoice2 = customer.invoices.create!(status: 1)
      invoice3 = customer.invoices.create!(status: 2)
      invoice4 = customer.invoices.create!(status: 0)

      visit '/admin'
      
      within("#incomplete_invoices") do
        expect(page).to have_content("Incomplete Invoices")
        expect(page).to have_content(invoice1.id)
        expect(page).to have_content(invoice4.id)
      end
    end
    it 'orders the invoices from oldest to newest
        and displays the date the invoice was created "Monday, July 18,2019"' do
      customer = Customer.create!(first_name: "Abe", last_name: "Oldman")
      invoice1 = customer.invoices.create!(status: 0)
      invoice2 = customer.invoices.create!(status: 1)
      invoice3 = customer.invoices.create!(status: 2)
      invoice4 = customer.invoices.create!(status: 0)
      invoice5 = customer.invoices.create!(status: 0)

      visit '/admin'
      
      within("#incomplete_invoices") do
        expect(page).to have_content("Incomplete Invoices")
        
        within("#incomplete_invoice-#{invoice1.id}") do
          expect(page).to have_content(invoice1.id)
          expect(page).to have_content("Wednesday, April 14, 2021")
        end
    
        within("#incomplete_invoice-#{invoice5.id}") do
          expect(page).to have_content(invoice5.id)
          expect(page).to have_content("Wednesday, April 14, 2021")
        end
      end
    end
    it 'each incomplete invoice is a link to that invoices show page' do
      customer = Customer.create!(first_name: "Abe", last_name: "Oldman")
      invoice1 = customer.invoices.create!(status: 0)
      invoice2 = customer.invoices.create!(status: 1)
      invoice3 = customer.invoices.create!(status: 2)
      invoice4 = customer.invoices.create!(status: 0)
      invoice5 = customer.invoices.create!(status: 0)

      visit '/admin'
      
      within("#incomplete_invoice-#{invoice1.id}") do
        expect(page).to have_link("#{invoice1.id}")
        click_link("#{invoice1.id}")
        expect(current_path).to eq("/admin/invoices/#{invoice1.id}")
      end
      
      # within("#incomplete_invoice-#{invoice5.id}") do
      #   expect(page).to have_link("#{invoice5.id}")
      #   click_link("#{invoice5.id}")
      #   expect(current_path).to eq("/admin/invoices/#{invoice5.id}")
      # end
    end
  end
end