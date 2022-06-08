require 'rails_helper'

RSpec.describe "Layout application view page" do

  it "shows the repo name at the top of every page ", :vcr do
    visit admin_invoices_path
    expect(page).to have_content("Repo Name: little-esty-shop")
    visit admin_merchants_path
    expect(page).to have_content("Repo Name: little-esty-shop")
  end

  it "shows all Collaborators for the project", :vcr do
    visit admin_invoices_path
    expect(page).to have_content("Collaborators:")
    expect(page).to have_content("NickJacobsss")
    visit admin_merchants_path
    expect(page).to have_content("Repo Name: little-esty-shop")
    expect(page).to have_content("SaiHall")
  end

  it "shows merged pull requests", :vcr do
    visit admin_invoices_path
    expect(page).to have_content("Merged Pull Requests: 30")
    visit admin_merchants_path
    expect(page).to have_content("Merged Pull Requests: 30")
  end

  it "shows commits next to each Collaborator", :vcr do
    visit admin_invoices_path
    expect(page).to have_content("NickJacobsss, Commits: 79")
    visit admin_merchants_path
    expect(page).to have_content("deannahburke, Commits: 35")
  end
end
