require 'rails_helper'

RSpec.describe "As an admin, when I visit the admin dashboard (/admin)", type: :feature do
  it "I see a header indicating that I am on the admin dashboard" do
    visit admin_index_path

    within("#admin_title") do
      expect(page).to have_content "Admin Dashboard"
    end
  end

  it "I see a link to the admin merchants index (/admin/merchants)" do
    visit admin_index_path

    within("#admin_links") do
      expect(page).to have_link("Merchants")
    end
  end

  it "I see a link to the admin invoices index (/admin/invoices)" do
    visit admin_index_path

    within("#admin_links") do
      expect(page).to have_link("Invoices")
    end
  end

  it "Then I see the names of the top 5 customers who have conducted the largest number of successful transactions" do
    visit admin_index_path

    within("#top_customers") do
      within("#Parker") do
        expect(page).to have_content("Parker")
        expect(page).to_not have_content("Joey")
      end
      within("#Joey") do
        expect(page).to have_content("Joey")
        expect(page).to_not have_content("Parker")
      end
      within("#Leanne") do
        expect(page).to have_content("Leanne")
        expect(page).to_not have_content("Joey")
      end
      within("#Mariah") do
        expect(page).to have_content("Mariah")
        expect(page).to_not have_content("Parker")
      end
      within("#Cecelia") do
        expect(page).to have_content("Cecelia")
        expect(page).to_not have_content("Mariah")
      end
    end
  end

  it "And next to each customer name I see the number of successful transactions they have conducted" do
    visit admin_index_path

    within("#top_customers") do
      within("#Parker") do
        expect(page).to have_content("8")
        expect(page).to_not have_content("7")
      end
      within("#Joey") do
        expect(page).to have_content("7")
        expect(page).to_not have_content("1")
      end
      within("#Leanne") do
        expect(page).to have_content("7")
        expect(page).to_not have_content("2")
      end
      within("#Mariah") do
        expect(page).to have_content("3")
        expect(page).to_not have_content("7")
      end
      within("#Cecelia") do
        expect(page).to have_content("1")
        expect(page).to_not have_content("3")
      end
    end
  end
end
