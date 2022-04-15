require "rails_helper"

RSpec.describe "admin dashboard" do
  it "exists" do
    visit "/admin"

    expect(page).to have_content("Admin Dashboard")
  end
end
