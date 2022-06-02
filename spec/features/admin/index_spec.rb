require 'rails_helper'

describe "Admin Dashboad" do
  before do
    visit admin_index_path
  end

  it "displays a header indicating that the user is on the admin dashboard" do

    expect(page).to have_content("Welcome to the Admin Dashboard")
  end



end
