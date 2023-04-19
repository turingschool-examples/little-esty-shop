class Photo
  attr_reader :data, :url, :likes

  def initialize(data)
    @data = data
    @url = data[:urls][:small]
    @likes = data[:likes]
  end
end