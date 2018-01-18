class UsersController < ApplicationController

  def new
  end

  def create
    if params[:user][:password] != params[:user][:confirm_pw]
      flash[:reg_errors] = ["passwords do not match, try again"]
      flash[:register] = true
      redirect_to root_path
      return
    end
    if params[:user][:name].downcase.include? "sabah"
      flash[:reg_errors] = ["Sorry ASIF"]
      flash[:register] = true
      redirect_to root_path
      return
    end
    unless params[:admin_code].empty?
      @admincheck = admin_check
      if @admincheck == false
        flash[:reg_errors] = ["you do not have admin authorization"]
        flash[:register] = true
        redirect_to root_path
        return
      end
    end
    @user = User.create(user_params)
    if @user.valid?
      @user.save
      session[:id] = @user.id
      flash[:notice] = ["You have successfully registered"]
    else
      flash[:reg_errors] = @user.errors.full_messages
      flash[:register] = true
    end
    if @admincheck == true
      @admin = Admin.create(user:@user)
      if @admin.valid?
        @admin.save
        flash[:notice] = ["You have successfully registered as an administrator"]
      else
        flash[:reg_errors] = @admin.errors.full_messages
        flash[:register] = true
      end
    end
    redirect_to root_path
  end

  def login
    @user = User.find_by(email:params[:email])
    if @user
      if @user.authenticate(params[:password])
        session[:id] = @user.id
        redirect_to root_path
      else
        flash[:log_errors] = ["Invalid password"]
        flash[:sign_on] = true
        redirect_to root_path
      end
    else
      flash[:log_errors] = ["Email not found"]
      flash[:sign_on] = true
      redirect_to root_path
    end
  end
end


private


  def user_params
    params.require(:user).permit(:name, :email, :password)
  end

  def admin_check
    if params[:admin_code] == "XIXI"
      true
    else
      false
    end
  end
