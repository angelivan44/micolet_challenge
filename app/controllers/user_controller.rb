require 'net/http'
require 'net/https'

class UserController < ApplicationController
    def index
        @error = params[:error]
    end

    def create
        unless array_preferences.empty?
            if valid_email? params[:email]
                    @user = User.new(email:params[:email])
                    @preferences = array_preferences.map{ |ele| Preference.new(gender: ele) }
                    @user.preferences << @preferences
                    if @user.save
                        redirect_to action: "index" , error: nil
                        UserMailer.welcome_email(params[:email]).deliver_now
                    else
                        redirect_to action: "index" , error: "email #{@user.errors.messages[:email][0]}"
                    end
                
            else
                redirect_to action: "index", error: "Invalid Email"
            end
        else
            redirect_to action: "index" , error: "you need to choose almost one option"
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

    def valid_email? email
            uri = URI("https://emailvalidation.abstractapi.com/v1/?api_key=e2473bfc8db549d8a658dd63d2ed8f97&email=#{email}")
        
            http = Net::HTTP.new(uri.host, uri.port)
            http.use_ssl = true
            http.verify_mode = OpenSSL::SSL::VERIFY_PEER
        
            request =  Net::HTTP::Get.new(uri)
        
            response = http.request(request)
            JSON.parse(response.body)["quality_score"].to_f >= 0.7
        rescue StandardError => error
            return false
        end
end
