class Image
  attr_reader :width, 
              :height, 
              :regular, 
              :full, 
              :thumb, 
              :small, 
              :alt_description, 
              :likes

  def initialize(data)
    @width = data[:width]
    @height = data[:height]
    @regular = data[:urls][:regular]
    @full = data[:urls][:full]
    @thumb = data[:urls][:thumb]
    @small = data[:urls][:small]
    @alt_description = data[:alt_description]
    @likes = data[:likes]
  end
end