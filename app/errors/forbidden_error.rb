class ForbiddenError < ApplicationError
  default_status 403
  default_message "没有权限"
end