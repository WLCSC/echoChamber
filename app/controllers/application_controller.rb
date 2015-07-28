class ApplicationController < ActionController::Base
	# Prevent CSRF attacks by raising an exception.
	# For APIs, you may want to use :null_session instead.
	protect_from_forgery with: :exception

	if APP_CONFIG[:ignore_ldap]
		@current_user ||= DummyUser.new
	else
		@current_user ||= (session[:udn] ? User.find(session[:udn]) : nil)
	end
end
