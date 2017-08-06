class ApplicationController < ActionController::API
  include JWTAuthorization
  before_action :authenticate_user!

  rescue_from ApplicationError, with: :app_error
  rescue_from ActionController::ParameterMissing, with: :param_missing_error
  rescue_from ActiveRecord::RecordInvalid, with: :record_invalid_error
  rescue_from ActiveModel::ValidationError, with: :model_invalid_error
  rescue_from CanCan::AccessDenied, with: :user_not_authorized
  rescue_from RailsParam::Param::InvalidParameterError, with: :invalid_param_error

  private

  def app_error(exception)
    error = OpenStruct.new exception.as_json
    render json: { message: error.title }, status: error.status
  end

  def user_not_authorized(_exception)
    render json: { message: '没有权限！' }, status: :forbidden
  end

  def server_error(exception)
    logger.error exception.message
    logger.error exception.backtrace
    render json: { message: '服务器内部错误！' }, status: :internal_server_error
  end

  def param_missing_error(exception)
    render json: { message: exception.message }, status: :bad_request
  end

  def invalid_param_error(exception)
    render json: { message: "parameters:#{exception.param} options: #{exception.options} #{exception.message}" }, status: :bad_request
  end

  def record_invalid_error(exception)
    message = exception.record.errors.full_messages.join("\n")
    render json: { message: message }, status: :unprocessable_entity
  end

  def model_invalid_error(exception)
    message = exception.model.errors.full_messages.join("\n")
    render json: { message: message }, status: :unprocessable_entity
  end

  def unprocessable_error(exception)
    render json: { message: exception.message }, status: :unprocessable_entity
  end

end
