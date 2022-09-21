require 'rails_helper'
require 'github_facade'

RSpec.describe GitHubFacade do
  describe 'class methods' do
    describe '::user_names' do
      xit 'returns an array containing the names of all collaboraters on a github repo' do
        expect(GitHubFacade.user_names).to eq(%w[ajkrumholz AlainaKneiling AstridHecht LlamaBack])
      end
    end

    describe '::repo_name' do
      xit 'returns the origin repo name as s string' do
        expect(GitHubFacade.repo_names).to eq('little-esty-shop')
      end
    end
  end
end