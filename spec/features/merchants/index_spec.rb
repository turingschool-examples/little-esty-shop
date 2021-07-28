require 'rails_helper' 

RSpec.describe 'Merchants Index Page' do 
  before :each do 
    @merchant1 = Merchant.create!(name: 'Tom Holland')
    @merchant2 =  Merchant.create!(name: 'Hol Tommand')
    @merchant3 =  Merchant.create!(name: 'Boss Baby Records')

    visit '/merchants'
  end

  it 'is on the correct page' do 
    expect(current_path).to eq('/merchants')
    expect(page).to have_content('Merchants')
  end

  it 'can display all merchants' do 
    expect(page).to have_content(@merchant1.name)
    expect(page).to have_content(@merchant2.name)
    expect(page).to have_content(@merchant3.name)
  end 

  it 'can take user to merchant show page' do 
    click_link "#{@merchant1.name}"

    expect(current_path).to eq("/merchants/#{@merchant1.id}")
  end
end 