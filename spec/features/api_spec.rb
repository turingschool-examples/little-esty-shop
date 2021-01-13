require 'rails_helper'

RSpec.describe "API page" do
  it "displays the repo name" do
    visit admin_path

    within("#api-block") do
      expect(page).to have_content("little-esty-shop")
    end
  end

  it "display number of commits next to each github collaborator's name" do
    contributors = ["BrianZanti", "GrayMyers", "ribbansmax", "cunninghamge", "timomitchel", "ninesky00", "scottalexandra"]
    visit admin_path

    within("#api-block") do
      contributors.each do |c|
        expect(page).to have_content(c)
      end

      page.find_all('li').each do |element|
        within(element) do
          expect(page).to have_content('commits') #doesn't actually check commit numbers here
        end
      end
    end
  end

  it "displays number of merged PRs across all team members" do
    visit admin_path

    within("#api-block") do
      expect(page).to have_content('merged pull requests')
      expect(page.find("#pull-requests").text.split(" ").last.to_i).to be > 0
    end

  end
end
