require 'rails_helper'

RSpec.describe 'admin merchants index', type: :feature do
  before(:each) do
    @merch_1 = Merchant.create!(name: "Two-Legs Fashion")
    @merch_2 = Merchant.create!(name: "Buck-an-Ear Jewelry")
    @merch_3 = Merchant.create!(name: "Orange You Glad")
    @merch_4 = Merchant.create!(name: "Absolutely Authentic Autographs")
  end

  it "displays all merchants" do
    visit "admin/merchants"

    expect(page).to have_content(@merch_1.name)
    expect(page).to have_content(@merch_2.name)
    expect(page).to have_content(@merch_3.name)
    expect(page).to have_content(@merch_4.name)
  end

  it "links to merchants show page from merchants name" do
    visit "admin/merchants"
    click_link "Orange You Glad"
    expect(current_path).to eq("/admin/merchants/#{@merch_3.id}")
  end

  it 'has buttons next to each merchant that can enable/disable' do
    visit "/admin/merchants/"
    within "#disabled" do
        within "#merchant-#{@merch_1.id}" do
            expect(page).to_not have_button("Disable")
            click_button("Enable")
            expect(current_path).to eq("/admin/merchants/")
        end

        within "#merchant-#{@merch_4.id}" do
            expect(page).to_not have_button("Disable")
            click_button("Enable")
            expect(current_path).to eq("/admin/merchants/")
        end
    end

    within "#enabled" do
        save_and_open_page
        within "#merchant-#{@merch_1.id}" do
            expect(page).to_not have_button("Enable")
            click_button("Disable")
            expect(current_path).to eq("/admin/merchants/")
        end

        within "#merchant-#{@merch_4.id}" do
            expect(page).to_not have_button("Enable")
            click_button("Disable")
            expect(current_path).to eq("/admin/merchants/")
        end
    end
  end
end