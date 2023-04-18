require 'rails_helper'

RSpec.describe 'new merchant' do

  it 'has a new form for item' do
    visit "/admin/merchants/new"
    
    expect(page).to have_field('Name')
  end
end