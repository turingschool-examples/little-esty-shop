require 'rails_helper'
RSpec.describe 'Item edit page' do
    before :each do 
        @merchant_1 = Merchant.create!(
            name: "Store Store",
            created_at: Date.current,
            updated_at: Date.current
            )
        @cup = @merchant_1.items.create!(
            name: "Cup",
            description: "What the **** is this thing?",
            unit_price: 10000,
            created_at: Date.current,
            updated_at: Date.current
            )
        visit "/items/#{@cup.id}/edit"
    end 
  
    it "has a form to update the item " do
    expect(page).to have_content("Edit Cup")

    expect(find('form')).to have_content('Name')
    expect(find('form')).to have_content('Description')
    expect(find('form')).to have_content('Unit price')
    end 

    it "can submit the filled in form" do

    fill_in 'Name', with: 'Mug'
    fill_in 'Description', with: 'Holds Coffee'
    fill_in 'Unit price', with: 800
    
    end 

 

  
end 