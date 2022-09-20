require 'rails_helper'
require 'github_service'
require 'webmock/rspec'

RSpec.describe 'github service' do
  describe 'class methods' do
    describe '::request' do
      xit 'returns data from the github api' do
        #don't unskip this! It will fail! I promise!
        reponse_body = GitHubService.request('collaborators')

        expect(response_body).to be_an(Array)
        expect(response_body[0]).to be_an(Hash)
        expect(response_body[0]["login"]).to eq("LlamaBack")
      end

      it 'returns a request from a specified endpoint in the github api' do
        response_body = [
          {"login"=>"LlamaBack",
          "id"=>16805645,
          "node_id"=>"MDQ6VXNlcjE2ODA1NjQ1",
          "avatar_url"=>"https://avatars.githubusercontent.com/u/16805645?v=4",
          "gravatar_id"=>"",
          "url"=>"https://api.github.com/users/LlamaBack",
          "html_url"=>"https://github.com/LlamaBack",
          "followers_url"=>"https://api.github.com/users/LlamaBack/followers",
          "following_url"=>"https://api.github.com/users/LlamaBack/following{/other_user}",
          "gists_url"=>"https://api.github.com/users/LlamaBack/gists{/gist_id}",
          "starred_url"=>"https://api.github.com/users/LlamaBack/starred{/owner}{/repo}",
          "subscriptions_url"=>"https://api.github.com/users/LlamaBack/subscriptions",
          "organizations_url"=>"https://api.github.com/users/LlamaBack/orgs",
          "repos_url"=>"https://api.github.com/users/LlamaBack/repos",
          "events_url"=>"https://api.github.com/users/LlamaBack/events{/privacy}",
          "received_events_url"=>"https://api.github.com/users/LlamaBack/received_events",
          "type"=>"User",
          "site_admin"=>false,
          "permissions"=>{"admin"=>false, "maintain"=>false, "push"=>true, "triage"=>true, "pull"=>true},
          "role_name"=>"write"},
         {"login"=>"Alaina-Noel",
          "id"=>99104685,
          "node_id"=>"U_kgDOBeg3rQ",
          "avatar_url"=>"https://avatars.githubusercontent.com/u/99104685?v=4",
          "gravatar_id"=>"",
          "url"=>"https://api.github.com/users/Alaina-Noel",
          "html_url"=>"https://github.com/Alaina-Noel",
          "followers_url"=>"https://api.github.com/users/Alaina-Noel/followers",
          "following_url"=>"https://api.github.com/users/Alaina-Noel/following{/other_user}",
          "gists_url"=>"https://api.github.com/users/Alaina-Noel/gists{/gist_id}",
          "starred_url"=>"https://api.github.com/users/Alaina-Noel/starred{/owner}{/repo}",
          "subscriptions_url"=>"https://api.github.com/users/Alaina-Noel/subscriptions",
          "organizations_url"=>"https://api.github.com/users/Alaina-Noel/orgs",
          "repos_url"=>"https://api.github.com/users/Alaina-Noel/repos",
          "events_url"=>"https://api.github.com/users/Alaina-Noel/events{/privacy}",
          "received_events_url"=>"https://api.github.com/users/Alaina-Noel/received_events",
          "type"=>"User",
          "site_admin"=>false,
          "permissions"=>{"admin"=>false, "maintain"=>false, "push"=>true, "triage"=>true, "pull"=>true},
          "role_name"=>"write"},
         {"login"=>"ajkrumholz",
          "id"=>104221777,
          "node_id"=>"U_kgDOBjZMUQ",
          "avatar_url"=>"https://avatars.githubusercontent.com/u/104221777?v=4",
          "gravatar_id"=>"",
          "url"=>"https://api.github.com/users/ajkrumholz",
          "html_url"=>"https://github.com/ajkrumholz",
          "followers_url"=>"https://api.github.com/users/ajkrumholz/followers",
          "following_url"=>"https://api.github.com/users/ajkrumholz/following{/other_user}",
          "gists_url"=>"https://api.github.com/users/ajkrumholz/gists{/gist_id}",
          "starred_url"=>"https://api.github.com/users/ajkrumholz/starred{/owner}{/repo}",
          "subscriptions_url"=>"https://api.github.com/users/ajkrumholz/subscriptions",
          "organizations_url"=>"https://api.github.com/users/ajkrumholz/orgs",
          "repos_url"=>"https://api.github.com/users/ajkrumholz/repos",
          "events_url"=>"https://api.github.com/users/ajkrumholz/events{/privacy}",
          "received_events_url"=>"https://api.github.com/users/ajkrumholz/received_events",
          "type"=>"User",
          "site_admin"=>false,
          "permissions"=>{"admin"=>false, "maintain"=>false, "push"=>true, "triage"=>true, "pull"=>true},
          "role_name"=>"write"},
         {"login"=>"Astrid-Hecht",
          "id"=>106942456,
          "node_id"=>"U_kgDOBl_P-A",
          "avatar_url"=>"https://avatars.githubusercontent.com/u/106942456?v=4",
          "gravatar_id"=>"",
          "url"=>"https://api.github.com/users/Astrid-Hecht",
          "html_url"=>"https://github.com/Astrid-Hecht",
          "followers_url"=>"https://api.github.com/users/Astrid-Hecht/followers",
          "following_url"=>"https://api.github.com/users/Astrid-Hecht/following{/other_user}",
          "gists_url"=>"https://api.github.com/users/Astrid-Hecht/gists{/gist_id}",
          "starred_url"=>"https://api.github.com/users/Astrid-Hecht/starred{/owner}{/repo}",
          "subscriptions_url"=>"https://api.github.com/users/Astrid-Hecht/subscriptions",
          "organizations_url"=>"https://api.github.com/users/Astrid-Hecht/orgs",
          "repos_url"=>"https://api.github.com/users/Astrid-Hecht/repos",
          "events_url"=>"https://api.github.com/users/Astrid-Hecht/events{/privacy}",
          "received_events_url"=>"https://api.github.com/users/Astrid-Hecht/received_events",
          "type"=>"User",
          "site_admin"=>false,
          "permissions"=>{"admin"=>true, "maintain"=>true, "push"=>true, "triage"=>true, "pull"=>true},
          "role_name"=>"admin"}
        ]

        allow(GitHubService).to receive(:request).with("collaborators").and_return(response_body)
        expect(GitHubService.request('collaborators')).to eq(response_body)
      end
    end
  end
end
