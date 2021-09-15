require 'rails_helper'

RSpec.describe 'admin merchants edit page' do
  before :each do
    @merchant_1 = Merchant.create!(name: "Bob", id: 1, created_at:" 2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
    @merchant_2 = Merchant.create!(name: "Sara", id: 2, created_at:" 2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
  end

  it 'has a form to update merchant' do
    visit "/admin/merchants/#{@merchant_1.id}/edit"
    fill_in :name, with: "Bob Johnson"
    fill_in :id, with: "#{@merchant_1.id}"
    fill_in :created_at, with: "#{@merchant_1.created_at}"
    fill_in :updated_at, with: "#{@merchant_1.updated_at}"
    click_on("Submit")
    expect(current_path).to eq("/admin/merchants/#{@merchant_1.id}")
    expect(page).to have_content("Bob Johnson")
    expect(page).to have_content("Merchant has been updated")
  end

  it 'has a flash message for incomplete update form' do
    visit "/admin/merchants/#{@merchant_1.id}/edit"
    fill_in :name, with: "Bob Johnson"
    fill_in :id, with: "#{@merchant_1.id}"
    fill_in :created_at, with: "#{@merchant_1.created_at}"
    click_on("Submit")
    expect(current_path).to eq("/admin/merchants/#{@merchant_1.id}/edit")
    expect(page).to have_content("Error: Updated at can't be blank")
  end
end
