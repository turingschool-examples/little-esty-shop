# require 'rails_helper'

# RSpec.describe 'Application Pages' do
#   describe 'every page' do
#     before(:each) do
#       contributors_json_response = File.open("./fixtures/contributors.json")
#       pulls_json_response = File.open("./fixtures/pulls.json")
#       repo_json_response = File.open("./fixtures/repo.json")
  
#       stub_request(:get, "https://api.github.com/repos/aj-bailey/little-esty-shop").
#         to_return(status: 200, body: repo_json_response)
  
#       stub_request(:get, "https://api.github.com/repos/aj-bailey/little-esty-shop/pulls?state=closed").
#         to_return(status: 200, body: pulls_json_response)
  
#       stub_request(:get, "https://api.github.com/repos/aj-bailey/little-esty-shop/contributors").
#         to_return(status: 200, body: contributors_json_response)
#     end
    
#     it 'should have repository name, contributors, commits and pull requests' do
      
#       visit admin_path

#       within("footer") {
#         expect(page).to have_content("Repository name: little-esty-shop")
#         expect(page).to have_content("Number of Merged Pull Requests: 15")
#         expect(page).to have_content("hwryan12's commits: 63")
#         expect(page).to have_content("aj-bailey's commits: 56")
#         expect(page).to have_content("GreenGogh47's commits: 28")
#         expect(page).to have_content("DMTimmons1's commits: 22")

#       }
#     end
#   end
# end