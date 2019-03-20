class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session

  helper_method :sort_column, :sort_direction, :per_page
  before_action :set_locale
  
  layout Proc.new { |controller| controller.request.xhr? ? false: 'application' }
  
  def set_locale
    unless params[:locale].blank?
      session[:locale] = params[:locale]
    end
    if session[:locale].blank?
      session[:locale] = I18n.default_locale
    end

    I18n.locale = session[:locale]
  end

  # Método para o limite de resultados por página padrão
  def per_page
  	(params[:per_page].nil? || params[:per_page].blank?) ? 10 : params[:per_page]
  end

  # Método para o sort padrão
  def sort_column
    (params[:sort].nil? || params[:sort].blank?) ? "created_at" : params[:sort]
  end

  # Método para o sort padrão
  def sort_direction
    (params[:direction].nil? || params[:direction].blank?) ? "DESC" : params[:direction]
  end  
end
