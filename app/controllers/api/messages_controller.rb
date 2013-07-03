class Api::MessagesController < ApplicationController

  def index
    render json: Message.all
  end

  def show
    messages = Message.where(track_id: params[:track_id])

    if messages.present?
      render json: messages
    else
      render json: []
    end
  end

  def create
    message = Message.create(params[:message].merge(track_id: params[:track_id]))

    if message.valid?
      client = Faye::Client.new('http://localhost:9292/faye')
      client.publish("/tracks/#{params[:track_id]}", 'text' => message)
      render json: message, status: 201
    else
      render_create_error(message)
    end
  end

  private

  def render_create_error(message)
    render json: {error: message.errors}, status: 400
  end

end
