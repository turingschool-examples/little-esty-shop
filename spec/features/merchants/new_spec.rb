require 'rails_helper' 

RSpec.describe 'create new merchant page', type: :feature do
  describe 'as an admin' do
    describe 'when I click on the (create new merchant) link on the admin merchants index page' do
      it 'takes me to a form that allows me to add new merchant information' do
        visit new_merchant_path

        expect(page).to have_selector(:css, "form")
        expect(page).to have_field("New Merchant Name")
        expect(page).to have_button("Submit")
      end

      it 'when I fill out the form and click (submit), I am taken back to the admin merchants index page. I can see 
      the merchant I just created displayed on the admin merchants index page, and its default status is disabled' do
        visit new_merchant_path

        fill_in "New Merchant Name:", with: "Susan's Snappy Stitches"
        click_button "Submit"

        expect(current_path).to eq(admin_merchants_path)

        within "#merchant-disabled" do
          expect(page).to have_content("Susan's Snappy Stitches")
        end
      end
    end
  end
end