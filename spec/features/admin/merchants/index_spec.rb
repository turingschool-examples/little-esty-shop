require 'rails_helper'

RSpec.describe 'The Admin Merchants Index' do 

  it 'displays the name of each merchant in the system' do 
    merchant1 = Merchant.create!(name: 'The Duke')
    merchant2 = Merchant.create!(name: 'The Fluke')
    merchant3 = Merchant.create!(name: 'The Crook')
    visit admin_merchants_path

    within '#enabled' do 
      within '#the-duke' do 
        expect(page).to have_content(merchant1.name)
      end 
      within '#the-fluke' do 
        expect(page).to have_content(merchant2.name)
      end 
      within '#the-crook' do 
        expect(page).to have_content(merchant3.name)
      end 
    end 
  end 

  it 'displays each merchant name as a link to that merchants show page' do 
    merchant1 = Merchant.create!(name: 'The Duke')
    merchant2 = Merchant.create!(name: 'The Fluke')
    visit admin_merchants_path

    within '#enabled' do 
      expect(page).to have_link(merchant1.name)
      click_link(merchant1.name)
      expect(current_path).to eq(admin_merchant_path(merchant1.id))
    end 
  end 

  it 'displays a button an admin can use to enable or disable a merchants status' do 
    merchant1 = Merchant.create!(name: 'The Duke')
    merchant2 = Merchant.create!(name: 'The Fluke')
    merchant3 = Merchant.create!(name: 'The Crook')
    merchant4 = Merchant.create!(name: 'The Hook')
    merchant5 = Merchant.create!(name: 'The Nook')
    visit admin_merchants_path
    within '#enabled' do
      within '#the-duke' do
        expect(page).to have_button("disable merchant")
        expect(merchant1.status).to eq("enabled")
        expect(page).to have_no_button("enable merchant")  
        click_button("disable merchant")
        expect(current_path).to eq(admin_merchants_path)
        merchant1.reload
        expect(merchant1.status).to eq("disabled")
      end 
    end 
  end
    
  it 'displays a section for enabled merchants' do 
    merchant1 = Merchant.create!(name: 'The Duke')
    merchant2 = Merchant.create!(name: 'The Fluke')
    merchant3 = Merchant.create!(name: 'The Crook')
    merchant4 = Merchant.create!(name: 'The Hook', status: :disabled)
    merchant5 = Merchant.create!(name: 'The Nook', status: :disabled)
    visit admin_merchants_path
    within '#enabled' do
      expect(page).to have_content("Enabled Merchants")
      expect(page).to have_content(merchant1.name)
      expect(page).to have_content(merchant2.name)
      expect(page).to have_content(merchant3.name)
      expect(page).to have_no_content(merchant4.name)
      end
    end
    
  it 'displays a section for disabled merchants' do
    InvoiceItem.destroy_all
    Item.destroy_all
    Merchant.destroy_all
    merchant1 = Merchant.create!(name: 'The Duke')
    merchant2 = Merchant.create!(name: 'The Fluke')
    merchant3 = Merchant.create!(name: 'The Crook')
    merchant4 = Merchant.create!(name: 'The Hook', status: :disabled)
    merchant5 = Merchant.create!(name: 'The Nook', status: :disabled)

    visit admin_merchants_path
    within '#disabled' do
      expect(page).to have_content("Disabled Merchants")
      merchant1.reload
      merchant2.reload
      merchant3.reload
      merchant4.reload
      merchant5.reload
      merchant4.change_status
      merchant5.change_status

      expect(page).to have_content(merchant4.name)
      expect(page).to have_content(merchant5.name)
      expect(page).to have_no_content(merchant3.name)
      expect(page).to have_no_content(merchant1.name)
    end
  end 
    
end 