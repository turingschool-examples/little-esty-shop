require 'rails_helper'

RSpec.describe 'the admin merchants index page' do 
  before (:each) do 
    @klein_rempel = Merchant.create!(name: "Klein, Rempel and Jones", status: "Disabled")
    @whb = Merchant.create!(name: "WHB", status: "Enabled")
    @lisa_frank = Merchant.create!(name: 'Lisa Frank Knockoffs', status: 'Enabled')
    @burger = Merchant.create!(name: 'Burger King', status: 'Disabled')

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
      end
      within "#merchant-#{@whb.id}" do 
        expect(page).to have_button("Disable")
      end
    end

    it 'changes status of merchant when button is pressed' do 
      within "#merchant-#{@klein_rempel.id}" do 
        click_button 'Enable' 
        @klein_rempel = Merchant.find(@klein_rempel.id)

        expect(current_path).to eq(admin_merchants_path)
        expect(@klein_rempel.status).to eq("Enabled")
      end
      within "#merchant-#{@whb.id}" do 
        click_button 'Disable' 
        @whb = Merchant.find(@whb.id)

        expect(current_path).to eq(admin_merchants_path)
        expect(@whb.status).to eq("Disabled")
      end
    end

    it 'organizes merchants by enabled/disabled' do 
      within '#enabled' do 
        expect(page).to have_content(@whb.name)
        expect(page).to have_content(@lisa_frank.name)
      end
      within '#disabled' do 
        expect(page).to have_content(@klein_rempel.name)
        expect(page).to have_content(@burger.name)
      end
    end
  end
end