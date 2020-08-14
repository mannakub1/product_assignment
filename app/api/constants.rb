module Constants
  HEADER_API_KEY    = 'Sdc-Api-Key'
  HEADER_AUTH_TOKEN = 'Sdc-Auth-Token'
  HEADER_ROLE_ID    = 'Sdc-Role-Id'
  HEADER_DC_ID      = 'Sdc-Dc-Id'
  HEADER_SUB_BUSINESS_TYPE_ID = 'Sdc-Sub-Business-Type-Id'

  CODE_SUCCESS                 = 'success'               # 200, 201
  CODE_DUPLICATE_ENTRY         = 'duplicate_entry'       # 409
  CODE_BAD_REQUEST             = 'bad_request'           # 400
  CODE_UNAUTHORIZED            = 'unauthorized'          # 401
  CODE_SESSION_EXPIRE          = 'session_expire'        # 401
  CODE_PASSWORD_EXPIRED        = 'password_expired'      # 401
  CODE_FORBIDDEN               = 'forbidden'             # 403
  CODE_NOT_FOUND               = 'not_found'             # 404
  CODE_METHOD_NOT_ALLOWED      = 'method_not_allowed'    # 405
  CODE_VALIDATE_FAILED         = 'validate_failed'       # 422
  CODE_SERVER_ERROR            = 'server_error'          # 500
end
