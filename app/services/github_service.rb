require 'httpparty'

class GithubService # `service` is what's pulling in the data (located on a _search.rb page)
  def get_url(url) #this part here is making the API request
    response = HTTParty.get(url) #self.class
    parsed = JSON.parse(response.body, symbolize_names: true)
  end

  def commits 
    get_url() #paste in the URL endpoint 
  end

  def pull_requests
    get_url()
  end

  # def repo 

  # end

  # def username

  # end


end