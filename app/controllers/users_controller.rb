class UsersController < ApplicationController
  def index
    @user = User.new
  end

  def create
    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
        @user_session = UserSession.new(@user)
        if @user_session.save
          
        end
        format.html { redirect_to root_path }
      else
        format.html { render :action => "index" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end
end
