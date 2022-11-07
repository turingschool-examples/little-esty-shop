require 'rails_helper'[]

RSpec.describe 'Admin merchants Update' do 
  before :each do 
    @klein_rempel = Merchant.create!(name: "Klein, Rempel and Jones", status: "Disabled")
    @whb = Merchant.create!(name: "WHB", status: "Enabled")
    @lisa_frank = Merchant.create!(name: 'Lisa Frank Knockoffs', status: 'Enabled')
    @burger = Merchant.create!(name: 'Burger King', status: 'Disabled')
    @dogs = Merchant.create!(name: 'Dogs')
    @whoopee_cushions = Merchant.create!(name: 'Whoopee Cushions')
  end

  describe 'as an admin, when I visit merchants admin show page' do 
    it 'I see a link to update the merchants info, when I click the link I am taken to a page to edit this merchant' do 
      visit admin_merchant_path(@dogs)

      expect(page).to have_link(@dogs.name)
      click_link(@dogs.name)
      expect(current_path).to eq("/admins/merchants/#{@dogs.id}/edit"
    end

    it 'I see a form filled in witht he existing merchant attribute info, when I update the info in the form and click submit
        I am redirected back to the merchants admin show page where I see updated info. I see
        a flash message stating that the info has been successfull updated' do 

        visit edit_admin_merchant_path(@dogs)

        expect(page).to have_field('Name', with:"#{@dogs.name}")

        fill_in 'Name', with: "Doggo Store"
        click_button ("Submit")
        expect(current_path).to eq(admin_merchant_path(@dogs))

        expect(page).to have_content("Doggo Store")
    end
  end

end