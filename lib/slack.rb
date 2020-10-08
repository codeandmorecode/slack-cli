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
  workspace = Workspace.new
  total_users = workspace.get_users.length
  total_channels = workspace.get_channels.length
  puts "There are #{total_users} users in the Ada Slack workspace and #{total_channels} channels in the Ada Slack workspace."

  until command == "quit" || command == "q"
    print "What do you want to do? Here are the options: list users, list channels, select user, select channel, details, or quit => "
    command = gets.chomp.downcase
    if command == "list users"
      #ap workspace.get_users
      tp workspace.get_users, :username, :name, :id
    elsif command == "list channels"
      #ap workspace.get_channels
      tp workspace.get_channels, :name, :topic, :member_count, :slack_id
    elsif command == "select user"
      puts "Do you want to input a username or a slack ID?"

      answer = gets.chomp.downcase

      until answer == "quit"

        if answer == "username"
          puts "calling username method" #workspace.select_username
          answer = "quit"
        elsif answer == "slack id"
          puts "calling slack id method" # workspace.select_slack_id
          answer = "quit"
        else
          "#{answer} is not a valid option. Enter username, slack id, or quit."
        end

      end

    elsif command == "select channel"
      # workspace.select_channel
    elsif command == "details"
      # workspace.details
    else
      puts "That is not a valid command. Please provide a command from the provided list."
    end
  end

  puts "Thank you for using the ADA Slack CLI"
end

main if __FILE__ == $PROGRAM_NAME
