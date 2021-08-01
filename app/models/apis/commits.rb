module APIS
  class Commits

    def initialize(response_body)
      @response_body = response_body
    end

    def aggregate
      grouping = Hash.new(0)
      if @response_body.class == Array
      # if !@response_body['message'].include?('rate limit exceeded')
        # grouping['commits'] = @response_body.group_by {|author| author['committer']['login']}
        grouping['commits'] = @response_body.group_by {|author| author['author']['login']}
      else
        grouping['commits'] = Array.new
      end
    end

    def total_count_by_author
      totals = Hash.new(0)
      aggregate.each do |author, commits|
        # totals[author] = commits.length if author != 'web-flow'
        totals[author] = commits.length if !author.nil?
      end
      totals
    end

  end
end
