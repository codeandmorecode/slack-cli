require "httparty"
require "dotenv"
require "awesome_print"
require_relative "user.rb"
require_relative "channel.rb"

Dotenv.load

GET_USER_PATH = "https://slack.com/api/users.list"

GET_CHANNEL_PATH = "https://slack.com/api/conversations.list"

class Workspace
  attr_reader :users, :channels

  def initialize
    @users = []
    @channels = []
  end

  def get_users
    user_response = HTTParty.get(GET_USER_PATH, query: { token: ENV["SLACK_TOKEN"] })

    @users = user_response["members"].map do |member|
      # {
      #   :username => member["name"],
      #   :name => member["real_name"],
      #   :id => member["id"],
      #
      # }
      User.new(member["name"], member["real_name"], member["id"])
    end

    return @users
  end

  def get_channels
    channel_response = HTTParty.get(GET_CHANNEL_PATH, query: { token: ENV["SLACK_TOKEN"] })

    @channels = channel_response["channels"].map do |channel|
      # {
      #     :name => channel["name"],
      #     :topic => channel["topic"]["value"],
      #     :member_count => channel["num_members"],
      #     :slack_id => channel["id"]
      # }
      Channel.new(channel["name"], channel["topic"]["value"], channel["num_members"], channel["id"])
    end

    return @channels
  end
end

# workspace = Workspace.new
# ap workspace.get_users
# puts "~~~~~~~~~"
# ap workspace.get_channels
