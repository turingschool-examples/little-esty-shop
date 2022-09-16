require 'rails_helper'

RSpec.describe 'admin dashboard page' do

  it 'can visit /admin' do
    visit '/admin'

    expect(page).to have_content('Admin Dashboard')
  end

  it 'can link to admin mechants index' do
    visit '/admin'

    click_link 'Merchants'

    expect(current_path).to eq(admin_merchants_path)
  end

  it 'can link to admin invoices index' do
    visit '/admin'

    click_link 'Invoices'

    expect(current_path).to eq(admin_invoices_path)
  end

  describe 'dashboard statistics' do
    before :each do

      create_list(:invoice, 6)
      @customer1 = create(:customer)
      create_list(:invoice, 2, customer_id: @customer1.id)


      require "pry"; binding.pry
    end

    it '' do
      visit admin_path
    end




  end

end
