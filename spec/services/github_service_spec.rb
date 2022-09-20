require 'rails_helper'
require 'github_service'
require 'webmock/rspec'

RSpec.describe 'github service' do
  describe 'class methods' do
    describe '::request' do
      it 'returns a request from a specified endpoint in the github api' do

        expect(GitHubService.request('collaborators')).to eq({})
      
      
      end
    end
  end
end