require 'httparty'

class GithubFacade
    def self.contributors
        response = HTTParty.get('https://api.github.com/repos/bensjsilverstein/little-esty-shop/contributors')

        body = response.body

        parsed = JSON.parse(body, symbolize_names: true)

        @githubs = parsed[:results].map do |contributor_data|
            Contributor.new(contributor_data)
        end
    end
end