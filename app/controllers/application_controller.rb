class ApplicationController < ActionController::Base
	# Prevent CSRF attacks by raising an exception.
	# For APIs, you may want to use :null_session instead.
	protect_from_forgery with: :exception

	def current_user
		if APP_CONFIG[:ignore_ldap]
			@current_user ||= DummyUser.new
		else
			@current_user ||= (session[:udn] ? User.find(session[:udn]) : nil)
		end
	end

	def current_admin
		@current_admin ||= (current_user && current_user.admin?)
	end

	helper_method :current_user, :current_admin

	private
	def check_for_user
		rediect_to root_path, alert: "Please log in." unless APP_CONFIG[:ignore_ldap] || current_user
	end

	def check_for_admin
		redirect_to root_path, alert: "You can't do that." unless APP_CONFIG[:ignore_ldap] || current_user
	end
end
