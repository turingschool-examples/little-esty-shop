require 'rails_helper'

RSpec.describe 'Admin invoices show page' do
  describe 'When I visit an admin invoice show page' do
    before :each do 
      
    it 'I see the invoice ID and status' do
      visit admin_invoice_path
    end

    it 'I see the created_at date in the format "Monday, July 18, 2019"'

    it 'I see customer first and last name'
  end
end