require 'line/bot'
class LineBot
  def self.new
    Line::Bot::Client.new { |config|
      config.channel_secret = Rails.application.credentials.line_bot[:channel_secret]
      config.channel_token =  Rails.application.credentials.line_bot[:access_token]
    }
  end
end
