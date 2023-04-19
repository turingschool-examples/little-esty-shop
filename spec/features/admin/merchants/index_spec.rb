require 'rails_helper'

RSpec.describe 'Admin Merchants Index Page' do
  before :each do
    test_data

    @merchant_69 = Merchant.create!(name: "Alec", status: 'disabled')

    visit admin_merchants_path
  end

  describe 'As an admin, when I visit the Admin Merchants Index page' do
    it 'I see all merchants in the system' do
      expect(page).to have_content(@merchant_1.name)
      expect(page).to have_content(@merchant_2.name)
      expect(page).to have_content(@merchant_3.name)
      expect(page).to have_content(@merchant_4.name)
      expect(page).to have_content(@merchant_5.name)
    end

    it 'When I click on a merchants name, 
      I am taken to that merchants admin show page' do
      within "#top_merchant_#{@merchant_1.id}" do
        click_link(@merchant_1.name)
        expect(current_path).to eq(admin_merchant_path(@merchant_1))
      end
    end

    it 'I see the names of the top 5 merchants by total revenue generated' do
      within "#top_merchants" do
        expect(@merchant_2.name).to appear_before(@merchant_1.name)
        expect(@merchant_1.name).to appear_before(@merchant_5.name)
        expect(@merchant_5.name).to appear_before(@merchant_3.name)
        expect(@merchant_3.name).to appear_before(@merchant_4.name)
      end
      
      within "#top_merchant_#{@merchant_2.id}" do
        expect(page).to have_content(@merchant_2.name)
        expect(page).to_not have_content(@merchant_1.name)
        expect(page).to_not have_content(@merchant_3.name)
      end
    end
    
    it 'I see that each merchant name links to the 
    admin merchant show page for that merchant' do
      within "#top_merchant_#{@merchant_1.id}" do
        
        expect(current_path).to eq(admin_merchants_path)
        
        click_on("#{@merchant_1.name}")
        
        expect(current_path).to eq(admin_merchant_path(@merchant_1))
      end
      visit admin_merchants_path
    
      within "#top_merchant_#{@merchant_3.id}" do
        expect(current_path).to eq(admin_merchants_path)
          
        click_on("#{@merchant_3.name}")
        
        expect(current_path).to eq(admin_merchant_path(@merchant_3))
      end
    end

  
    it 'I see the total revenue generated next to each merchant name' do
      
      within "#top_merchant_#{@merchant_2.id}" do
        expect(page).to have_content(@merchant_2.name)
        expect(page).to have_content("$15,307,520.00")
      end
      within "#top_merchant_#{@merchant_4.id}" do
        expect(page).to have_content(@merchant_4.name)
        expect(page).to have_content("$7,500,000.00")
      end
    end

    it 'visits index and enables merchant' do
      visit admin_merchants_path

      click_button 'Enable'

      expect(current_path).to eq(admin_merchants_path)
      expect(page).to have_content("Merchant Enabled")
    end

    it 'visits index and disables merchant' do
      @merchant_2.disabled!
      @merchant_3.disabled!
      @merchant_4.disabled!
      @merchant_5.disabled!
      visit admin_merchants_path
      expect(current_path).to eq('/admin/merchants')

      click_button 'Disable'
      expect(page).to have_content('disabled')

      
      expect(current_path).to eq(admin_merchants_path)
      expect(page).to have_content("Merchant Disabled")
    end

    it 'has section for enabled merchants' do
      visit admin_merchants_path

      expect(page).to have_content("Enabled Merchants")
    end
    
    it 'has section for disabled merchants' do
      visit admin_merchants_path

      expect(page).to have_content("Disabled Merchants")
    end
  end
end
