require 'rails_helper'

RSpec.describe 'admin merchant new page' do

  it 'can create new merchant' do
    visit 'admin/merchants/new'

    fill_in("Name", with: "Costa Coffee")
    click_on 'Submit'

    expect(current_path).to eq('/admin/merchants')
    expect(page).to have_content("Costa Coffee")
  end


end
