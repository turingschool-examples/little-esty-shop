require 'rails_helper'

RSpec.describe "welcome#index" do
  
  it 'links to merchant and admin dashboards' do
    visit '/'

    expect(page).to have_content("Admin Dashboard")
  end
end