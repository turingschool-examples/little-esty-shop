require 'rails_helper'

RSpec.describe 'admin index' do 

    it 'has an index page' do 
        visit '/admin'

        expect(page).to have_content("Admin Dashboard")
    end 

end 