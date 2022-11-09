require "rails_helper"


RSpec.describe("Welcome Index Page") do
  before(:each) do
    visit(root_path)
  end

  describe("When I visit /") do
    describe("Then I see") do
      it("the project repo name") do
        expect(page).to(have_content("little-esty-shop"))
      end

      it("the contributor names and number of commits") do
        expect(page).to(have_content("ashuhleyt: 13"))
        # expect(page).to(have_content("josephhilby: 54"))
        # expect(page).to(have_content("amikaross: 47"))
        # expect(page).to(have_content("AlexMR-93: 21"))
      end

      it("the latest total number of PRs") do
        expect(page).to(have_content("Number of Pull Requests: 37"))
      end
    end
  end
end
