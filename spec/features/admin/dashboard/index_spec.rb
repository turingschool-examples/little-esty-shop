require 'rails_helper'

RSpec.describe "As an admin, when I visit the admin dashboard (/admin)", type: :feature do
  it "I see a header indicating that I am on the admin dashboard" do
    visit admin_dashboard_index_path

    within("#admin_title") do
      expect(page).to have_content "Admin Dashboard"
    end
  end

  it "I see a link to the admin merchants index (/admin/merchants)" do
    visit admin_dashboard_index_path

    within("#admin_links") do
      expect(page).to have_link("Merchants")
    end
  end

  it "I see a link to the admin invoices index (/admin/invoices)" do
    visit admin_dashboard_index_path

    within("#admin_links") do
      expect(page).to have_link("Invoices")
    end
  end

  it "I see the names of the top 5 customers who have conducted the largest number of successful transactions" do
    visit admin_dashboard_index_path

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

  it "Next to each customer name I see the number of successful transactions they have conducted" do
    visit admin_dashboard_index_path

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

  it "I see a section for 'Incomplete Invoices'" do
    visit admin_dashboard_index_path

    within("#incomplete_invoices") do
      within("h1") do
        expect(page).to have_content("Incomplete Invoices")
      end
    end
  end

  it "In that section I see a list of the ids of all invoices and each have items that have not yet been shipped" do
    visit admin_dashboard_index_path

    within("#incomplete_invoices") do
      within("#invoice_id_not_shipped") do
        expect(page).to have_content("1")
        expect(find_all("#1").count).to eq 5

        expect(page).to have_content("2")
        expect(find_all("#2").count).to eq 3

        expect(page).to have_content("3")
        expect(find_all("#3").count).to eq 5

        expect(page).to have_content("4")
        expect(find_all("#4").count).to eq 2

        expect(page).to have_content("5")
        expect(find_all("#5").count).to eq 2

        expect(page).to_not have_content("6")

        expect(page).to have_content("7")
        expect(find_all("#7").count).to eq 1

        expect(page).to_not have_content("8")
      end
    end
  end

  it "each invoice id links to that invoice's admin show page" do
    visit admin_dashboard_index_path

    within("#incomplete_invoices") do
      within("#invoice_id_not_shipped") do
        expect(page).to have_link
      end
    end
  end

  it "Next to each invoice id I see the date that the invoice was created, I see the date formatted like 'Monday, July 18, 2019'"
  # Coming back to this test

  it "I see that the list is ordered from oldest to newest" do
    visit admin_dashboard_index_path
    # Coming back to this test


    # expect("Wednesday, March 7, 2012").to appear_before("Saturday, March 10, 2012")
    # expect("Wednesday, March 10, 2012").to appear_before("Saturday, March 12, 2012")
    # expect("Wednesday, March 12, 2012").to appear_before("Saturday, March 24, 2012")
    # expect("Wednesday, March 24, 2012").to appear_before("Saturday, March 25, 2012")
  end
end
