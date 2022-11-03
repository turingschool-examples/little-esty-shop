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

  # Admin Merchant Enable/Disable
  describe 'enabling and disabling merchants' do 
    it 'has an enable and disable button next to each merchant name' do
      within "#merchant-#{@klein_rempel.id}" do 
        expect(page).to have_button("Enable")
        expect(page).to have_button("Disable")
      end
      within "#merchant-#{@whb.id}" do 
        expect(page).to have_button("Enable")
        expect(page).to have_button("Disable")
      end
    end

    it 'changes status of merchant when button is pressed' do 
      within "#merchant-#{@klein_rempel.id}" do 
        click_button 'Enable' 

        expect(current_path).to eq(admin_merchants_path)
        expect(page).to have_content("Enabled")
      end
      within "#merchant-#{@whb.id}" do 
        click_button 'Disable' 

        expect(current_path).to eq(admin_merchants_path)
        expect(page).to have_content("Disabled")
      end
    end
  end

end