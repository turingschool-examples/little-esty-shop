require 'rails_helper'

RSpec.describe 'admin merchant index page', type: :feature do
  before do
    @merchant1 = create(:merchant)
    @merchant2 = create(:merchant)
    @merchant3 = create(:merchant)
  end

  it 'displays all merchant names' do
    visit '/admin/merchants'

    expect(page).to have_content(@merchant1.name)
    expect(page).to have_content(@merchant2.name)
    expect(page).to have_content(@merchant3.name)
  end
#
#   As an admin,
# When I visit the admin merchants index (/admin/merchants)
# Then I see the name of each merchant in the system
end
