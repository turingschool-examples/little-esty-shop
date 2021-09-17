require "rails_helper"

RSpec.describe 'admin show page' do
  before(:each) do
    @customer = create(:customer)
    @invoice_1 = create(:invoice, customer: @customer, created_at: 'Monday, July 18, 2019')
  end

  it 'shows relevant invoice information' do
    require "pry"; binding.pry
    visit admin_invoice_path(@invoice_1)

    within('#invoice-information') do
      expect(page).to have_content(@invoice_1.id)
      expect(page).to have_content(@invoice_1.status)
      expect(page).to have_content(@invoice_1.created_at)
      expect(page).to have_content("#{customer.first_name} #{customer.last_name}")
    end

  end
end


# As an admin,
# When I visit an admin invoice show page
# Then I see information related to that invoice including:
#
# Invoice id
# Invoice status
# Invoice created_at date in the format "Monday, July 18, 2019"
# Customer first and last name
