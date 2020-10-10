require "httparty"
require "dotenv"
require "awesome_print"
require_relative "user.rb"
require_relative "channel.rb"

Dotenv.load

GET_USER_PATH = "https://slack.com/api/users.list"

GET_CHANNEL_PATH = "https://slack.com/api/conversations.list"

GET_MESSAGE_PATH = "https://slack.com/api/chat.postMessage"


class Workspace
  attr_reader :users, :channels

  def initialize
    @users = []
    @channels = []
  end

  def get_users
    user_response = HTTParty.get(GET_USER_PATH, query: { token: ENV["SLACK_TOKEN"] })

    @users = user_response["members"].map do |member|
      User.new(member["name"], member["real_name"], member["id"])
    end

    return @users
  end

  def select_user(user_or_id)
    selected_user = self.get_users
      .select { |user| user.name == user_or_id || user.id == user_or_id }
      .first
    return selected_user
  end

  def get_channels
    channel_response = HTTParty.get(GET_CHANNEL_PATH, query: { token: ENV["SLACK_TOKEN"] })

    @channels = channel_response["channels"].map do |channel|
      Channel.new(channel["name"], channel["topic"]["value"], channel["num_members"], channel["id"])
    end
    return @channels
  end

  def select_channel(name_or_id)
    selected_channel = self.get_channels
      .select { |channel| channel.name == name_or_id || channel.id == name_or_id }
      .first
    return selected_channel
  end


  def send_message(recipient_name, message)
    user_response = HTTParty.post(GET_MESSAGE_PATH, body: { 
      token: ENV["SLACK_TOKEN"], 
      channel: recipient_name,
      text: message
      })
  end

end
