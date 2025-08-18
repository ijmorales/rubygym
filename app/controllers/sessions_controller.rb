class SessionsController < ApplicationController
  def new
    redirect_to dashboard_path if logged_in?
  end

  def create
    user = User.find_by(email: params[:email].downcase)

    if user&.authenticate(params[:password])
      session[:user_id] = user.id # Esto autentica al usuario en el servidor
      redirect_to dashboard_path, notice: "Bienvenido de vuelta, #{user.name}!"
    else
      flash.now[:alert] = "Email o contraseña incorrectos"
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to login_path, notice: "Has cerrado sesión exitosamente"
  end
end