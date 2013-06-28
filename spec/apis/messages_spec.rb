require 'spec_helper'

describe Api::MessagesController, :type => :controller do

  context "Retrieving Messages" do
    context "For all tracks" do
      describe "GET /api/messages" do
        it "should return a list of all messages" do
          m1 = Message.create(body: "What's happening yall!!",   user_id: 1, track_id: 2)
          m2 = Message.create(body: "This is super exciting!!!", user_id: 2, track_id: 3)
          messages = [m1, m2].to_json

          get "/api/messages"

          expect(last_response.status).to eq 200
          expect(last_response.body).to eq messages
        end
      end
    end

    context "For a specific track" do

      describe "GET /api/track/:track_id/messages" do

        it "should return a list of messages for a specific track" do
          m1 = Message.create(body: "What's happening yall!!",   user_id: 1, track_id: 2)
          m2 = Message.create(body: "This is super exciting!!!", user_id: 2, track_id: 3)
          messages = [m1].to_json

          get "/api/tracks/#{m1.track_id}/messages"
          expect(last_response.status).to eq 200
          expect(last_response.body).to eq messages
        end
      end
    end
  end

  context "Posting Messages" do

    context "To a specific track" do

      describe "POST /api/tracks/:track_id/messages" do

        it " should create a message with valid parameters" do
          client = stub(publish: nil)
          Faye::Client.stub(:new).with('http://localhost:9292/faye').and_return(client)

          post "/api/tracks/3/messages", message: { user_id: 1, body: "Let's go!!!" }

          message = Message.last
          expect(last_response.status).to eq 201
          expect(last_response.body).to eq message.to_json
        end

        describe "with invalid parameters" do

          it "should return an error message and not create a new message when missing user_id" do

            post "/api/tracks/3/messages", message: { track_id: 3, body: "Let's go!!!" }

            error = {:error => {"user_id" => ["can't be blank"]}}
            expect(last_response.status).to eq 400
            expect(last_response.body).to eq error.to_json
          end

          it "should return an error message and not create a new message when missing body" do

            post "/api/tracks/3/messages", message: { user_id: 1, track_id: 3 }

            error = {:error => {"body" => ["can't be blank"]}}
            expect(last_response.status).to eq 400
            expect(last_response.body).to eq error.to_json
          end

        end
      end
    end

  end

end


