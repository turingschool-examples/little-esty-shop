class Commit
    attr_reader :commit, :name, :username
    def initialize(data)
        @commit = data[:commit]
        @name = data[:commit][:author][:name]
        @username = data[:author][:login]
    end
end