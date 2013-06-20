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

      describe "GET /api/messages/:track_id" do

        it "should return a list of messages for a specific track" do
          m1 = Message.create(body: "What's happening yall!!",   user_id: 1, track_id: 2)
          m2 = Message.create(body: "This is super exciting!!!", user_id: 2, track_id: 3)
          messages = [m1].to_json

          get "/api/messages/#{m1.track_id}"
          expect(last_response.status).to eq 200
          expect(last_response.body).to eq messages
        end

        it "should return an error message if track doesn't exist" do
          m1 = Message.create(body: "What's happening yall!!",   user_id: 1, track_id: 2)
          get "/api/messages/77"

          error = {:error => "No track found"}
          expect(last_response.status).to eq 404
          expect(last_response.body).to eq error.to_json
        end
      end
    end
  end

  context "Posting Messages" do

    context "To a specific track" do

      describe "POST /api/messages" do

        it " should create a message with valid parameters" do
          post "/api/messages", message: { user_id:1,
                                           track_id:3,
                                           body: "Let's go!!!" }
          message = Message.last
          expect(last_response.status).to eq 201
          expect(last_response.body).to eq message.to_json
        end

        describe "with invalid parameters" do

          it "should return an error message and not create a new message when missing track_id" do
            post "/api/messages", message: { user_id:1,
                                             body: "Let's go!!!" }

            error = {:error => {"track_id" => ["can't be blank"]}}
            expect(last_response.status).to eq 400
            expect(last_response.body).to eq error.to_json
          end

          it "should return an error message and not create a new message when missing user_id" do
            post "/api/messages", message: { track_id:3,
                                             body: "Let's go!!!" }

            error = {:error => {"user_id" => ["can't be blank"]}}
            expect(last_response.status).to eq 400
            expect(last_response.body).to eq error.to_json
          end

          it "should return an error message and not create a new message when missing user_id" do
            post "/api/messages", message: { user_id:1,
                                             track_id:3 }

            error = {:error => {"body" => ["can't be blank"]}}
            expect(last_response.status).to eq 400
            expect(last_response.body).to eq error.to_json
          end

        end
      end
    end

  end

end


