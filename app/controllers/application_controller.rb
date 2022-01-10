class ApplicationController < ActionController::Base
    before_action :set_locale
    private
    def set_locale
        I18n.locale = params[:locale] if params[:locale].present?
    end
end
