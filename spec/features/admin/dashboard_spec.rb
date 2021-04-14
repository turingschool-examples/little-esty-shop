require 'rails_helper'

RSpec.describe "Admin Dashboard" do
  it "shows header for admin dashboard" do
    visit "/admin"

    expect(page).to have_content("Admin Dashboard")
    save_and_open_page

  end
end
