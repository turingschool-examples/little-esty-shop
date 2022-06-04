require 'rails_helper'

# Admin Merchant Show
#
# As an admin,
# When I click on the name of a merchant from the admin merchants index page,
# Then I am taken to that merchant's admin show page (/admin/merchants/merchant_id)
# And I see the name of that merchant


RSpec.describe 'Admin Merchants Show Page', type: :feature do
  describe 'User Story 2 - Admin Merchant Show' do
    it "can display the merchants name" do

      expect(page).to have_content()

    end

  end
end
