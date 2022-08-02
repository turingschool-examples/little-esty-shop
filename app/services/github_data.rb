class GithubData 
    attr_reader :login, :commits 

    def initialize(data)
        @login = data[:login]
        @commits = data[:contributions]
    end 

end 