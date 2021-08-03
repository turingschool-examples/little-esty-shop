module APIS
  class UserNames

    def initialize(endpoints)
      @endpoints = endpoints
    end

    def format
      grouping = Hash.new
      @endpoints.each do |user, endpoint_name|
        grouping[user] = endpoint_name.split('?author=')[-1].delete_suffix('&per_page=100')
      end
      grouping
    end

  end
end
