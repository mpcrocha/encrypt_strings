class EncryptedStringsController < ApplicationController

  before_action :load_encrypted_string, only: [:index, :destroy]

  def create
    @encrypted_string = EncryptedString.new(value: encrypted_string_params[:value])
    if @encrypted_string.save
      render json: { token: @encrypted_string.token }
    else
      render json: { message: @encrypted_string.errors.full_messages.to_sentence},
             status: :unprocessable_entity
    end
  end

  def index
    render json: { value: @encrypted_string.value }
  end

  def destroy
    @encrypted_string.destroy!
    head :ok
  end

  private

  def load_encrypted_string
    @encrypted_string = EncryptedString.find_by(token: params[:token].to_s)
    if @encrypted_string.nil?
       render json: { messsage: "No entry found for token #{params[:token]}" },
             status: :not_found
    end
  end

  def encrypted_string_params
    params.require(:encrypted_string).permit(:value)
  end
end
