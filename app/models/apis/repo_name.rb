module APIS
  class RepoName

    def initialize(endpoint_name)
      @endpoint_name = endpoint_name
    end

    def format
      raw_string = @endpoint_name.split('/')[-2]
      raw_string.split('-').map do |section|
        section.capitalize + ' '
      end.join[0..-2]
    end

  end
end
