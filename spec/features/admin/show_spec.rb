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

    it 'I see the names of the top 5 customers with the largest number of successful transactions and their transaction count' do
      customer1 = create(:customer, :with_transactions, transactions_count: 10, transactions_traits: [:successful])
      customer2 = create(:customer, :with_transactions, transactions_count: 8, transactions_traits: [:successful])
      customer3 = create(:customer, :with_transactions, transactions_count: 6, transactions_traits: [:successful])
      customer4 = create(:customer, :with_transactions, transactions_count: 4, transactions_traits: [:successful])
      customer5 = create(:customer, :with_transactions, transactions_count: 2, transactions_traits: [:successful])
      customer6 = create(:customer, :with_transactions, transactions_count: 1, transactions_traits: [:successful])

      visit admin_dashboard_path

      within 'section#top-customers' do
        expect(page).to have_content("#{customer1.first_name} #{customer1.last_name} - 10")
        expect(page).to have_content("#{customer2.first_name} #{customer2.last_name} - 8")
        expect(page).to have_content("#{customer3.first_name} #{customer3.last_name} - 6")
        expect(page).to have_content("#{customer4.first_name} #{customer4.last_name} - 4")
        expect(page).to have_content("#{customer5.first_name} #{customer5.last_name} - 2")
        expect(page).not_to have_content("#{customer6.first_name} #{customer6.last_name}")
      end
    end
  end
end