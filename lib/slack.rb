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

  selected_user = nil
  selected_channel = nil
  # recipient = nil  

  until command == "quit" || command == "q"
    print "What do you want to do? Here are the options: \n 
    list users \n
    list channels \n 
    select user \n 
    select channel \n
    details \n
    send message \n
    quit => "
    command = gets.chomp.downcase
    if command == "list users"
      tp workspace.get_users, :username, :name, :id
    elsif command == "list channels"
      tp workspace.get_channels, :name, :topic, :member_count, :id
    elsif command == "select user"
      print "Enter username or slack ID => "
      user_or_id = gets.chomp
      # returns User object
      selected_user = workspace.select_user(user_or_id)
      #recipient = selected_user.
      # validate username or ID exists
      if selected_user == nil
        puts "Username or ID not found"
      end
    elsif command == "select channel"
      print "Enter channel name or ID => "
      name_or_id = gets.chomp
      selected_channel = workspace.select_channel(name_or_id)
      #recipient = selected_channel.name
      # validate channel name or ID exists
      if selected_channel == nil
        puts "Channel name or ID not found"
      end
    elsif command == "details"
      # validate user or channel is selected first before providing details
      if selected_user == nil && selected_channel == nil
        puts "Select a user or channel first"
      elsif selected_user != nil
        puts selected_user.details
      elsif selected_channel != nil
        puts selected_channel.details
      end
    elsif command == "send message"
      # if channel == nil
      #   puts "You must select a recipient (channel or user) you would like to message."
      # else 
      #   print "Type your message => "
      #   message = gets.chomp
        channel =  "test-channel2"
        message = "heyyyyyyyyyyyyyyyyyyyyy"
        workspace.send_message(channel, message)
      # end
    else
      puts "That is not a valid command. Please provide a command from the provided list."
    end
  end

  puts "Thank you for using the ADA Slack CLI"
end

main if __FILE__ == $PROGRAM_NAME
