class ClovaController < ApplicationController
  protect_from_forgery except: :index
  before_action :validate_request, only: :index

  def index
    clova_request = Clova::Request.parse_request_from(request.body.read)
    token = Doorkeeper::AccessToken.by_token(clova_request.access_token)

    return render json: say("アカウント連携してください") if token.nil?

    return render status: :forbidden, text: "access denied" unless token.accessible? # expired or revoked

    begin
      current_user = User.find(token.resource_owner_id)
    rescue ActiveRecord::RecordNotFound
      return render json: say("アカウント連携してください")
    end

    case
    when clova_request.intent?
      case clova_request.name
      when "ReadListsIntent"
        render json: say("本日は晴天なり #{current_user.email} さんようこそ")
      else
        render json: empty
      end
    else
      render json: empty
    end
  end

  private

  def validate_request
    return true if Rails.env.test?
    key = OpenSSL::PKey::RSA.new(Rails.root.join('config', 'signature-public-key.pem').read)
    signature = request.headers[:HTTP_SIGNATURECEK]
    unless signature
      logger.warn("Signature missing")
      render text: "Access denied", status: 403
      return false
    end
    unless key.verify('sha256', Base64.decode64(signature), request.body.read)
      logger.warn("$ignature verificatoin failed")
      render text: "Access denied", status: 403
      return false
    end
  end

  def empty()
    Hash.new.tap do |root|
      root[:version] = "1.0"
      root[:sessionAttributes] = {}
      root[:response] = Hash.new.tap do |response|
        response[:card] = {}
        response[:directives] = []
        response[:outputSpeech] = {}
      end
    end
  end

  def say(message)
    Hash.new.tap do |root|
      root[:version] = "1.0"
      root[:sessionAttributes] = {}
      root[:response] = Hash.new.tap do |response|
        response[:card] = {}
        response[:directives] = []
        response[:outputSpeech] = Hash.new.tap do |output_speech|
          output_speech[:type] = "SimpleSpeech"
          output_speech[:values] = Hash.new.tap do |value|
            value[:type] = "PlainText"
            value[:lang] = "ja"
            value[:value] = message
          end
        end
        response[:shouldEndSession] = true
      end
    end
  end

  def ask(message, session_attributes)
    Hash.new.tap do |root|
      root[:version] = "1.0"
      root[:sessionAttributes] = {}
      root[:response] = Hash.new.tap do |response|
        response[:card] = {}
        response[:directives] = []
        response[:outputSpeech] = Hash.new.tap do |output_speech|
          output_speech[:type] = "SimpleSpeech"
          output_speech[:values] = Hash.new.tap do |value|
            value[:type] = "PlainText"
            value[:lang] = "ja"
            value[:value] = message
          end
        end
        response[:shouldEndSession] = false
      end
    end
  end
end
