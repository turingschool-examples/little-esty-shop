require 'rails_helper'

RSpec.describe "admin merchants new" do

  before(:each) do
    @merchant_1 = Merchant.create!(name: "Mel's Travels", uuid: 1)
    @merchant_3 = Merchant.create!(name: "Huy's Cheese", uuid: 3)
    @merchant_2 = Merchant.create!(name: "Hady's Beach Shack", uuid: 2)

  end

  describe 'as an admin' do
    describe "visit the admin merchants new page" do 
      it "there is a form that allows me to add merchant information" do 
        visit admin_merchants_new_path

        expect(page).to have_selector('form')
        expect(page).to have_field(:name)
        expect(page).to have_button("Create Merchant")
      end 

      it "there is a form that allows me to add merchant information" do 
        visit admin_merchants_new_path

        expect(page).to have_selector('form')
        expect(page).to have_field(:name)
        expect(page).to have_button("Create Merchant")
      end 

      it "i fill in the form and click submit and am taken back to the admin merchants index page and can see the merchant we just created which as a default status of zero" do 

        visit admin_merchants_path

        expect(page).to_not have_content("Diego")

        visit admin_merchants_new_path

        fill_in "merchant_name", with: "Diego"

        click_button("Create Merchant")

        expect(current_path).to eq(admin_merchants_path)

        expect(page).to have_content("Diego")

        expect(Merchant.last.status).to eq("disabled")

      end 

      end
    end
  end