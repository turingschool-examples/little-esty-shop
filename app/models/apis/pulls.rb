module APIS
  class Pulls

    def initialize(response_body)
      @response_body = response_body
    end

    def total_count_by_author
      grouping = Hash.new(0)
      @response_body.each do |pr, hash|
        if !pr['user'].nil?
          author = pr['user']['login']
          grouping[author] += 1
        end
      end
      grouping
    end

  end
end
