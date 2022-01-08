require 'rails_helper'

RSpec.describe "Admin Merchant Edit Page", type: :feature do 

  it "form edits merchant name and redirects back to the show page" do 
    
    merch_1 = Merchant.create!(name: "Easily Amused Studio")
    merch_2 = Merchant.create!(name: "Retro Furniture")
    merch_3 = Merchant.create!(name: "Vintage Accessories")

    visit "/admin/merchants/#{merch_1.id}/edit"

    expect(page).to have_field('Merchant Name', with: 'Vintage Accessories')
    
    fill_in :merchant_name, with: ("Vintage Shoppe")
    click_button "Submit"

    expect(current_path).to eq("/admin/merchants/#{merch_3.id}")
    expect(page).to have_content("Vintage Shoppe")
    expect(controller).to set_flash[:success]
    
#   As an admin,
# When I visit a merchant's admin show page
# Then I see a link to update the merchant's information.
# When I click the link
# Then I am taken to a page to edit this merchant
# And I see a form filled in with the existing merchant attribute information
# When I update the information in the form and I click ‘submit’
# Then I am redirected back to the merchant's admin show page where I see the updated information
# And I see a flash message stating that the information has been successfully updated.
  end


end
