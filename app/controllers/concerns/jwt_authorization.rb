module JWTAuthorization
  extend ActiveSupport::Concern

  def authenticate_user!
    raise CustomError.new('需要登录', 422) if jwt.blank?
    @user = User.find(decoded_jwt[:id])
  end

  def authenticate_user
    @user = User.find(decoded_jwt[:id]) if jwt.present?
  rescue UnauthorizedError => e
  end

  def current_user
    @user
  end

  def user_sign_in?
    current_user.present?
  end

  def jwt
    String(request.headers['Authorization']).split('P2P token=')[1]
  end

  def decoded_jwt
    @decoded_jwt ||= JsonWebToken.decode!(jwt)
  rescue JWT::ExpiredSignature
    raise UnauthorizedError.new("登录信息已过期")
  rescue JWT::DecodeError
    raise UnauthorizedError.new("非法登录")
  end
end
