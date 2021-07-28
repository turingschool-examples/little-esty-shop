require 'rails_helper' 

RSpec.describe 'Merchants Show Page' do 
  before :each do 
    @merchant = Merchant.create!(name: 'Tom Holland')

    visit "/merchants/#{@merchant.id}"
  end

  it 'is on the correct page' do 
    expect(current_path).to eq("/merchants/#{@merchant.id}")
    expect(page).to have_content("#{@merchant.name}")
  end

  it 'can take the user back one page' do 
    click_link 'Back'

    expect(current_path).to eq('/merchants')
  end
end 