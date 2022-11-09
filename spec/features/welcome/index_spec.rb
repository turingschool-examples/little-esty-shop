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
    end
  end

  describe("displays contributors names") do
    it("will list contributor names") do
      expect(page).to(have_content("ashuhleyt"))
    end
  end

  describe("displays latest number of PRs") do
    it("will displays latest number of PRs") do
      expect(page).to(have_content(35))
    end
  end
end
