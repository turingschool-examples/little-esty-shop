require 'rails_helper'

describe 'dashboard' do
  describe 'user story 19' do
    it 'should have a header \'admin dashboard\'' do
      visit '/admin'
      within('header') do
        expect(page).to have_css('h1', text: "Admin Dashboard")
      end
    end
  end

  describe 'user story 20' do
    it 'should have a link to admin merchants index' do
      visit '/admin'
      expect(page).to have_link('Admin Merchants', href: '/admin/merchants')
    end

    it 'should have a link to admin invoices index' do
      visit '/admin'
      expect(page).to have_link('Admin Invoices', href: '/admin/invoices')
    end
  end 

  describe 'user story 21' do
    xit 'should have a list of the top 5 customers' do
      expect(page).to have_content('Top 5 Customers')

    end
  end
  

end