class Repo 
    attr_reader :name, :url
    def initialize(data)
        @name = data[:full_name]
        @url = data[:html_url]
    end
end