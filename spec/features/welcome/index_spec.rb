require 'rails_helper' 

RSpec.describe 'Welcome Page' do 
  before :each do 
    visit '/'
  end

  it 'is on the correct paage' do 
    expect(current_path).to eq('/')
    expect(page).to have_content('Welcome to our project!')
  end

  it 'can take user to merchans index page' do
    first(:link, 'Merchants').click

    expect(current_path).to eq('/merchants')
  end

  it 'can take user to admin merchants index page' do
    within("ul#dropdownmenu") do
      click_link 'Merchants' 

      expect(current_path).to eq('/admin/merchants')
    end 
  end

  it 'can take user to admin invoices index page' do
    click_link 'Invoices' 

    expect(current_path).to eq('/admin/invoices')
  end

  it 'can take user to admin feeling lucky index page' do 
    click_link 'Feeling Lucky 😎' 

    expect(current_path).to eq('/')
  end
end 