require 'rails_helper'

RSpec.describe 'commit count api' do
	let!(:merchant1) { create(:active_merchant)}
	let!(:item1) {create(:item, merchant: merchant1, name: 'item 1')}
	let!(:customer1) { create(:customer)}
  let!(:invoice1) { create(:completed_invoice, customer: customer1, created_at: Date.new(2014, 4, 1))}
	let!(:users) { UsersSearch.new.usernames_and_commits }
  
  it "shows count of commits next to each contributors name" do
    visit "/admin/merchants/#{merchant1.id}"

    expect(page).to have_content("#{users.first.username} - #{users.first.commit_count} Commits")
    expect(page).to have_content("#{users.second.username} - #{users.second.commit_count} Commits")
    expect(page).to have_content("#{users.third.username} - #{users.third.commit_count} Commits")
    expect(page).to have_content("#{users.last.username} - #{users.last.commit_count} Commits")
  end

  it "show repo_name of 'little-esty-shop' on admin merchant index page" do
    visit "/admin/merchants"

    expect(page).to have_content("#{users.first.username} - #{users.first.commit_count} Commits")
    expect(page).to have_content("#{users.second.username} - #{users.second.commit_count} Commits")
    expect(page).to have_content("#{users.third.username} - #{users.third.commit_count} Commits")
    expect(page).to have_content("#{users.last.username} - #{users.last.commit_count} Commits")
  end

  it "show repo_name of 'little-esty-shop' on the merchant show page" do
    visit "/merchants/#{merchant1.id}"

    expect(page).to have_content("#{users.first.username} - #{users.first.commit_count} Commits")
    expect(page).to have_content("#{users.second.username} - #{users.second.commit_count} Commits")
    expect(page).to have_content("#{users.third.username} - #{users.third.commit_count} Commits")
    expect(page).to have_content("#{users.last.username} - #{users.last.commit_count} Commits")
  end

  it "show repo_name of 'little-esty-shop' merchant items index page" do
    visit "/merchants/#{merchant1.id}/items"

		expect(page).to have_content("#{users.first.username} - #{users.first.commit_count} Commits")
    expect(page).to have_content("#{users.second.username} - #{users.second.commit_count} Commits")
    expect(page).to have_content("#{users.third.username} - #{users.third.commit_count} Commits")
    expect(page).to have_content("#{users.last.username} - #{users.last.commit_count} Commits")
  end
end