# As an admin,
# When I visit the admin dashboard (/admin)
# 19: Then I see a header indicating that I am on the admin dashboard
# 20: Then I see a link to the admin merchants index (/admin/merchants)
# And I see a link to the admin invoices index (/admin/invoices)
RSpec.describe 'Admin Show Dashboard Page', type: :feature do
  describe "As an admin visiting '/admin'" do
    it 'I see a header indicating I am on the admin dashboard' do
      visit admin_dashboard_path
      # save_and_open_page

      within 'h1' do
        expect(page).to have_content('Admin Dashboard')
      end
    end

    it 'I see links to admin merchants and invoices indexes' do
      visit '/admin'
      # save_and_open_page

      within 'div#links' do
        expect(page).to have_link('Admin Merchants')
        expect(page).to have_link('Admin Invoices')
      end
    end
  end
end