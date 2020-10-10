class Channel 
  attr_reader :name, :topic, :member_count, :id

  def initialize(name, topic, member_count, id)
    @name = name
    @topic = topic
    @member_count = member_count
    @id = id
  end

  def details
    return "Name: #{@name}. Topic: #{@topic}. Member count: #{@member_count}. ID: #{@id}."
  end
end