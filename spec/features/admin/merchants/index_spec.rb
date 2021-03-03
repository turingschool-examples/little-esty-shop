require 'rails_helper'

RSpec.describe "When I visit the Admin Merchants index page", type: :feature do
  before :each do
    @joe = Merchant.create!(name: "Joe Rogan")
    @gary = Merchant.create!(name: "Gary Bettman", status: "enabled")
    @roger = Merchant.create!(name: "Roger Goodell") 
  end

  scenario "I see the name of each merchant in the system" do
    visit "/admin/merchants"

    expect(page).to have_content(@joe.name)
    expect(page).to have_content(@gary.name)
    expect(page).to have_content(@roger.name)
  end
  scenario "Each merchant has a link to their show page and their status" do
    visit "/admin/merchants"

    within("#merchant-#{@joe.id}") do
      expect(page).to have_content(@joe.status)
      expect(page).to have_link("#{@joe.name}", href: "/admin/merchants/#{@joe.id}")
    end
    within("#merchant-#{@gary.id}") do
      expect(page).to have_content(@gary.status)
      expect(page).to have_link("#{@gary.name}", href: "/admin/merchants/#{@gary.id}")
    end
    within("#merchant-#{@roger.id}") do
      expect(page).to have_content(@roger.status)
      expect(page).to have_link("#{@roger.name}", href: "/admin/merchants/#{@roger.id}")
    end
  end

  scenario "I see a link to create a new merchant" do
    visit "/admin/merchants"

    expect(page).to have_link("Create Merchant", href: "/admin/merchants/new")
  end

  scenario "When I click on the 'Create Merchant' link, I'm taken to the new admin merchants page" do
    visit "/admin/merchants"

    click_link "Create Merchant"

    expect(current_path).to eq("/admin/merchants/new")
  end

  scenario "I have a button to enable and disable a merchant" do
    visit "/admin/merchants"

    within("#merchant-#{@joe.id}") do
      expect(page).to have_content("disabled")
      expect(page).to have_button("enable")
      click_button "enable"
    end
    expect(current_path).to eq("/admin/merchants")
    within("#merchant-#{@joe.id}") do
      expect(page).to have_content("enabled")
      expect(page).to have_button("disable")
    end
  end

  scenario "Merchants are separated by their status" do
    visit "/admin/merchants"

    within("#enabled") do
      expect(page).to have_content(@gary.name)
      expect(page).to_not have_content(@joe.name)
      expect(page).to_not have_content(@roger.name)
    end

    within("#disabled") do
      expect(page).to_not have_content(@gary.name)
      expect(page).to have_content(@joe.name)
      expect(page).to have_content(@roger.name)
    end
  end

  scenario 'I see the top five merchants by revenue' do
    sakic = Merchant.create!(name: "Joe Sakic")
    rod = Merchant.create!(name: "Rod Brindamour")
    paul = Merchant.create!(name: "Paul Statsny")
    Merchant.stub(:top_five_by_revenue).and_return([@gary, sakic, rod, @joe, paul])
    sakic.stub(:best_day).and_return(DateTime.new(2001, 1, 1))
    rod.stub(:best_day).and_return(DateTime.new(2001, 1, 1))
    paul.stub(:best_day).and_return(DateTime.new(2001, 1, 1))
    @joe.stub(:best_day).and_return(DateTime.new(2001, 1, 1))
    @gary.stub(:best_day).and_return(DateTime.new(2001, 1, 1))

    visit "/admin/merchants"

    within("#top-five") do
      expect(page).to have_content(@gary.name)
      expect(page).to have_content(sakic.name)
      expect(page).to have_content(rod.name)
      expect(page).to have_content(@joe.name)
      expect(page).to have_content(paul.name)
    end
  end

  scenario "I see the revenues of each top five merchants" do
    sakic = Merchant.create!(name: "Joe Sakic")
    rod = Merchant.create!(name: "Rod Brindamour")
    paul = Merchant.create!(name: "Paul Statsny")
    Merchant.stub(:top_five_by_revenue).and_return([@gary, sakic, rod, @joe, paul])
    sakic.stub(:best_day).and_return(DateTime.new(2001, 1, 1))
    rod.stub(:best_day).and_return(DateTime.new(2001, 1, 1))
    paul.stub(:best_day).and_return(DateTime.new(2001, 1, 1))
    @joe.stub(:best_day).and_return(DateTime.new(2001, 1, 1))
    @gary.stub(:best_day).and_return(DateTime.new(2001, 1, 1))

    visit "/admin/merchants"

    within("#top-five-#{sakic.id}") do
      expect(page).to have_content(sakic.total_revenue)
    end
    within("#top-five-#{@gary.id}") do
      expect(page).to have_content(@gary.total_revenue)
    end
    within("#top-five-#{rod.id}") do
      expect(page).to have_content(rod.total_revenue)
    end
    within("#top-five-#{@joe.id}") do
      expect(page).to have_content(@joe.total_revenue)
    end
    within("#top-five-#{paul.id}") do
      expect(page).to have_content(paul.total_revenue)
    end
  end

  scenario "I see the best day of revenue with each of the top 5 merchants" do
    sakic = Merchant.create!(name: "Joe Sakic")
    rod = Merchant.create!(name: "Rod Brindamour")
    paul = Merchant.create!(name: "Paul Statsny")
    Merchant.stub(:top_five_by_revenue).and_return([@gary, sakic, rod, @joe, paul])
    
    sakic.stub(:best_day).and_return(DateTime.new(2001, 1, 1))
    rod.stub(:best_day).and_return(DateTime.new(2001, 1, 1))
    paul.stub(:best_day).and_return(DateTime.new(2001, 1, 1))
    @joe.stub(:best_day).and_return(DateTime.new(2001, 1, 1))
    @gary.stub(:best_day).and_return(DateTime.new(2001, 1, 1))

    visit "/admin/merchants"

    within("#top-five-#{sakic.id}") do
      expect(page).to have_content("Monday, Jan 01, 2001")
    end
    within("#top-five-#{@gary.id}") do
      expect(page).to have_content("Monday, Jan 01, 2001")
    end
    within("#top-five-#{rod.id}") do
      expect(page).to have_content("Monday, Jan 01, 2001")
    end
    within("#top-five-#{@joe.id}") do
      expect(page).to have_content("Monday, Jan 01, 2001")
    end
    within("#top-five-#{paul.id}") do
      expect(page).to have_content("Monday, Jan 01, 2001")
    end
  end
end
