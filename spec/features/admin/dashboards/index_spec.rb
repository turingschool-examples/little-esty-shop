require 'rails_helper'

RSpec.describe 'it can display the dashboards index page' do
  before :each do
    visit "/admin"
  end

  it 'can show the Header of the index page' do
    expect(page).to have_content("Admin Dashboard")
  end

  it 'shows the links to the admin merchants and the admin invoices' do
    expect(page).to have_link("Merchants: Index page")
    expect(page).to have_link("Invoices: Index page")
  end

  it 'can click on the index links and be on that specified index page' do

    click_link("Merchants: Index page")
    expect(current_path).to eq("/admin/merchants")

    visit "/admin"

    click_link("Invoices: Index page")
    expect(current_path).to eq("/admin/invoices")
  end

  # As an admin,
  # When I visit the admin dashboard
  # Then I see the names of the top 5 customers
  # who have conducted the largest number of successful transactions
  # And next to each customer name I see the number of successful transactions they have
  # conducted
  it 'lists the top 5 customers by name with most successful transactions' do
    visit "/admin"

    expect(page).to have_content(@customer5)
    expect(page).to have_content(@customer6)
    expect(page).to have_content(@customer7)
    expect(page).to have_content(@customer9)
    expect(page).to have_content(@customer10)
    expect(@customer5).to appear_before(@customer7)
    expect(@customer7).to appear_before(@customer10)
    expect(@customer10).to appear_before(@customer9)
    expect(@customer9).to appear_before(@customer6)

    expect(page).to_not have_content(@customer8)
    expect(page).to_not have_content(@customer1)
    expect(page).to_not have_content(@customer2)
    expect(page).to_not have_content(@customer3)
    expect(page).to_not have_content(@customer4)
  end

  xit 'shows the number of successful transactions next to each customer' do
    visit "/admin"

    within("#first") do
      expect(page).to have_content("#{@customer5.first_name}")
      expect(page).to have_content("#{@customer5.last_name}")
      expect(page).to have_content("#{@customer5.successful_transactions}")
    end

    within("#second") do
      expect(page).to have_content("#{@customer7.first_name}")
      expect(page).to have_content("#{@customer7.last_name}")
      expect(page).to have_content("#{@customer7.successful_transactions}")
    end

    within("#third") do
      expect(page).to have_content("#{@customer10.first_name}")
      expect(page).to have_content("#{@customer10.last_name}")
      expect(page).to have_content("#{@customer10.successful_transactions}")
    end

    within("#fourth") do
      expect(page).to have_content("#{@customer9.first_name}")
      expect(page).to have_content("#{@customer9.last_name}")
      expect(page).to have_content("#{@customer9.successful_transactions}")
    end

    within("#fifth") do
      expect(page).to have_content("#{@customer6.first_name}")
      expect(page).to have_content("#{@customer6.last_name}")
      expect(page).to have_content("#{@customer6.successful_transactions}")
    end
  end
end
