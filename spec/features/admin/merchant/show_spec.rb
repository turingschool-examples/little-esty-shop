require 'rails_helper'

describe 'welcome page' do
  it 'goes to the first page' do
    visit '/'
    expect(current_path).to eq('/')
    expect(page).to have_content("Welcome to Little Esty Shop!")
  end
end
