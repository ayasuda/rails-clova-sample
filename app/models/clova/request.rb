require 'forwardable'

module  Clova
  class Request
    extend ::Forwardable
    attr_accessor :context, :request, :session, :version

    def_delegators :@request, :event?, :intent?, :launch?, :session_ended?, :name, :slots, :payload

    class Context
      attr_accessor :audio_player, :system

      class AudioPlayer
        attr_accessor :offset_in_milliseconds, :player_activity, :stream, :total_in_milliseconds

        def initialize(json)
          self.offset_in_milliseconds = json&.[]("offsetInMilliseconds")
          self.player_activity = json&.[]("playerActivity")
          self.stream = json&.[]("stream")
          self.total_in_milliseconds = json&.[]("totalInMilliseconds")
        end
      end # AudioPlayer

      class System
        attr_accessor :application, :device, :user

        class Application
          attr_accessor :application_id

          def initialize(json)
            self.application_id = json&.[]("applicationId")
          end
        end # Application

        class Device
          attr_accessor :device_id, :display

          class Display
            attr_accessor :content_layer, :dpi, :orientation, :size

            class ContentLayer
              attr_accessor :width, :height

              def initialize(json)
                self.width = json&.[]("width")
                self.height = json&.[]("height")
              end
            end # ContentLayer

            def initialize(json)
              self.content_layer = ContentLayer.new(json&.[]("contentLayer"))
              self.dpi = json&.[]("dpi")
              self.orientation = json&.[]("orientation")
              self.size = json&.[]("size")
            end
          end # Display

          def initialize(json)
            self.device_id = json&.[]("deviceId")
            self.display = Display.new(json&.[]("display"))
          end
        end # Device

        class User
          attr_accessor :user_id, :access_token

          def initialize(json)
            self.user_id = json&.[]("userId")
            self.access_token = json&.[]("accessToken")
          end
        end # User

        def initialize(json)
          self.application = Application.new(json&.[]("application"))
          self.device = Device.new(json&.[]("device"))
          self.user = User.new(json&.[]("user"))
        end
      end # System

      def initialize(json)
        self.audio_player = AudioPlayer.new(json&.[]("audioPlayer"))
        self.system = System.new(json&.[]("System"))
      end
    end # Context

    class Request
      attr_accessor :type

      # attr for EventRequest
      attr_accessor :request_id, :timestamp, :event

      # attr for IntentRequest
      attr_accessor :intent

      class Event
        attr_accessor :namespace, :name, :payload

        def initialize(json)
          self.namespace = json&.[]("namespace")
          self.name = json&.[]("name")
          self.payload  = json&.[]("payload")
        end
      end # Event

      class Intent
        attr_accessor :name, :slots

        def initialize(json)
          self.name = json&.[]("name")
          self.slots = json&.[]("slots")
        end
      end # Intent

      def initialize(json)
        self.type = json&.[]("type")
        self.request_id = json&.[]("requestId")
        self.timestamp = json&.[]("timestamp")
        self.event = Event.new(json&.[]("event"))
        self.intent = Intent.new(json&.[]("intent"))
      end

      def event?
        self.type == "EventRequest"
      end

      def intent?
        self.type == "IntentRequest"
      end

      def launch?
        self.type == "LaunchRequest"
      end

      def session_ended?
        self.type == "SessionEndedRequest"
      end

      def name
        case
        when event? then "#{self.event.namespace}.#{self.event.name}"
        when intent? then self.intent&.name
        else ""
        end
      end

      def slots
        self.intent&.slots
      end

      def payload
        self.event&.payload
      end
    end # Request

    class Session
      attr_accessor :new, :session_attributes, :session_id, :user

      class User
        attr_accessor :user_id, :access_token

        def initialize(json)
          self.user_id = json&.[]("userId")
          self.access_token = json&.[]("accessToken")
        end
      end # User

      def initialize(json)
        self.new = json&.[]("new")
        self.session_attributes = json&.[]("sessionAttributes")
        self.session_id = json&.[]("sessionId")
        self.user = User.new(json&.[]("user"))
      end
    end # Session

    def initialize(json)
      self.context = Context.new(json&.[]("context"))
      self.request = Request.new(json&.[]("request"))
      self.session = Session.new(json&.[]("session"))
      self.version = json["version"]
    end

    def self.parse_request_from(request_str)
      self.new(JSON.parse(request_str))
    end
  end # Request
end
