require 'rails_helper' 

RSpec.describe 'Admin Merchants Show Page' do 
  before :each do 
    @merchant1 = Merchant.create!(name: 'Tom Holland')
   

    visit "/admin/merchants/#{@merchant1.id}"
  end

  it 'is on the correct page' do 
    expect(current_path).to eq("/admin/merchants/#{@merchant1.id}")
    expect(page).to have_content("#{@merchant1.name}")
  end

  it 'can take user to edit merchant edit page' do 
    click_link "Edit"

    expect(current_path).to eq("/admin/merchants/#{@merchant1.id}/edit")
    expect(page).to have_content("Editing Merchant #{@merchant1.name}")
  end
end 