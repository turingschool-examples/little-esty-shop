require 'rails_helper'

RSpec.describe "Admin dashboard" do
  it "shows the admin dashboard" do
    visit '/admin'

    expect(page).to have_content "Admin Dashboard"
  end
end
