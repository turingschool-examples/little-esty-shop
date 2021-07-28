require_relative 'spec_helper'

RSpec.describe API do
  it 'exists' do
    api = API.new

    expect(api.class).to eq(API)
    expect(API.repo_name).to eq('little-etsy-shop')
  end

  it 'can retrieve contributor endpoints' do
    expected = API.contributors

    expect(expected.class).to eq(Hash)
    expect(expected.keys.length).to eq(4)
    expect(expected.values.length).to eq(4)
    expect(expected[:taylor].split('/')[-1]).to eq('tvaroglu')
    expect(expected[:michael].split('/')[-1]).to eq('AbbottMichael')
    expect(expected[:elliot].split('/')[-1]).to eq('elliotolbright')
    expect(expected[:brian].split('/')[-1]).to eq('bfl3tch')
  end

  it 'can retrieve contribution endpoints' do
    expected = API.contributions

    expect(expected.class).to eq(Hash)
    expect(expected.keys.length).to eq(2)
    expect(expected.values.length).to eq(2)
    expect(expected[:commits]).to eq(
      'https://api.github.com/repos/bfl3tch/little-esty-shop/commits'
    )
    expect(expected[:pulls]).to eq(
      'https://api.github.com/repos/bfl3tch/little-esty-shop/pulls?state=closed'
    )
  end

  it 'can return a json blob from an API call' do
    mock_response = "{\"login\":\"tvaroglu\",\"id\":58891447,\"node_id\":\"MDQ6VXNlcjU4ODkxNDQ3\",\"avatar_url\":\"https://avatars.githubusercontent.com/u/58891447?v=4\",\"gravatar_id\":\"\",\"url\":\"https://api.github.com/users/tvaroglu\",\"html_url\":\"https://github.com/tvaroglu\",\"followers_url\":\"https://api.github.com/users/tvaroglu/followers\",\"following_url\":\"https://api.github.com/users/tvaroglu/following{/other_user}\",\"gists_url\":\"https://api.github.com/users/tvaroglu/gists{/gist_id}\",\"starred_url\":\"https://api.github.com/users/tvaroglu/starred{/owner}{/repo}\",\"subscriptions_url\":\"https://api.github.com/users/tvaroglu/subscriptions\",\"organizations_url\":\"https://api.github.com/users/tvaroglu/orgs\",\"repos_url\":\"https://api.github.com/users/tvaroglu/repos\",\"events_url\":\"https://api.github.com/users/tvaroglu/events{/privacy}\",\"received_events_url\":\"https://api.github.com/users/tvaroglu/received_events\",\"type\":\"User\",\"site_admin\":false,\"name\":\"TaylorV\",\"company\":\"Turing School of Software & Design\",\"blog\":\"\",\"location\":\"Boulder, CO\",\"email\":null,\"hireable\":null,\"bio\":null,\"twitter_username\":null,\"public_repos\":33,\"public_gists\":2,\"followers\":2,\"following\":4,\"created_at\":\"2019-12-14T20:43:15Z\",\"updated_at\":\"2021-07-15T23:58:58Z\"}"

    allow(API).to receive(:make_request).and_return(mock_response)
    expected = API.render_request(API.contributors[:taylor])

    expect(expected['url']).to eq(API.contributors[:taylor])
  end

  it 'can aggregate total commits by contributor' do
    mock_response = {
      "Elliot O" => ['commit_1', 'commit_2', 'commit_3', 'commit_4'],
      "Brian Fletcher" => ['commit_1', 'commit_2'],
      "TaylorV" => ['commit_1', 'commit_2', 'commit_3']
    }

    allow(API).to receive(:commits_by_author).and_return(mock_response)
    expected = API.aggregate_by_author(:commits)

    expect(expected.class).to eq(Hash)
    expect(expected.keys.length).to eq(3)
    expect(expected.values.length).to eq(3)
    expect(expected['Elliot O']).to eq(4)
    expect(expected['Brian Fletcher']).to eq(2)
    expect(expected['TaylorV']).to eq(3)
  end

  it 'can aggregate total pull requests by contributor' do
    mock_response = [
      {"state" => "closed", "title" => "PR #1",
        "user" => {"login" => "ElliotOlbright"}
      },
      {"state" => "closed", "title" => "PR #2",
        "user" => {"login" => "bfl3tch"}
      },
      {"state" => "closed", "title" => "PR #3",
        "user" => {"login" => "ElliotOlbright"}
      }
    ]
    allow(API).to receive(:render_request).and_return(mock_response)
    expected = API.aggregate_by_author(:pulls)

    expect(expected.class).to eq(Hash)
    expect(expected.keys.length).to eq(2)
    expect(expected.values.length).to eq(2)
    expect(expected['ElliotOlbright']).to eq(2)
    expect(expected['bfl3tch']).to eq(1)
  end

end
