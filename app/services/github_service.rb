require 'httpparty'

class GithubService #services is what's pulling in the data 
  def get_url(url) #this part here is making the API request
    response = HTTParty.get(url) #self.class
    parsed = JSON.parse(response.body, symbolize_names: true)
  end

  def commits 
    get_url() #paste in the URL endpoint 
  end

  # def pull_request

  # end

  # def repo 

  # end

  # def username

  # end


end