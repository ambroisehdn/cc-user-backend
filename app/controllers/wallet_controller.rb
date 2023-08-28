class WalletController < ApplicationController

    include ValidationHelper
    # require 'securerandom'

    # GET /wallet
    def get_wallet
      uid = params[:uid]
      secret = params[:secret]
  
      wallet_manager_response = {
        address: '',
        privateKey: ''
      }
  
      render json: wallet_manager_response
    end
  
    # POST /wallet
    def create_wallet
      uid = params[:uid]
  
    #   secret = SecureRandom.hex(16)
      secret = SecureRandom.urlsafe_base64(32)

      wallet_manager_response = {
        address: '',
        privateKey: ''
      }
  
      render json: { address: wallet_manager_response[:address], password: secret }
    end
  end
  