require 'rails_helper'
require 'github_facade'

RSpec.describe GitHubFacade do
  describe 'class methods' do
    describe '::user_names' do
      it 'returns an array containing the names of all collaboraters on a github repo' do
        expect(GitHubFacade.user_names).to eq(%w[Alaina-Noel Astrid-Hecht LlamaBack ajkrumholz])
      end
    end

    describe '::repo_name' do
      it 'returns the origin repo name as s string' do
        expect(GitHubFacade.repo_name).to eq('little-esty-shop')
      end
    end
    
    describe '::user_commits' do
      it 'hash with username - commits ' do
        expect(GitHubFacade.user_commits).to eq({"LlamaBack"=>4, "Alaina-Noel"=>13, "ajkrumholz"=>10, "Astrid-Hecht"=>3})
      end
    end

    describe '::get_pr_total' do
      it 'returns the total number of closed prs' do
        expect(GitHubFacade.get_pr_total).to eq(119)
      end
    end
  end
end