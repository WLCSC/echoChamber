class SessionController < ApplicationController
	def new
		if APP_CONFIG[:ignore_ldap]
			redirect_to rooms_path
		end
	end

	def create
		if u = User.authenticate(params[:username], params[:password])
			session[:udn] = u.dn.to_s
			flash[:notice] = "Welcome, #{u.nice_name}"
		else
			flash[:error] = "Login failed."
		end

		redirect_to root_path
	end

	def destroy
		session.delete :udn

		redirect_to root_path
	end
end
