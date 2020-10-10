# require "httparty"
# require "dotenv"
#
# GET_MESSAGE_PATH = "https://slack.com/api/chat.postMessage"
#
# Dotenv.load
#
# class Recipient
#     attr_reader :name, :slack_id
#
#     def initialize(name, slack_id)
#       @name = name
#       @slack_id = slack_id
#     end
#
#
#     # def details
#     #   return "Username: #{@username}. Name: #{@name}. ID: #{@id}."
#     # end
#   end
#