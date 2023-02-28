require 'pry'; binding.pry
class Commit #this is like the outline of the ruby object- the blueprint. DEFINES THE ATTRIBUTES 
      # attr_reader :commi

  def initialize(data)
    @author = data[:commit][:author][:name] 
  end

  def total_count 
    
  end

end