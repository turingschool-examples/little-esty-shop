require 'rails_helper'

RSpec.describe 'admin index page' do
  it "has a header indicating you are on the admin dashboard" do
    visit '/admin'

    expect(page).to have_content('Admin Dashboard')
  end
end
