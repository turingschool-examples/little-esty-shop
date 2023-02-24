require 'rails_helper'

RSpec.describe '#index' do
  before :each do
    @merchant1 = Merchant.create!(name: "Carlos Jenkins") 

    visit "/admin/merchants/#{@merchant1.id}"
  end

  describe 'as an admin when I visit the admin merchants show page' do
    it 'I see the names of that merchant' do
      save_and_open_page
      expect(page).to have_content("Carlos Jenkins")
    end

  end
  
end