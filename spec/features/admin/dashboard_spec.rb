require 'rails_helper'

RSpec.describe 'admin dashboard page' do

  it 'can visit /admin' do
    visit '/admin'

    expect(page).to have_content('Admin Dashboard')
  end



end
