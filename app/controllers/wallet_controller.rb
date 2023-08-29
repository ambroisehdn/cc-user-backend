class WalletController < ApplicationController

    include ValidationHelper
    include HttpHelper

    EXTERNAL_API_BASE_URL = "http://localhost:8081/wallet"

    # GET /wallet
    def get_wallet
      uid = params[:uid]
      secret = params[:secret]
  
      response = make_get_request("#{EXTERNAL_API_BASE_URL}?uid=#{uid}&secret=#{secret}")

      handle_response(response)
    end
  
    # POST /wallet
    def create_wallet
      uid = params[:uid]
  
    #   secret = SecureRandom.hex(16)
    #   secret = SecureRandom.hex(32)
      characters = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'

      secret = SecureRandom.random_bytes(32).unpack('C*').map { |byte| characters[byte % characters.length] }.join
    #   puts(secret)
      response = make_post_request("#{EXTERNAL_API_BASE_URL}", { uid: uid, secret: secret })
    # puts(response.body)
      handle_response(response,secret)
  
    #   render json: { address: wallet_manager_response[:address], password: secret }
    end


    def handle_response(response,secret=nil)
        # puts(["200","201"].include?(response.code))
        if ["200","201"].include?(response.code)
          data = JSON.parse(response.body)
          if !secret.nil?
            _data = {}
            _data['data'] = {secretKey: secret,address: data['data']['address']}
            data.merge!(_data)
          end
          render json: {error: false, message: 'Data fetch from the wallet manager service', remoteResponse: data}
        else
          data = JSON.parse(response.body)
          render json: { error: true, message: 'Failed to fetch data from the wallet manager service',remoteResponse: data }, status: :bad_request
        end
    end
  end
  