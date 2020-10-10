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

  it "select user" do
    input = "Alice D"
    VCR.use_cassette("workspace") do
      response = @workspace.select_user(input)
      expect(response).wont_be_nil
      expect(response).must_be_instance_of User
    end
  end

  it "returns nil if no user/channel has selected name/ID" do
    input = "Orange Juice"
    VCR.use_cassette("workspace") do
      response = @workspace.select_user(input)
      expect(response).must_be_nil
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

  it "doesn't raise exception when message is sent" do
    VCR.use_cassette("workspace") do
      recipient_name = "Alice D"
      message = "Testers testing tests!"
      expect(@workspace.send_message(recipient_name, message)).wont_raise ArgumentError
    end
  end
end
