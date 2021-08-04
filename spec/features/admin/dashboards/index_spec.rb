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

    expect(page).to have_content("#{@customer5.first_name} #{@customer5.last_name}")
    expect(page).to have_content("#{@customer1.first_name} #{@customer1.last_name}")
    expect(page).to have_content("#{@customer7.first_name} #{@customer7.last_name}")
    expect(page).to have_content("#{@customer9.first_name} #{@customer9.last_name}")
    expect(page).to have_content("#{@customer10.first_name} #{@customer10.last_name}")
    expect("#{@customer5.first_name} #{@customer5.last_name}").to appear_before("#{@customer7.first_name} #{@customer7.last_name}")
    expect("#{@customer7.first_name} #{@customer7.last_name}").to appear_before("#{@customer10.first_name} #{@customer10.last_name}")
    expect("#{@customer10.first_name} #{@customer10.last_name}").to appear_before("#{@customer1.first_name} #{@customer1.last_name}")
    expect("#{@customer9.first_name} #{@customer9.last_name}").to appear_before("#{@customer1.first_name} #{@customer1.last_name}")

    expect(page).to_not have_content("#{@customer8.first_name} #{@customer8.last_name}")
    expect(page).to_not have_content("#{@customer6.first_name} #{@customer6.last_name}")
    expect(page).to_not have_content("#{@customer2.first_name} #{@customer2.last_name}")
    expect(page).to_not have_content("#{@customer3.first_name} #{@customer3.last_name}")
    expect(page).to_not have_content("#{@customer4.first_name} #{@customer4.last_name}")
  end

  it 'shows the number of successful transactions next to each customer' do
    visit "/admin"

    within("##{@customer5.id}") do
      expect(page).to have_content("#{@customer5.first_name}")
      expect(page).to have_content("#{@customer5.last_name}")
      expect(page).to have_content("#{@customer5.num_success_trans}")
    end

    within("##{@customer7.id}") do
      expect(page).to have_content("#{@customer7.first_name}")
      expect(page).to have_content("#{@customer7.last_name}")
      expect(page).to have_content("#{@customer7.num_success_trans}")
    end

    within("##{@customer10.id}") do
      expect(page).to have_content("#{@customer10.first_name}")
      expect(page).to have_content("#{@customer10.last_name}")
      expect(page).to have_content("#{@customer10.num_success_trans}")
    end

    within("##{@customer9.id}") do
      expect(page).to have_content("#{@customer9.first_name}")
      expect(page).to have_content("#{@customer9.last_name}")
      expect(page).to have_content("#{@customer9.num_success_trans}")
    end

    within("##{@customer1.id}") do
      expect(page).to have_content("#{@customer1.first_name}")
      expect(page).to have_content("#{@customer1.last_name}")
      expect(page).to have_content("#{@customer1.num_success_trans}")
    end
  end

  # As an admin,
  # When I visit the admin dashboard
  # Then I see a section for "Incomplete Invoices"
  # In that section I see a list of the ids of all invoices
  # That have items that have not yet been shipped
  # And each invoice id links to that invoice's admin show page
  it 'shows list of incomplete invoices by id' do
    visit "/admin"

    expect(page).to have_content("Incomplete Invoices")

    within("#Incomplete Invoices") do
      expect(page).to have_content("#{invoice1.id}")
      expect(page).to have_content("#{invoice2.id}")
      expect(page).to have_content("#{invoice14.id}")
      expect(page).to_not have_content("#{invoice4.id}")
      expect(page).to_not have_content("#{invoice7.id}")
      # expect(page).to have_content("#{invoice1.created_at.strftime("%A, %B %d, %Y"}")
    end
  end

  xit 'links incomplete invoice ids to admin show page' do
    visit "/admin"

    click_on("#{@invoice1.id}")

    expect(current_path).to eq("/admin/invoices/#{@invoice.id}")
  end
end
