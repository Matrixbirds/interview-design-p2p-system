class ApplicationError < StandardError
  attr_accessor :message, :status

  def initialize(message = nil, status = nil)
    @message = message.presence || default_message
    @status  = status.presence || default_status
    super(@message)
  end

  def as_json
    {
      title: message,
      status: status
    }
  end

  def self.default_message(message)
    define_method(:default_message) { message }
  end

  def self.default_status(status)
    define_method(:default_status) { status }
  end
end
