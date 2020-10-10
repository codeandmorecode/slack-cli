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
      # expect(response.length).must_equal 162
      expect(response[1]).must_be_instance_of User
      # expect(response[137].name).must_equal "Alice D"
      # expect(response[129].username).must_equal "fire_madeline_api_pro"
      # expect(response[0].id).must_equal "USLACKBOT"
    end
  end

  it "lists channels" do
    VCR.use_cassette("workspace") do
      response = @workspace.get_channels
      expect(response).wont_be_nil
      expect(response).must_be_kind_of Array
      #expect(response.length).must_equal 48
      expect(response[1]).must_be_instance_of Channel
      # expect(response[39].name).must_equal "plants"
      # expect(response[32].slack_id).must_equal "C01AHJVCA3T"
      # expect(response[25].member_count).must_equal 66
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
  # it "returns false if channel does not exist" do
  #   VCR.use cassette("negative-edge") do
  #     expect {
  #       answer = @workspace.send_message("channelthatdoesntexist", "test message")
  #     }.must_raise SlackAPIError
  #   end
  # end
end


