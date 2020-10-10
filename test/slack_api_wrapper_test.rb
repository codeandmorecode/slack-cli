require_relative 'test_helper'
describe SlackApiWrapper do
it "has a send_msg method" do
expect(SlackApiWrapper).must_respond_to :send msg
end
it "can send a message to the test-channel2 channel" do
VCR.use_cassette("nominal-positive") do
answer = SlacApiWrapper.send_msg("test-channel2", "test message")
expect(answer).must_equal true
end
end
it "returns false if channel does not exist" do
VCR.use cassette("negative-edge") do
expect{
answer = SlackApiWrapper.send_msg("channelthatdoesntexist", "test message")
}.must_raise SlackAPIError
end
end
end