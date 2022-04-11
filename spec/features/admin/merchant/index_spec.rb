require 'rails_helper'
require 'rake'
Rails.application.load_tasks

RSpec.describe "Admin Merchants Index" do
  it 'displays a header showing the Admin Merchants Index' do
    visit '/admin/merchants'

    within(".header") do
      expect(page).to have_content("Merchant Index - Admin")
    end
  end

  it 'displays all of the merchants' do
    @merchant_1 = Merchant.create!(name: "Mollys")
    @merchant_2 = Merchant.create!(name: "Berrys")
    @merchant_3 = Merchant.create!(name: "Jimmys")

    visit '/admin/merchants'

    within(".index") do
      expect(page).to have_content('Mollys')
      expect(page).to have_content('Berrys')
      expect(page).to have_content('Jimmys')
      expect(page).to_not have_content('Willys')
    end
  end

  it 'loads into test db' do
    Rake::Task['csv_fake:customers'].invoke
    Rake::Task['csv_fake:merchants'].invoke
    Rake::Task['csv_fake:invoices'].invoke
    Rake::Task['csv_fake:items'].invoke
    Rake::Task['csv_fake:transactions'].invoke
    Rake::Task['csv_fake:invoice_items'].invoke
    binding.pry
    expect(Customer.all.length).to eq(40)
    binding.pry
  end
end
