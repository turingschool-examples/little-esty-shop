module APIS
  class Commits

    def initialize(response_body)
      @response_body = response_body
    end

    def aggregate
      grouping = Hash.new(0)
      grouping['commits'] = @response_body.group_by {|author| author['commit']['author']['name']}
    end

    def total_count_by_author
      totals = Hash.new(0)
      aggregate.each do |author, commits|
        totals[author] = commits.length if author != 'Brian Zanti' && author != 'Jamison Ordway'
      end
      totals
    end

  end
end
