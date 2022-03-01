class Contributor 
    attr_reader :username, :url, :data
    def initialize(data)
        @data = data
        @username = data[:login]
        @url = data[:html_url]
    end
end
