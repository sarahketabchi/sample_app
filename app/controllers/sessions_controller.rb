class SessionsController < ApplicationController
	def new
	end

	def create
		user = User.find_by_email(params[:session][:email].downcase)

		if user && user.authenticate(params[:session][:password])
			# Sign in the user and redirect to the user's show page
			# user sign_in method in sessions helper module
			sign_in user
			redirect_back_or user
		else
			# Create an error message and re-render the signin form.
			flash.now[:error] = 'Invalid email/password combination'
			render 'new'
		end
	end

	def destroy
		# sign_out is in sessions helper module
		sign_out
		redirect_to root_url
	end
end
