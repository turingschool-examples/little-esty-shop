require 'rails_helper'

RSpec.describe "the Admin Dashboard" do
    # before { visit '/admin' }
    # page.should render_template("layouts/admin")

    it "should display a header indicating you are on the admin dashboard" do
        visit '/admin'

        within('header') do
            expect(page).to have_content("Admin Dashboard")
        end
    end

    it "header should have links to the admin, admin merchants, and admin invoices indexes" do
        visit '/admin'

        # find_link('Admin').visible?
        within('header') do
            expect(page).to have_link("Admin")
            expect(page).to have_link("Merchants")
            expect(page).to have_link("Invoices")
        end
    end

end
