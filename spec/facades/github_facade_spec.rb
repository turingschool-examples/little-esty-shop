require 'rails_helper'

RSpec.describe GithubFacade do
  it 'formats the service_response' do
    service_response = [
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
    ].to_s

    allow(GithubService).to receive(:commits).and_return(JSON.parse(service_response))
    expect(GithubFacade.commits).to eq({"gjcarew" => 3, "stephenfabian" => 1})
  end
end