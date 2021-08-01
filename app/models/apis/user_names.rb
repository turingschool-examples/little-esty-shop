module APIS
  class UserNames

    def initialize(endpoints)
      @endpoints = endpoints
    end

    def format
      grouping = Hash.new
      @endpoints.each do |user, endpoint_name|
        grouping[user] = endpoint_name.split('=')[-1]
      end
      grouping
    end

  end
end
