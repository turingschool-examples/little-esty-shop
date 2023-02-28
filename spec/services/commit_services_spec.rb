require 'rails_helper'
require './app/services/github_service.rb'
require './app/poros/commits/commit_search.rb'


RSpec.describe 'commits API' do
  describe 'when I make a call to the Commits API' do
    it "make a call to the commit API and returns data regarding the commits" do 

      expect(CommitSearch.new.commit_information)

    end
  end 
end 