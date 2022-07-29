require 'rails_helper'

RSpec.describe 'admin merchant new page' do 
    it 'has a form that allows you to create a new merchant' do 
        visit '/admin/merchants'

        expect(page).to_not have_content('Batman')
        
        visit '/admin/merchants/new'
        save_and_open_page

        fill_in("Name", with: "Batman")
        click_on("Create")

        expect(current_path).to eq('/admin/merchants')

         within (page.all(".disabled_merchant_buttons")[0]) do 
            expect(page).to have_button("Enable")
            expect(page).to have_content("Batman")
        end 
    end 
end 