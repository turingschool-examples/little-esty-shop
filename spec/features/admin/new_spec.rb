require "rails_helper"

RSpec.describe "Admin Merchants New Page" do
  it "has form to create new merchant" do
    visit "/admin/merchants/new"

    fill_in('Name', with: 'Tummies McRubme')
    click_button("Submit")

    expect(current_path).to eq("/admin/merchants")
  end
end
