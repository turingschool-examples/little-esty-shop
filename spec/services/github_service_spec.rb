require 'rails_helper'

RSpec.describe GithubService do
  # stories live here
  describe 'endpoint consumption' do # endpoint is anything after the dot.com
    xit 'retrieves repo data from endpoint', :vcr do # tells it we are making a fetch call and records it in the cassette
      githubservice_instance = GithubService.new
      json = githubservice_instance.repo # specifying route
      expect(json).to have_key(:name) # comes from api github browser - changes strings to symbols in the base server
    end
  end
end
