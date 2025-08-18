class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  helper_method :current_user, :logged_in?

  def current_user
    # Va a la lista de cookies que iniciarion sesion
    # Busca en la lista si esta la cookie que mando el navegador
    # Y si esta la cookie, obtiene el user_id que esta guardado en esa cookie
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    # !! => Transforma un valor cualquiera de Ruby en un booleano
    # Booleano => tipo de dato que es o true o false
    # current_user => Instancia de User
    # current_user =>
    !!current_user
  end

  def require_user
    # true => false
    # false => true
    #
    # logged_in => true
    # !logged_in => false
    #
    # logged_in => false
    # !logged_in => true
    if !logged_in?
      flash[:alert] = "Debes iniciar sesión para acceder a esta página"
      redirect_to login_path
    end
  end
end
