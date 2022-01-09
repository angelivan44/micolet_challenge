class UserController < ApplicationController
    def index
    end

    def create
        unless array_preferences.empty?
            @user = User.new(email:params[:email])
            @preferences = array_preferences.map{ |ele| Preference.new(gender: ele) }
            @user.preferences << @preferences
            if @user.save
                redirect_to('/')
                UserMailer.welcome_email(params[:email]).deliver_now
            end
        end
    end
    private
    def user_params
        params.require(:user).permit(:email, :women, :men , :children)
    end
    def preferences_valid?
        params[:women] or params[:men] or params[:children]
    end

    def array_preferences
        response = []
        response.push("women") if params[:women] != "0"
        response.push("men") if params[:men] != "0"
        response.push("children") if params[:children] != "0"
        response
    end
end
