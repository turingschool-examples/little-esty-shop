require "rails_helper"

RSpec.describe "Admin Merchants New Page" do
  it "has form to create new merchant", :vcr do
    visit "/admin/merchants"
    expect(page).to_not have_content("Tummies McRubme")

    visit "/admin/merchants/new"

    fill_in('Name', with: 'Tummies McRubme')
    click_button("Submit")

    expect(current_path).to eq("/admin/merchants")
    expect(page).to have_content("Tummies McRubme")
  end
end
