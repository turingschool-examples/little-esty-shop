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

      # create_list(:invoice, 6)
      # @customer1 = create(:customer)
      # create_list(:invoice, 2, customer_id: @customer1.id)

      # FactoryBot.create_list(:invoice, 6)
      # @customer1 = FactoryBot.create(:customer, )
      # FactoryBot.create_list(:invoice, 2, customer_id: @customer1.id)

      @customer1 = create(:customer)
      @customer2 = create(:customer)
      @customer3 = create(:customer)
      @customer4 = FactoryBot.create(:customer)
      @customer5 = FactoryBot.create(:customer)
      @customer6 = FactoryBot.create(:customer)
      @invoice1 = create_list(:invoice, 1, customer_id: @customer1.id)
      @invoice2 = create_list(:invoice, 2, customer_id: @customer2.id)
      @invoice3 = create_list(:invoice, 3, customer_id: @customer3.id)
      @invoice4 = FactoryBot.create_list(:invoice, 4, customer_id: @customer4.id)
      @invoice5 = FactoryBot.create_list(:invoice, 5, customer_id: @customer5.id)
      @invoice6 = FactoryBot.create_list(:invoice, 6, customer_id: @customer6.id)
      @invoices = [@invoice1, @invoice2, @invoice3, @invoice4, @invoice5, @invoice6].flatten

        @invoices.each do |invoice|
          require "pry"; binding.pry
          create(:transaction, invoice_id: invoice.id)
        end

    end

    it 'can return list of top 5 customers in desending order of completed invoices' do
      visit admin_path
require "pry"; binding.pry
      expect(page).to_not have_content("#{customer1.name}")

    end




  end

end
