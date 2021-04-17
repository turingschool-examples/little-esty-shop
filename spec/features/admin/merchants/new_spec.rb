require 'rails_helper'

RSpec.describe 'admin new merchant page', type: :feature do
  it 'shows the new merchant form' do

    visit "/admin/merchants/new"
    
    expect(find('form')).to have_content('Name')
    expect(find('form')).to have_content('Status')
    expect(find('form')).to have_button('Create Merchant')
  end
end
