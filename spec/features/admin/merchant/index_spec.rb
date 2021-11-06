require 'rails_helper'

RSpec.describe 'Admin Merchant Index page' do
  it 'has a link to create a new merchant' do
    visit admin_merchants_path

    click_link 'Create Merchant'

    expect(current_path).to eq(admin_merchants_new_path)
  end
end