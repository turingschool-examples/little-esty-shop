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
        expect(page).to have_content("Daugherty, Parker")
        expect(page).to_not have_content("Ondricka, Joey")
      end
      within("#Joey") do
        expect(page).to have_content("Ondricka, Joey")
        expect(page).to_not have_content("Daugherty, Parker")
      end
      within("#Leanne") do
        expect(page).to have_content("Braun, Leanne")
        expect(page).to_not have_content("Ondricka, Joey")
      end
      within("#Mariah") do
        expect(page).to have_content("Toy, Mariah")
        expect(page).to_not have_content("Daugherty, Parker")
      end
      within("#Cecelia") do
        expect(page).to have_content("Osinski, Cecelia")
        expect(page).to_not have_content("Toy, Mariah")
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
        expect(find_all(".invoice_1").count).to eq 5

        expect(page).to have_content("2")
        expect(find_all(".invoice_2").count).to eq 3

        expect(page).to have_content("3")
        expect(find_all(".invoice_3").count).to eq 5

        expect(page).to have_content("4")
        expect(find_all(".invoice_4").count).to eq 2

        expect(page).to have_content("5")
        expect(find_all(".invoice_5").count).to eq 2

        expect(page).to_not have_content("6")

        expect(page).to have_content("7")
        expect(find_all(".invoice_7").count).to eq 1

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

  it "Next to each invoice id I see the date that the invoice was created, I see the date formatted like 'Monday, July 18, 2019'" do
    visit admin_dashboard_index_path

    within("#incomplete_invoices") do
      within("#invoice_id_not_shipped") do
        invoice_5 = find_all(".invoice_5")
        invoice_5.each do |invoice|
          expect(invoice.text).to have_content("Invoice #5 - Wednesday, March 7, 2012")
          expect(invoice.text).to_not have_content("Invoice #5 - Wednesday, March 10, 2012")
          expect(invoice.text).to_not have_content("Invoice #5 -  2012-03-07 19:54:10 UTC")
        end

        invoice_7 = find_all(".invoice_7")
        invoice_7.each do |invoice|
          expect(invoice.text).to have_content("Invoice #7 - Wednesday, March 7, 2012")
          expect(invoice.text).to_not have_content("Invoice #7 - Wednesday, March 10, 2012")
          expect(invoice.text).to_not have_content("Invoice #7 -  2012-03-07 19:54:10 UTC")
        end

        invoice_3 = find_all(".invoice_3")
        invoice_3.each do |invoice|
          expect(invoice.text).to have_content("Invoice #3 - Saturday, March 10, 2012")
          expect(invoice.text).to_not have_content("Invoice #3 - Saturday, March 12, 2012")
          expect(invoice.text).to_not have_content("Invoice #3 - 2012-03-10 00:54:09 UTC")
        end

        invoice_2 = find_all(".invoice_2")
        invoice_2.each do |invoice|
          expect(invoice.text).to have_content("Invoice #2 - Monday, March 12, 2012")
          expect(invoice.text).to_not have_content("Invoice #2 - Monday, March 10, 2012")
          expect(invoice.text).to_not have_content("Invoice #2 -  2012-03-12 05:54:09 UTC")
        end

        invoice_4 = find_all(".invoice_4")
        invoice_4.each do |invoice|
          expect(invoice.text).to have_content("Invoice #4 - Saturday, March 24, 2012")
          expect(invoice.text).to_not have_content("Invoice #4 - Saturday, March 10, 2012")
          expect(invoice.text).to_not have_content("Invoice #4 -  2012-03-24 15:54:10 UTC")
        end

        invoice_1 = find_all(".invoice_1")
        invoice_1.each do |invoice|
          expect(invoice.text).to have_content("Invoice #1 - Sunday, March 25, 2012")
          expect(invoice.text).to_not have_content("Invoice #1 - Sunday, March 10, 2012")
          expect(invoice.text).to_not have_content("Invoice #1 -  2012-03-25 09:54:09 UTC")
        end
      end
    end
  end

  it "I see that the list is ordered from oldest to newest" do
    visit admin_dashboard_index_path

    within("#incomplete_invoices") do
      within("#invoice_id_not_shipped") do
        invoice_5 = find(".invoice_5", match: :first)
        invoice_7 = find(".invoice_7", match: :first)
        invoice_3 = find(".invoice_3", match: :first)
        invoice_2 = find(".invoice_2", match: :first)
        invoice_4 = find(".invoice_4", match: :first)
        invoice_1 = find(".invoice_1", match: :first)

        expect(invoice_5).to appear_before(invoice_7)
        expect(invoice_7).to appear_before(invoice_3)
        expect(invoice_3).to appear_before(invoice_2)
        expect(invoice_2).to appear_before(invoice_4)
        expect(invoice_4).to appear_before(invoice_1)
      end
    end
  end
end
