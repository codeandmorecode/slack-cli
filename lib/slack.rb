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

  selected_recipient = nil

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
      username_or_id = gets.chomp
      # returns User object
      selected_recipient = workspace.select_user(username_or_id)
      # validate username or ID exists
      if selected_recipient == nil
        puts "Username or ID not found"
      end
    elsif command == "select channel"
      print "Enter channel name or ID => "
      name_or_id = gets.chomp
      selected_recipient = workspace.select_channel(name_or_id)
      # validate channel name or ID exists
      if selected_recipient == nil
        puts "Channel name or ID not found"
      end
    elsif command == "details"
      # validate user or channel is selected first before providing details
      if selected_recipient == nil
        puts "Select a user or channel first"
      elsif selected_recipient != nil
        puts selected_recipient.details
      end
    elsif command == "send message"
      if selected_recipient == nil
        puts "You must select a recipient (channel or user) you would like to message."
      else
        print "Type your message => "
        message = gets.chomp
        did_message_send = workspace.send_message(selected_recipient.id, message)
        if did_message_send
          puts "Message sent!"
        else
          puts "Message failed to send."
        end
      end
    elsif command == "quit" || command == "q"
      puts "Thank you for using the ADA Slack CLI"
    else
      puts "That is not a valid command. Please provide a command from the provided list."
    end
  end
end

main if __FILE__ == $PROGRAM_NAME
