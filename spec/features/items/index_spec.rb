require 'rails_helper'

RSpec.describe 'the merchant item index', type: :feature do
  before(:each) do
    @jerde = Merchant.create!(name: 'Schroeder-Jerde')
    @willms = Merchant.create!(name: 'Willms and Sons')
    @thiel = Merchant.create!(name: 'Cummings-Thiel')
    @qui = @jerde.items.create!(name: 'Qui Esse', description: 'Nihil autem', unit_price: 75107, able: "Disabled")
    @autem = @jerde.items.create!(name: 'Autem Minima', description: 'Cumque consequuntur ad', unit_price: 67076, able: "Enabled")
    @ea = @jerde.items.create!(name: 'Ea Voluptatum', description: 'Sunt officia', unit_price: 32301, able: "Enabled")
    @nemo = @willms.items.create!(name: 'Nemo Facere', description: 'Sunt eum id', unit_price: 4291, able: "Disabled")
  end

  it 'has a link to merchants dashboard' do
    visit "/merchants/#{@jerde.id}/items"
      expect(page).to have_link("Dashboard")
      # click_link("Dashboard")
      # expect(current_path).to eq("/merchants/#{@jerde.id}/dashboard")
  end

  it 'has a link to merchant items' do
    visit "/merchants/#{@jerde.id}/items"
      expect(page).to have_link("My Items")
      # click_link("My Items")
      # expect(current_path).to eq("/merchants/#{@jerde.id}/items")
  end

  it 'has a link to merchant invoices' do
    visit "/merchants/#{@jerde.id}/items"
      expect(page).to have_link("My Invoices")
      # click_link("My Invoices")
      # expect(current_path).to eq("/merchants/#{@jerde.id}/invoices")
  end

  it 'lists of the names of all of merchant items' do
    visit "/merchants/#{@jerde.id}/items"

    expect(page).to have_content(@qui.name)
    expect(page).to have_content(@autem.name)
    expect(page).to have_content(@ea.name)
    # expect(page).not_to have_content(@nemo.name)
  end     #merchant items us#1

  it 'has Enable button by Disabled items' do
    visit "/merchants/#{@jerde.id}/items"

    expect(page).to have_content(@qui.name)
    expect(page).to have_button("Enable")
    # click_button "Enable"
    # expect(current_path).to eq("/merchants/#{@jerde.id}/items")
    # expect(page).to have_button("Disable")
    # expect(page).to_not have_button("Enable")
  end

  it 'has Disable button by Enable items' do
    visit "/merchants/#{@jerde.id}/items"

    expect(page).to have_content(@autem.name)
    expect(page).to have_button("Disable")
    # click_button "Disable"
    # expect(current_path).to eq("/merchants/#{@jerde.id}/items")
    # expect(page).to have_button("Enable")
    # expect(page).to_not have_button("Disable")
  end     #merchant items us#4 (#2,3 show page)

  it 'shows two sections, "Enabled Items" & "Disabled Items"' do
    visit "/merchants/#{@jerde.id}/items"

    expect(page).to have_content("Enabled Items")
    expect(page).to have_content(@autem.name)
    expect(page).to have_button("Disable")
    expect(page).to have_content(@ea.name)

    expect(page).to have_content("Disabled Items")
    expect(page).to have_content(@qui.name)
    expect(page).to have_button("Enable")
  end     #merchant items us#5

  it "has a link to 'Create NEW Item'" do
    visit "/merchants/#{@jerde.id}/items"
      click_on "Create NEW Item"
    expect(current_path).to eq("/merchants/#{@jerde.id}/items/new")
  end     #merchant items us#6-1

  it "has form to create new item" do
      visit "/merchants/#{@jerde.id}/items/new"
      # save_and_open_page
    expect(page).to have_content('New Item')
    # expect(find('form')).to have_content('Name')
    # expect(find('form')).to have_content('Description')
    # expect(find('form')).to have_content('Unit price')
    expect(page).to have_button("Submit")
    #   click_on "Submit"
    # expect(current_path).to eq("/merchants/#{@jerde.id}/items")

  end     #merchant items us#6-2
  # And I see the item I just created displayed in the list of items. New item was created w/ a default status of disabled.

  describe 'top five merchants by revenue section' do
    # it 'shows section for 5 Most Popular Items"' do
    #   visit "/merchants/#{@jerde.id}/items"
    #
    #   expect(page).to have_content("5 Most Popular Items")
    # end
    #
    # it 'shows best sale day for Most Popular Items"' do
    #   visit "/merchants/#{@jerde.id}/items"
    #
    #   expect(page).to have_content("Top sales date")
    # end
  end
  # Merchant Items Index: 5 most popular items
  # As a merchant, When I visit my items index page
  # Then I see the names of the top 5 most popular items ranked by total revenue generated
  # And I see that each item name links to my merchant item show page for that item
  # And I see the total revenue generated next to each item name
  #
  # Notes on Revenue Calculation:
  # - Only invoices with at least one successful transaction should count towards revenue
  # - Revenue for an invoice should be calculated as the sum of the revenue of all invoice items
  # - Revenue for an invoice item should be calculated as the invoice item unit price multiplied by the quantity (do not use the item unit price)

  # Merchant Items Index: Top Item's Best Day
  # When I visit the items index page
  # Then next to each of the 5 most popular items I see the date with the most sales for each item.
  # And I see a label “Top selling date for <item name> was <date with most sales>"
  # Note: use the invoice date. If there are multiple days with equal number of sales, return the most recent day.
end
