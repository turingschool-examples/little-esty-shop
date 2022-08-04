class Contributor 
    attr_reader :username
    
    def initialize(data)
        @username = data[:login]
    end
end