require 'rails_helper' 

RSpec.describe 'Welcome Page' do 
  before :each do 
    visit '/'
  end

  it 'is on the correct paage' do 
    expect(current_path).to eq('/')
    expect(page).to have_content('Welcome to our project!')
  end

  it 'can take user to mercahnts index page' do 
    expect(current_path).to eq('/')

    click_link 'Merchants' 

    expect(current_path).to eq('/merchants')
  end
end 