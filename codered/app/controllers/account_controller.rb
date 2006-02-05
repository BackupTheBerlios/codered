class AccountController < ApplicationController
  layout  'account'

  def login
    case @request.method
      when :post
      if @session[:user] = User.authenticate(@params[:user_login], @params[:user_password])
		  #[["Mentor",2], ["Betreuer",3], ["Kontakt",4], ["Deaktivieren",5]]
        flash['notice']  = "Login successful"
		@session[:rechte] = @session[:user].user_rule
		@session[:rechte_namen] = ["nil", "Admistrator", "Mentor", "Betreuer", "Kontakt", "Deaktiviert"] 
        redirect_back_or_default :action => "welcome"
      else
        flash.now['notice']  = "Login unsuccessful"

        @login = @params[:user_login]
      end
    end
  end
  
  def signup
    @user = User.new(@params[:user])

    if @request.post? and @user.save
      @session[:user] = User.authenticate(@user.login, @params[:user][:password])
      flash['notice']  = "Signup successful"
    #redirect_back_or_default :action => "welcome"
		@session[:rechte] = @session[:user].user_rule
		@session[:rechte_namen] = ["nil", "Admistrator", "Mentor", "Betreuer", "Kontakt", "Deaktiviert"] 
     redirect_to :controller => "users" , :action => 'show' , :id => @user.id
    end
  end  
  
  def logout
    @session[:user] = nil
  end
    
  def welcome
  end
 
end
