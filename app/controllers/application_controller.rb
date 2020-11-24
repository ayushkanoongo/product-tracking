class ApplicationController < ActionController::Base
	http_basic_authenticate_with name: 'admin', password: 'password'
	add_flash_types :success, :warning, :danger, :info
end
