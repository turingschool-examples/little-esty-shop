require 'rails_helper'

RSpec.describe GithubService do
  describe 'github repo service not at rate limit' do
    before(:each) do
      @service = GithubService.new

      @response = '[{
          "login": "matttoensing",
          "id": 80132364,
          "node_id": "MDQ6VXNlcjgwMTMyMzY0",
          "avatar_url": "https://avatars.githubusercontent.com/u/80132364?v=4",
          "gravatar_id": "",
          "url": "https://api.github.com/users/matttoensing",
          "html_url": "https://github.com/matttoensing",
          "followers_url": "https://api.github.com/users/matttoensing/followers",
          "following_url": "https://api.github.com/users/matttoensing/following{/other_user}",
          "gists_url": "https://api.github.com/users/matttoensing/gists{/gist_id}",
          "starred_url": "https://api.github.com/users/matttoensing/starred{/owner}{/repo}",
          "subscriptions_url": "https://api.github.com/users/matttoensing/subscriptions",
          "organizations_url": "https://api.github.com/users/matttoensing/orgs",
          "repos_url": "https://api.github.com/users/matttoensing/repos",
          "events_url": "https://api.github.com/users/matttoensing/events{/privacy}",
          "received_events_url": "https://api.github.com/users/matttoensing/received_events",
          "type": "User",
          "site_admin": false,
          "contributions": 82
        },
        {
          "login": "Bhjones45",
          "id": 81117044,
          "node_id": "MDQ6VXNlcjgxMTE3MDQ0",
          "avatar_url": "https://avatars.githubusercontent.com/u/81117044?v=4",
          "gravatar_id": "",
          "url": "https://api.github.com/users/Bhjones45",
          "html_url": "https://github.com/Bhjones45",
          "followers_url": "https://api.github.com/users/Bhjones45/followers",
          "following_url": "https://api.github.com/users/Bhjones45/following{/other_user}",
          "gists_url": "https://api.github.com/users/Bhjones45/gists{/gist_id}",
          "starred_url": "https://api.github.com/users/Bhjones45/starred{/owner}{/repo}",
          "subscriptions_url": "https://api.github.com/users/Bhjones45/subscriptions",
          "organizations_url": "https://api.github.com/users/Bhjones45/orgs",
          "repos_url": "https://api.github.com/users/Bhjones45/repos",
          "events_url": "https://api.github.com/users/Bhjones45/events{/privacy}",
          "received_events_url": "https://api.github.com/users/Bhjones45/received_events",
          "type": "User",
          "site_admin": false,
          "contributions": 56
        },
        {
          "login": "JasonPKnoll",
          "id": 78898641,
          "node_id": "MDQ6VXNlcjc4ODk4NjQx",
          "avatar_url": "https://avatars.githubusercontent.com/u/78898641?v=4",
          "gravatar_id": "",
          "url": "https://api.github.com/users/JasonPKnoll",
          "html_url": "https://github.com/JasonPKnoll",
          "followers_url": "https://api.github.com/users/JasonPKnoll/followers",
          "following_url": "https://api.github.com/users/JasonPKnoll/following{/other_user}",
          "gists_url": "https://api.github.com/users/JasonPKnoll/gists{/gist_id}",
          "starred_url": "https://api.github.com/users/JasonPKnoll/starred{/owner}{/repo}",
          "subscriptions_url": "https://api.github.com/users/JasonPKnoll/subscriptions",
          "organizations_url": "https://api.github.com/users/JasonPKnoll/orgs",
          "repos_url": "https://api.github.com/users/JasonPKnoll/repos",
          "events_url": "https://api.github.com/users/JasonPKnoll/events{/privacy}",
          "received_events_url": "https://api.github.com/users/JasonPKnoll/received_events",
          "type": "User",
          "site_admin": false,
          "contributions": 53
        },
        {
          "login": "BrianZanti",
          "id": 8962411,
          "node_id": "MDQ6VXNlcjg5NjI0MTE=",
          "avatar_url": "https://avatars.githubusercontent.com/u/8962411?v=4",
          "gravatar_id": "",
          "url": "https://api.github.com/users/BrianZanti",
          "html_url": "https://github.com/BrianZanti",
          "followers_url": "https://api.github.com/users/BrianZanti/followers",
          "following_url": "https://api.github.com/users/BrianZanti/following{/other_user}",
          "gists_url": "https://api.github.com/users/BrianZanti/gists{/gist_id}",
          "starred_url": "https://api.github.com/users/BrianZanti/starred{/owner}{/repo}",
          "subscriptions_url": "https://api.github.com/users/BrianZanti/subscriptions",
          "organizations_url": "https://api.github.com/users/BrianZanti/orgs",
          "repos_url": "https://api.github.com/users/BrianZanti/repos",
          "events_url": "https://api.github.com/users/BrianZanti/events{/privacy}",
          "received_events_url": "https://api.github.com/users/BrianZanti/received_events",
          "type": "User",
          "site_admin": false,
          "contributions": 51
        },
        {
          "login": "deebot10",
          "id": 57773546,
          "node_id": "MDQ6VXNlcjU3NzczNTQ2",
          "avatar_url": "https://avatars.githubusercontent.com/u/57773546?v=4",
          "gravatar_id": "",
          "url": "https://api.github.com/users/deebot10",
          "html_url": "https://github.com/deebot10",
          "followers_url": "https://api.github.com/users/deebot10/followers",
          "following_url": "https://api.github.com/users/deebot10/following{/other_user}",
          "gists_url": "https://api.github.com/users/deebot10/gists{/gist_id}",
          "starred_url": "https://api.github.com/users/deebot10/starred{/owner}{/repo}",
          "subscriptions_url": "https://api.github.com/users/deebot10/subscriptions",
          "organizations_url": "https://api.github.com/users/deebot10/orgs",
          "repos_url": "https://api.github.com/users/deebot10/repos",
          "events_url": "https://api.github.com/users/deebot10/events{/privacy}",
          "received_events_url": "https://api.github.com/users/deebot10/received_events",
          "type": "User",
          "site_admin": false,
          "contributions": 41
        },
        {
          "login": "timomitchel",
          "id": 23040094,
          "node_id": "MDQ6VXNlcjIzMDQwMDk0",
          "avatar_url": "https://avatars.githubusercontent.com/u/23040094?v=4",
          "gravatar_id": "",
          "url": "https://api.github.com/users/timomitchel",
          "html_url": "https://github.com/timomitchel",
          "followers_url": "https://api.github.com/users/timomitchel/followers",
          "following_url": "https://api.github.com/users/timomitchel/following{/other_user}",
          "gists_url": "https://api.github.com/users/timomitchel/gists{/gist_id}",
          "starred_url": "https://api.github.com/users/timomitchel/starred{/owner}{/repo}",
          "subscriptions_url": "https://api.github.com/users/timomitchel/subscriptions",
          "organizations_url": "https://api.github.com/users/timomitchel/orgs",
          "repos_url": "https://api.github.com/users/timomitchel/repos",
          "events_url": "https://api.github.com/users/timomitchel/events{/privacy}",
          "received_events_url": "https://api.github.com/users/timomitchel/received_events",
          "type": "User",
          "site_admin": false,
          "contributions": 9
        },
        {
          "login": "scottalexandra",
          "id": 8812335,
          "node_id": "MDQ6VXNlcjg4MTIzMzU=",
          "avatar_url": "https://avatars.githubusercontent.com/u/8812335?v=4",
          "gravatar_id": "",
          "url": "https://api.github.com/users/scottalexandra",
          "html_url": "https://github.com/scottalexandra",
          "followers_url": "https://api.github.com/users/scottalexandra/followers",
          "following_url": "https://api.github.com/users/scottalexandra/following{/other_user}",
          "gists_url": "https://api.github.com/users/scottalexandra/gists{/gist_id}",
          "starred_url": "https://api.github.com/users/scottalexandra/starred{/owner}{/repo}",
          "subscriptions_url": "https://api.github.com/users/scottalexandra/subscriptions",
          "organizations_url": "https://api.github.com/users/scottalexandra/orgs",
          "repos_url": "https://api.github.com/users/scottalexandra/repos",
          "events_url": "https://api.github.com/users/scottalexandra/events{/privacy}",
          "received_events_url": "https://api.github.com/users/scottalexandra/received_events",
          "type": "User",
          "site_admin": false,
          "contributions": 3
        },
        {
          "login": "jamisonordway",
          "id": 33180544,
          "node_id": "MDQ6VXNlcjMzMTgwNTQ0",
          "avatar_url": "https://avatars.githubusercontent.com/u/33180544?v=4",
          "gravatar_id": "",
          "url": "https://api.github.com/users/jamisonordway",
          "html_url": "https://github.com/jamisonordway",
          "followers_url": "https://api.github.com/users/jamisonordway/followers",
          "following_url": "https://api.github.com/users/jamisonordway/following{/other_user}",
          "gists_url": "https://api.github.com/users/jamisonordway/gists{/gist_id}",
          "starred_url": "https://api.github.com/users/jamisonordway/starred{/owner}{/repo}",
          "subscriptions_url": "https://api.github.com/users/jamisonordway/subscriptions",
          "organizations_url": "https://api.github.com/users/jamisonordway/orgs",
          "repos_url": "https://api.github.com/users/jamisonordway/repos",
          "events_url": "https://api.github.com/users/jamisonordway/events{/privacy}",
          "received_events_url": "https://api.github.com/users/jamisonordway/received_events",
          "type": "User",
          "site_admin": false,
          "contributions": 1
          }]'
          
          allow_any_instance_of(Faraday::Connection).to receive(:get).and_return(Faraday::Response.new)
          allow_any_instance_of(Faraday::Response).to receive(:body).and_return(@response)
        end

        it 'can show the contributors who have worked on this project' do
          expected =  ["matttoensing", "Bhjones45", "JasonPKnoll", "BrianZanti", "deebot10", "timomitchel", "scottalexandra", "jamisonordway"]

          expect(@service.contributors).to eq(expected)
        end

        it 'can show number of commits from each contributor' do
          expect(@service.contributors_commits).to eq([82, 56, 53, 51, 41, 9, 3, 1])
        end

        it 'can show contributor and number of commits for each' do

          expected = {"Bhjones45"=> 56,
                      "BrianZanti"=> 51,
                      "JasonPKnoll"=> 53,
                      "deebot10"=> 41,
                      "jamisonordway"=> 1,
                      "matttoensing"=> 82,
                      "scottalexandra"=> 3,
                      "timomitchel"=> 9}

            expect(@service.commits).to eq(expected)
          end
        end

        describe 'rate limit message' do
          before(:each) do
            @service = GithubService.new

            @response = @service.get_repo

            @rate_limit = '{
                "message": "API rate limit exceeded for 47.216.65.124. (But heres the good news: Authenticated requests get a higher rate limit. Check out the documentation for more details.)",
                "documentation_url": "https://docs.github.com/rest/overview/resources-in-the-rest-api#rate-limiting"
                }'

            @expected = "API rate limit exceeded for 47.216.65.124. (But heres the good news: Authenticated requests get a higher rate limit. Check out the documentation for more details.)"

            allow_any_instance_of(Faraday::Connection).to receive(:get).and_return(Faraday::Response.new)
            allow_any_instance_of(Faraday::Response).to receive(:body).and_return(@rate_limit)
          end

          it 'can show the rate limit error message' do
            expect(@service.contributors).to eq(@expected)
            expect(@service.commits).to eq(@expected)
            expect(@service.contributors_commits).to eq(@expected)
            expect(@service.pull_requests).to eq(@expected)
          end
        end

        describe 'pull requests' do
          it 'can show the number pull requests' do 
            service = GithubService.new
            pulls = '["pull_requests_1", "pull_requests_2", "pull_requests_3"]'

            allow_any_instance_of(Faraday::Connection).to receive(:get).and_return(Faraday::Response.new)
            allow_any_instance_of(Faraday::Response).to receive(:body).and_return(pulls)
            expect(service.pull_requests).to eq(3)
          end
        end

        describe 'repo name' do
          it 'can show the repo_name' do
            service = GithubService.new

            allow_any_instance_of(GithubService).to receive(:get_repo).and_return([1, 2, 3])

            repo = '{
            "id": 389769786,
            "node_id": "MDEwOlJlcG9zaXRvcnkzODk3Njk3ODY=",
            "name": "little-esty-shop",
            "full_name": "JasonPKnoll/little-esty-shop",
            "private": false }'

            allow_any_instance_of(Faraday::Connection).to receive(:get).and_return(Faraday::Response.new)
            allow_any_instance_of(Faraday::Response).to receive(:body).and_return(repo)
          
            expect(service.repo_name).to eq('little-esty-shop')
          end
        end
      end
