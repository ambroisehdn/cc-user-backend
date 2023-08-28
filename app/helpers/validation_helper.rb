module ValidationHelper
    extend ActiveSupport::Concern
    require 'uri'

    included do
      before_action :validate_uid, only: [:get_wallet, :create_wallet]
      before_action :validate_secret, only: [:get_wallet]
    end
  
    private
    
    $uuid_pattern = /\A[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}\z/i

    def validate_uid
    #   puts $uuid_pattern
      uid = params[:uid]
      unless uid.present? && uid.match?($uuid_pattern)
        response = {
            error: true,
            message: 'Please provide a valid UUID'
        }
        render json: response, status: :bad_request
      end
    end
  
    def validate_secret
      secret = params[:secret]
      secret = URI.encode_www_form_component(secret)

      unless secret.present? && secret.length == 32 && secret.match?(/^[a-zA-Z0-9!@#$%^&*()_+{}\[\]:;<>,.?~=-]+$/)
        response = {
            error: true,
            message: 'Please provide a valid secret key'
        }
        render json: response, status: :bad_request
      end
    end

  end
  