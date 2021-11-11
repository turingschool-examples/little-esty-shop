require 'rails_helper'

RSpec.describe GithubFacade do
  it 'constructs a GithubRepo object' do
    mock_response = '{
      "id": 423605286,
      "node_id": "R_kgDOGT-0Jg",
      "name": "little-esty-shop",
      "full_name": "haewonito/little-esty-shop",
      "private": false,
      "owner": {
      "login": "haewonito",
      "id": 86392608,
      "node_id": "MDQ6VXNlcjg2MzkyNjA4",
      "avatar_url": "https://avatars.githubusercontent.com/u/86392608?v=4",
      "gravatar_id": "",
      "url": "https://api.github.com/users/haewonito",
      "html_url": "https://github.com/haewonito",
      "followers_url": "https://api.github.com/users/haewonito/followers",
      "following_url": "https://api.github.com/users/haewonito/following{/other_user}",
      "gists_url": "https://api.github.com/users/haewonito/gists{/gist_id}",
      "starred_url": "https://api.github.com/users/haewonito/starred{/owner}{/repo}",
      "subscriptions_url": "https://api.github.com/users/haewonito/subscriptions",
      "organizations_url": "https://api.github.com/users/haewonito/orgs",
      "repos_url": "https://api.github.com/users/haewonito/repos",
      "events_url": "https://api.github.com/users/haewonito/events{/privacy}",
      "received_events_url": "https://api.github.com/users/haewonito/received_events",
      "type": "User",
      "site_admin": false
    }
    }'

    expect(GithubFacade.repository).to be_a GithubRepo
    expect(GithubFacade.repository.name).to eq "little-esty-shop"
  end
end
