require 'rails_helper'

RSpec.describe 'Welcome page' do
  it "Display's the right content" do
    visit '/'
    expect(page).to have_content("Little Etsy Shop")
    expect(page).to have_link("Merchants Index")
    expect(page).to have_link("Admin Index")
  end

  it "Has working links" do
    visit '/'
    click_link ("Merchants Index")
    expect(page).to have_content("Merchants")
    visit '/'
    click_link ("Admin Index")
    expect(page).to have_content("Admin")
  end


end
