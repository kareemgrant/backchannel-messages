class Api::MessagesController < ApplicationController

  def index
    render json: Message.all
  end

  def show
    messages = Message.where(track_id: params[:track_id])
    if messages.present?
      render json: messages
    else
      render_unavailable
    end
  end

  def create
    message = Message.create(params[:message])
    if message.valid?
      render json: message, status: 201
    else
      render_create_error(message)
    end
  end

  private

  def render_unavailable
    render json: {error: "No track found"}, status: 404
  end

  def render_create_error(message)
    error = message.errors
    render json: {error: error}, status: 400
  end

end
