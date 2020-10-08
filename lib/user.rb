
class User #< Recipient
  attr_reader :username, :name, :id

  def initialize(username, name, id)
    @username = username
    @name = name
    @id = id
  end

end