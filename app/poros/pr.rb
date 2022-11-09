class Pr 
  attr_reader :num_prs, :author 
  def initialize (data)
    @num_prs = data[:number] #or merged_at?
    @author = data[:user][:login]
  end
end