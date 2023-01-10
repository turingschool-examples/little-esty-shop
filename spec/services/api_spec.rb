require 'rails_helper'
require './app/services/github_service.rb'
require './app/services/github_info.rb'

RSpec.describe 'API and Service classes' do
  it 'does' do
    info = GithubInfo.new
  end
end