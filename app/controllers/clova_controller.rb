class ClovaController < ApplicationController
  def index
    clova_request = Clova::Request.parse_request_from(request.body.read)
    case
    when clova_request.event?
      case clova_request.name
      when "AudioPlayer.PlayStarted"
        # noop
      else
        # noop
      end
    when clova_request.intent?
      case clova_request.name
      when "ReadlistsIntent"
        # noop
      when "ReadTasksIntent"
        # noop
      when "StartCheckIntent"
        # noop
      when "EndCheckIntent"
        # noop
      when "CheckIntent"
        # noop
      when "SetDueIntent"
        # noop
      when "NextIntent"
        # noop
      when "PrevIntent"
        # noop
      when "GuideIntent"
        # noop
      else
        # noop
      end
    when clova_request.launch?
      # noop
    when clova_request.session_ended?
      # noop
    else
      # something wrong?
      # noop
    end

    render json: {}
  end
end
