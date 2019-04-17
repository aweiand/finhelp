class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session

  helper_method :sort_column, :sort_direction, :per_page
  helper_method :authorized?
  before_action :set_locale, :redirect_unauthorized
  
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

  def authorized?
    !session[:logged].nil?
  end

  def unauthorized_page
    respond_to do |format|
      format.html { render :file => "public/401.html", :status => :unauthorized }
      format.xml  { head :not_found }
      format.any  { head :not_found }
    end
  end  

  def redirect_unauthorized
    unless authorized?
      redirect_to login_path
    end
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
