class SessionsController < ApplicationController
  def new
    flash[:sign_on] = true
    redirect_to root_path
  end
  def register
    flash[:register] = true
    redirect_to root_path
  end
  def delete
    reset_session
    redirect_to root_path
  end
end
