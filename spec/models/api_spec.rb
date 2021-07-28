require 'rails_helper'

RSpec.describe API do
  it 'exists' do
    api = API.new

    expect(api.class).to eq(API)
    expect(API.repo_name).to eq('Little Esty Shop')
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
    mock_response = "{\"login\":\"tvaroglu\",\"id\":58891447,\"node_id\":\"MDQ6VXNlcjU4ODkxNDQ3\",\"avatar_url\":\"https://avatars.githubusercontent.com/u/58891447?v=4\",\"gravatar_id\":\"\",\"url\":\"https://api.github.com/users/tvaroglu\"}"

    allow(Faraday).to receive(:get).and_return(mock_response)
    expected = API.render_request(API.contributors[:taylor])

    expect(expected['url']).to eq(API.contributors[:taylor])
  end

  it 'can aggregate total commits by contributor' do
    mock_response = [
      {"sha" => "commit12345",
        "commit" => {"author" =>
          {"name" => "TaylorV", "date" => "2021-07-28T04:02:25Z"}}},
      {"sha" => "commit23456",
        "commit" => {"author" =>
          {"name" => "Brian Fletcher", "date" => "2021-07-28T04:02:25Z"}}},
      {"sha" => "commit34567",
        "commit" => {"author" =>
          {"name" => "TaylorV", "date" => "2021-07-28T04:02:25Z"}}}
    ]
    allow(API).to receive(:render_request).and_return(mock_response)
    expected = API.aggregate_by_author(:commits)

    expect(expected.class).to eq(Hash)
    expect(expected.keys.length).to eq(2)
    expect(expected.values.length).to eq(2)
    expect(expected['Brian Fletcher']).to eq(1)
    expect(expected['TaylorV']).to eq(2)
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
