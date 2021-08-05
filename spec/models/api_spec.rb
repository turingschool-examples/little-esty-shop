require 'rails_helper'

RSpec.describe API do
  it 'exists' do
    api = API.new

    expect(api.class).to eq(API)
    expect(API.repo_name).to eq('Little Esty Shop')
  end

  it 'can retrieve contributor user names from contributor endpoints' do
    expected = API.user_names

    expect(expected.class).to eq(Hash)
    expect(expected.keys.length).to eq(4)
    expect(expected.values.length).to eq(4)
    expect(expected[:taylor]).to eq('tvaroglu')
    expect(expected[:michael]).to eq('AbbottMichael')
    expect(expected[:elliot]).to eq('ElliotOlbright')
    expect(expected[:brian]).to eq('bfl3tch')
  end

  it 'can retrieve contribution endpoints and default return values' do
    expected = API.contributions

    expect(expected.class).to eq(Hash)
    expect(expected.keys.length).to eq(3)
    expect(expected.values.length).to eq(3)
    expect(expected[:commits]).to eq(API.contributors)
    expect(expected[:pulls]).to eq(
      'https://api.github.com/repos/bfl3tch/little-esty-shop/pulls?state=closed')
    expect(expected[:defaults][:commits]).to eq(
      {'tvaroglu' => 45, 'AbbottMichael' => 23, 'ElliotOlbright' => 35, 'bfl3tch' => 26})
    expect(expected[:defaults][:pulls]).to eq(
      {'tvaroglu' => 6, 'AbbottMichael' => 6, 'ElliotOlbright' => 10, 'bfl3tch' => 7})
  end

  it 'can initialize contributor endpoints to parse requests' do
    mock_response = [
      {"sha"=>"12345",
        "committer"=> {"name"=>"GitHub", "email"=>"noreply@github.com"},
        "author"=> {"login"=>"tvaroglu", "id"=>12345}}
      ]
    expected = APIS::RenderRequest.new(API.contributors)
    expect(expected.endpoint_arr).to eq(API.contributors.values)

    allow(API).to receive(:make_request).and_return(mock_response.first.to_json)
    expect(expected.parse.first).to eq(mock_response.first)
  end

  it 'can return a json blob from an API call' do
    mock_response = "{\"login\":\"tvaroglu\",\"id\":58891447,\"url\":\"https://api.github.com/users/tvaroglu\"}"
    allow(Faraday).to receive(:get).and_return(mock_response)

    expected = API.render_request(API.contributors[:taylor])
    expect(expected['login']).to eq('tvaroglu')
  end

  it 'can aggregate total commits by contributor' do
    mock_response = [
      {"sha"=>"12345",
        "committer"=> {"name"=>"GitHub", "email"=>"noreply@github.com"},
        "author"=> {"login"=>"tvaroglu", "id"=>12345}},
      {"sha"=>"67891",
        "committer"=> {"name"=>"GitHub", "email"=>"noreply@github.com"},
        "author"=> {"login"=>"bfl3tch", "id"=>67891}},
      {"sha"=>"23456",
        "committer"=> {"name"=>"GitHub", "email"=>"noreply@github.com"},
        "author"=> {"login"=>"tvaroglu", "id"=>23456}},
      ]

    allow(API).to receive(:render_request).and_return(mock_response)
    expected = API.aggregate_by_author(:commits)

    expect(expected.class).to eq(Hash)
    expect(expected.keys.length).to eq(2)
    expect(expected.values.length).to eq(2)
    expect(expected['tvaroglu']).to eq(2)
    expect(expected['bfl3tch']).to eq(1)
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

  it 'can return an empty hash if the API rate limit is hit' do
    mock_response = {"message" => "API rate limit exceeded"}
    allow(API).to receive(:render_request).and_return(mock_response)

    expect(API.aggregate_by_author(:pulls)).to eq({})
    expect(API.aggregate_by_author(:commits)).to eq({})
  end

end
