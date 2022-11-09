require 'HTTParty'
require 'json'

class RepoCall
  def call(url)
    response = HTTParty.get("https://api.github.com/users/kenzjoy")

    body = respone.body
  end
end