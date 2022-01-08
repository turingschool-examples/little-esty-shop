require 'rails_helper'

RSpec.describe "Admin merchant edit feature" do
  describe 'edit page' do
    it 'has a link to the edit page' do
      visit admin_merchant_path(@merchant_1)

      click_link "Update #{@merchant_1.name}"

      expect(current_path).to eq(edit_admin_merchant_path(@merchant_1))
    end

    it 'has a form to edit the merchant and redirects to show page' do
      visit edit_admin_merchant_path(@merchant_1)

      fill_in(:name, with: "Charlie Chesterfield's Chess Boards")
      click_button "Submit"

      expect(current_path).to eq(admin_merchant_path(@merchant_1))
      expect(page).to have_content("Charlie Chesterfield's Chess Boards")
      expect(page).to have_content("Successfully Updated")
    end
  end
end
