require 'rails_helper'

describe 'Admin Dashboard Index Page' do
  before :each do 


  end

  it 'should display a header indicating the admin dashboard' do
    visit '/admin'
    expect(page).to have_content('Admin Dashboard')
  end

end