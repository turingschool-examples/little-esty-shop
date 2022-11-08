require "rails_helper"

RSpec.describe("Welcome Index Page") do
  before(:each) do
    visit(root_path)
  end
  describe 'When I visit /' do
    describe "Then I see" do
      it 'the project repo name' do
        save_and_open_page
        expect(page).to have_content("little-esty-shop")
      end
    end
  end
end