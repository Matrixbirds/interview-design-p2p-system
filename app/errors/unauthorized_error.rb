class UnauthorizedError < ApplicationError
  default_status 401
  default_message "登录名或密码错误"
end