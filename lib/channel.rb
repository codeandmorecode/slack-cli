class Channel #< Recipient
  attr_reader :name, :topic, :member_count, :slack_id

  def initialize(name, topic, member_count, slack_id)
    @name = name
    @topic = topic
    @member_count = member_count
    @slack_id = slack_id
  end
end