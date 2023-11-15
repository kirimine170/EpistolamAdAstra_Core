class MessagesController < ApplicationController
    before_action :set_message, only: %i[ destroy ]

    # GET /messages
    def index
        @messages = Message.order("RANDOM()").limit(1)
        render status:200, json: @messages
    end

    # POST /messages
    def create
        @message = Message.new(message_params)

        if @message.save
            render json: @message, status: :created, location: @message
        else
            render json: @message.errors, status: :unprocessable_entity
        end
    end

    # DELETE /messages/1
    def destroy
        @message.destroy!
    end

    private
    def set_message
        @message = Message.find(params[:id])
    end
    def message_params
        params.require(:message).permit(:dear, :content)
    end
end
