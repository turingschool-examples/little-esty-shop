module APIS
  class RepoName

    def initialize(endpoints)
      @endpoint_name = endpoints[:commits]
    end

    def format
      raw_string = @endpoint_name.split('/')[-2]
      raw_string.split('-').map do |section|
        section.capitalize + ' '
      end.join[0..-2]
    end

  end
end
