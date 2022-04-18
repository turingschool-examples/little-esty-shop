require 'rails_helper'

RSpec.describe 'Admin Dashboard' do
  describe 'As an Admin, when I visit the admin dashboard' do
    it 'Then I see a header indicating that I am on the admin dashboard' do
    visit '/admin'
    
    expect(page).to have_content("Admin Dashboard Page")
    end
  end
end