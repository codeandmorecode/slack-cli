#!/usr/bin/env ruby

require_relative "workspace"
require "dotenv"
require "httparty"
require "awesome_print"
require "table_print"

Dotenv.load

def main
  puts "Welcome to the Ada Slack CLI!"

  command = 0

  until command == "quit" || command == "q"
    workspace = Workspace.new
    print "What do you want to do? Here are the options: list users, list channels, or quit => "
    command = gets.chomp.downcase
    if command == "list users"
      tp workspace.get_users, :username, :name, :id
    elsif command == "list channels"
      tp workspace.get_channels, :name, :topic, :member_count, :slack_id
    else
      puts "That is not a valid command. Please provide a command from the provided list."
    end
    # command = request_command
  end

  # puts ENV["SLACK_TOKEN"]

  # response = HTTParty.get('https://slack.com/api/conversations.list', query: {token: ENV['SLACK_TOKEN']})

  # puts response

  # user_list = HTTParty.get('https://slack.com/api/users.list', query: {token: ENV['SLACK_TOKEN']})

  # ap user_list["name"]

  puts "Thank you for using the ADA Slack CLI"
end


main if __FILE__ == $PROGRAM_NAME
