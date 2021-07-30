require 'rails_helper'

RSpec.describe 'Admin Dashboard page' do 
  before :each do 
    visit '/admin'
  end
  it 'is on the right page' do 
    expect(current_path).to eq('/admin')
  end

  it 'displays the header' do
    expect(page).to have_content('Admin Dashboard')
  end 

  it 'can take the user to the admin merchants page' do 
    click_link 'Merchants Index'
    expect(current_path).to eq ('/admin/merchants')
  end  

  it 'can take the user to the admin invoices page' do 
  end 
end 