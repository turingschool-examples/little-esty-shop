require "rails_helper"


RSpec.describe("welcome index page") do
  before(:each) do
    visit(root_path)
  end
  describe 'displays repo name' do
    it 'will show the repo name' do
      expect(page).to have_content("little-esty-shop")
    end
  end
end