class Github
  attr_reader  :name,
               :full_name,
               :html_url

  def initialize(data)
    @name = data[:name]
    @full_name = data[:full_name]
    @html_url = data[:html_url]
  end
end
