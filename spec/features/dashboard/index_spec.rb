require 'rails_helper' 

RSpec.describe 'Merchants Dashboard Page' do 
  before :each do 
    @merchant = Merchant.create!(name: 'Tom Holland')

    visit "/merchants/#{@merchant.id}/dashboard"
  end

  it 'is on the correct page' do 
    expect(current_path).to eq("/merchants/#{@merchant.id}/dashboard")
    expect(page).to have_content("#{@merchant.name}")
  end

  it 'can take the user back one page' do 
    click_link 'Back'

    expect(current_path).to eq('/merchants')
  end

  it 'can take user to merchant items index page' do 
    click_link 'Items' 

    expect(current_path).to eq("/merchants/#{@merchant.id}/items")
  end 

  it 'can take user to merchant invoice index page' do 
    click_link 'Invoices' 

    expect(current_path).to eq("/merchants/#{@merchant.id}/invoices")
  end 
end 