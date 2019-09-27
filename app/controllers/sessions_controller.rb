class SessionsController < ApplicationController
	def create
		user = User
						.find.by(email: params["user"]["email"])
						.try(:authenticate, params["user"]["password"])
		
		if user
			session[:user_id] = user.id
			render json: {
				status: :created,
				logged_in: true,
				user: user
			}
		end
		else
			render {status: 401}
		end
	end
end