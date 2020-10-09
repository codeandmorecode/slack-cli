require_relative "test_helper"
require_relative "../lib/workspace"

describe "main" do

  before do
    @workspace = Workspace.new
  end

  it "lists users" do
    VCR.use_cassette("workspace") do
      response = @workspace.get_users
      expect(response).wont_be_nil
      expect(response).must_be_kind_of Array
      expect(response.length).must_equal 162
      expect(response[1]).must_be_instance_of User
      expect(response[137].name).must_equal "Alice D"
      expect(response[129].username).must_equal "fire_madeline_api_pro"
      expect(response[0].id).must_equal "USLACKBOT"
    end
  end

  it "lists channels" do
    VCR.use_cassette("workspace") do
      response = @workspace.get_channels
      expect(response).wont_be_nil
      expect(response).must_be_kind_of Array
      expect(response.length).must_equal 47
      expect(response[1]).must_be_instance_of Channel
      expect(response[39].name).must_equal "plants"
      expect(response[32].slack_id).must_equal "C01AHJVCA3T"
      expect(response[25].member_count).must_equal 66
    end
  end
end

