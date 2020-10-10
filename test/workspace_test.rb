require_relative "test_helper"
require_relative "../lib/workspace"

describe "Workspace" do

  before do
    @workspace = Workspace.new
  end

  it "lists users" do
    VCR.use_cassette("workspace") do
      response = @workspace.get_users
      expect(response).wont_be_nil
      expect(response).must_be_kind_of Array
      expect(response[1]).must_be_instance_of User
    end
  end

  it "lists channels" do
    VCR.use_cassette("workspace") do
      response = @workspace.get_channels
      expect(response).wont_be_nil
      expect(response).must_be_kind_of Array
      expect(response[1]).must_be_instance_of Channel
    end
  end

  it "select channel" do
    input = "test-channel2"
    VCR.use_cassette("workspace") do
      response = @workspace.select_channel(input)
      expect(response).wont_be_nil
      expect(response).must_be_instance_of Channel
    end
  end

  it "select user" do
    input = "Alice D"
    VCR.use_cassette("workspace") do
      response = @workspace.select_user(input)
      expect(response).wont_be_nil
      expect(response).must_be_instance_of User
    end
  end

  it "has a send_msg method" do
    expect(@workspace).must_respond_to :send_message
  end
  # it "can send a message to the test-channel2 channel" do
  #   VCR.use_cassette("nominal-positive") do
  #     answer = @workspace.send_message("test-channel2", "test message")
  #     expect(answer).must_equal "test message"
  #   end
  # end
  # delete if don't use template for other tests
  # it "returns false if channel does not exist" do
  #   VCR.use cassette("negative-edge") do
  #     expect {
  #       answer = @workspace.send_message("channelthatdoesntexist", "test message")
  #     }.must_raise SlackAPIError
  #   end
  # end
end


