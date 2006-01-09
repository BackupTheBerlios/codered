class UsersController < ApplicationController
before_filter :login_required
 def index
    list
    render :action => 'list'
  end

  def list
    @user_pages, @users = paginate :users, :per_page => 10
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:notice] = 'User was successfully created.'
      redirect_to :action => 'list'
    else
      render :action => 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:notice] = 'User was successfully updated.'
      redirect_to :action => 'show', :id => @user
    else
      render :action => 'edit'
    end
  end

	def update_strasse
		@user = User.find(params[:id])
		if @user.update_attribute(:user_strasse, params[:value])
			render :layout => false, :inline => "<%= h(@user.user_strasse) %>" 
		else
			render :text => "Es ist ein Fehler aufgetreten(0000)" #TODO: Fehlernummer einfuegen
		end
	end


  
  def destroy
    User.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
end
