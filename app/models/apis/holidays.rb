module APIS
  class Holidays

    def initialize(response_body)
      @response_body = response_body
    end

    def all_holidays
      grouping = Hash.new(0)
      all_holidays = []
      @response_body.each do |holiday, hash|
        if !holiday['name'].nil?
            all_holidays << holiday['name']
            grouping[holiday] += 1
        end
      end
      all_holidays
    end

  end
end
