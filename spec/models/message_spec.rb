require 'spec_helper'

describe Message do

  it "is valid with a body, user_id and track_id" do
    @message = Message.new(user_id: 1, track_id: 1, body: "Hello Planet!")
    expect(@message).to be_valid
  end

  it "should be invalid without a user_id" do
    @message = Message.new(track_id: 1, body: "Hello Planet!")
    expect(@message).to have(1).errors_on(:user_id)
  end

  it "should be invalid without a track_id" do
    @message = Message.new(user_id: 1, body: "Hello Planet!")
    expect(@message).to have(1).errors_on(:track_id)
  end

  it "should be invalid without a body" do
    @message = Message.new(user_id: 1, track_id: 1)
    expect(@message).to have(1).errors_on(:body)
  end

end
