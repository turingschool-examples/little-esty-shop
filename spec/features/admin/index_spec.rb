require "rails_helper"

RSpec.describe "Admin Dashboard (Index", type: :feature do
  
  before(:each) do

  end

  it "has a header indicating that the user is on the admin dashboard" do

    visit "/admin"

    expect(page).to have_content("Admin Dashboard")
  end

  xit "has a link to the admin merchants index" do
    
    visit "/admin"

  end

  # xit "has a link to the admin invoices index" do
  #   visit "/admin"
  # end
end