class WelcomeController < ApplicationController
	skip_before_action :redirect_unauthorized, only: [:login, :loginin]

	def login
	end

	def loginin
		if (params[:login] == "financeiro" and params[:password] == "IFRS")
			session[:logged] = true
			
			redirect_to root_path
		else
			redirect_to login_path
		end
	end

	def logout
		session.delete(:logged)

		redirect_to login_path
	end

end
