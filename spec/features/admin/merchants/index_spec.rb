require 'rails_helper'
 RSpec.describe 'it shows the merchant index page' do
   before :each do
     visit "/admin/merchants"
   end
   it 'can show the names of the of all the merchants' do
     
    expect(page).to have_content(@merchant1.name)
    expect(page).to have_content(@merchant2.name)
    expect(page).to have_content(@merchant3.name)
    expect(page).to have_content(@merchant4.name)
    expect(page).to have_content(@merchant5.name)
    expect(page).to have_content(@merchant6.name)
    expect(page).to have_content(@merchant7.name)
   end
 end