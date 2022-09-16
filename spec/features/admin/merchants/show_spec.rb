require 'rails_helper'

RSpec.describe "Admin Show" do
    describe "As an admin" do
        before :each do
            @merchant_1 = Merchant.create!(name: "Johns Tools")
        end
        # Admin Merchant Show
        # As an admin,
        # When I click on the name of a merchant from the admin merchants index page,
        # Then I am taken to that merchant's admin show page (/admin/merchants/merchant_id)
        # And I see the name of that merchant
        it 'us#25 And I see the name of that merchant' do
            visit admin_merchant_path(@merchant_1.id)
            expect(page).to have_content(@merchant_1.name)
        end
    end
end