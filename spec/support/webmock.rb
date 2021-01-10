RSpec.configure do |config|
  config.before(:each) do
    repo_response = File.read("spec/fixtures/gh_repo_name.json")
    WebMock.stub_request(:get, "https://api.github.com/repos/cunninghamge/little-esty-shop").to_return(status: 200, body: repo_response)

    contributors_response = File.read("spec/fixtures/gh_contributors.json")
    WebMock.stub_request(:get, "https://api.github.com/repos/cunninghamge/little-esty-shop/contributors").to_return(status: 200, body: contributors_response)
    
    pulls_response = File.read("spec/fixtures/gh_pulls.json")
    WebMock.stub_request(:get, "https://api.github.com/repos/cunninghamge/little-esty-shop/pulls?state=closed").to_return(status: 200, body: pulls_response)
   end
end
