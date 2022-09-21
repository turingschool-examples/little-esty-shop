require 'rails_helper'

RSpec.describe GithubFacade do
  it 'formats the service_response' do
    parsed = [
      {
        "committer": {
          "login": "gjcarew"
        }
      },
      {
        "committer": {
          "login": "gjcarew"
        }
      },
      {
        "committer": {
          "login": "gjcarew"
        }
      },
      {
        "committer": {
          "login": "stephenfabian" 
        }
      }
    ]
    service_response = double('service_response')
    response_body = double('response body')
    allow(GithubService).to receive(:commits).and_return(service_response)
    allow(service_response).to receive(:body).and_return(response_body)
    allow(JSON).to receive(:parse).and_return(parsed)
    expect(GithubFacade.commits).to eq({"gjcarew" => 3, "stephenfabian" => 1})
  end
end
