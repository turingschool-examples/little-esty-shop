require 'rails_helper'
require './app/poros/github_service'

RSpec.describe GitHubService do 
  it 'calls an api' do 
    service = GitHubService.new
    service.collaborators_information
  end
end