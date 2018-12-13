class ClovaController < ApplicationController
  protect_from_forgery except: :index
  before_action :validate_request, only: :index

  def index
    clova_request = Clova::Request.parse_request_from(request.body.read)
    case
    when clova_request.intent?
      case clova_request.name
      when "ReadListsIntent"
        render json: say("本日は晴天なり")
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
