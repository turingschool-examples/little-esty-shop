require 'rails_helper'
 RSpec.describe 'it shows the merchant index page' do
   before :each do
     visit "/admin/merchants"
   end
   it 'can show the names of the of all the merchants' do
     expect(page).to have_content(@merchant1.name)
     expect(page).to have_content(@merchant2.name)
     expect(page).to have_content(@merchant3.name)
     expect(page).to have_content(@merchant4.name)
     expect(page).to have_content(@merchant5.name)
     expect(page).to have_content(@merchant6.name)
     expect(page).to have_content(@merchant7.name)
   end

   it 'classifies the merchant names in labeled sections, shows the enabled merchants section' do

    within "#enabled-admin-merchants-#{@merchant5.id}" do
        expect(page).to have_content(@merchant5.name)
      end

      within "#enabled-admin-merchants-#{@merchant6.id}" do
        expect(page).to have_content(@merchant6.name)
      end
   end

   it 'classifies the merchant names in labeled sections, shows the disabled merchants section' do

      within "#disabled-admin-merchants-#{@merchant1.id}" do
        expect(page).to have_content(@merchant1.name)
      end

      within "#disabled-admin-merchants-#{@merchant2.id}" do
        expect(page).to have_content(@merchant2.name)
      end

      within "#disabled-admin-merchants-#{@merchant3.id}" do
        expect(page).to have_content(@merchant3.name)
      end

      within "#disabled-admin-merchants-#{@merchant4.id}" do
        expect(page).to have_content(@merchant4.name)
      end

      within "#disabled-admin-merchants-#{@merchant7.id}" do
        expect(page).to have_content(@merchant7.name)
      end
   end
  end