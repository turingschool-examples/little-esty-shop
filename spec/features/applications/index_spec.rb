require 'rails_helper'

RSpec.describe "application controller index page" do
  describe '#index' do
    xit 'shows the commits and usernames of the github users' do
      visit '/'
      expect(page).to have_content("brycesimonds")
    end
  end 
end 