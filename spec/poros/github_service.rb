require 'rails_helper'
require './app/poros/github_service'

RSpec.describe GitHubService do 
  it 'calls an api' do 
    service = GitHubService.new
    service.repo_information
  end
end