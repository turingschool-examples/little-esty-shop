# As an admin,
# When I visit the admin dashboard (/admin)
# Then I see a header indicating that I am on the admin dashboard
RSpec.describe 'Admin Show Dashboard Page', type: :feature do
  describe "As an admin visiting '/admin'" do
    it 'I see a header indicating I am on the admin dashboard' do
      visit admin_dashboard_path
      # save_and_open_page

      within 'h1' do
        expect(page).to have_content('Admin Dashboard')
      end
    end
  end
end