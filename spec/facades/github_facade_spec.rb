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
    
    describe '::user_commits' do
      it 'hash with username - commits ' do
        expect(GitHubFacade.user_commits).to eq({"LlamaBack"=>4, "Alaina-Noel"=>13, "ajkrumholz"=>10, "Astrid-Hecht"=>3})
      end
    end
  end
end