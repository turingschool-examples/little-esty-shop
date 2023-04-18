class Photo
  attr_reader :id,
              :thumb_url,
              :small_url,
              :regular_url,
              :full_url,
              :description,
              :likes,
              :width,
              :height

  def initialize(data)
    @id = data[:id]
    @thumb_url = data[:urls][:thumb]
    @small_url = data[:urls][:small]
    @regular_url = data[:urls][:regular]
    @full_url = data[:urls][:full]
    @description = data[:description]
    @likes = data[:likes]
    @width = data[:width]
    @height = data[:height]
  end
end
