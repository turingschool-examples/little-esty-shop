require 'rails_helper'

RSpec.describe 'the admin merchants show page' do 
  before (:each) do 
    @klein_rempel = Merchant.create!(name: "Klein, Rempel and Jones")
    @whb = Merchant.create!(name: "WHB")

    visit admin_merchants_path
  end
  describe 'merchants' do 
    it 'lists the name of all merchants in the system' do 
      expect(page).to have_content(@klein_rempel.name)
      expect(page).to have_content(@whb.name)
    end
  end
end