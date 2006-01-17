class UsersController < ApplicationController
before_filter :login_required

 def index
    list
    render :action => 'list'
  end

  def list
    @user_pages, @users = paginate :users, :per_page => 10
  end
  
 # Add this line to get uplaod status for your action 
 # upload_status_for :upload

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

	def update_name
		@user = User.find(params[:id])
		if @user.update_attribute(:user_name, params[:value])
			render :layout => false, :inline => "<%= h(@user.user_name) %>" 
		else
			render :text => "Es ist ein Fehler aufgetreten(0000)" #TODO: Fehlernummer einfuegen
		end
	end
	def update_vorname
		@user = User.find(params[:id])
		if @user.update_attribute(:user_vorname, params[:value])
			render :layout => false, :inline => "<%= h(@user.user_vorname) %>" 
		else
			render :text => "Es ist ein Fehler aufgetreten(0000)" #TODO: Fehlernummer einfuegen
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
	def update_plz
		@user = User.find(params[:id])
		if @user.update_attribute(:user_plz, params[:value])
			render :layout => false, :inline => "<%= h(@user.user_plz) %>" 
		else
			render :text => "Es ist ein Fehler aufgetreten(0000)" #TODO: Fehlernummer einfuegen
		end
	end
	def update_ort
		@user = User.find(params[:id])
		if @user.update_attribute(:user_ort, params[:value])
			render :layout => false, :inline => "<%= h(@user.user_ort) %>" 
		else
			render :text => "Es ist ein Fehler aufgetreten(0000)" #TODO: Fehlernummer einfuegen
		end
	end
	def update_klasse
		@user = User.find(params[:id])
		if @user.update_attribute(:user_klasse, params[:value])
			render :layout => false, :inline => "<%= h(@user.user_klasse) %>" 
		else
			render :text => "Es ist ein Fehler aufgetreten(0000)" #TODO: Fehlernummer einfuegen
		end
	end
	def update_email
		@user = User.find(params[:id])
		if @user.update_attribute(:user_email, params[:value])
			render :layout => false, :inline => "<%= h(@user.user_email) %>" 
		else
			render :text => "Es ist ein Fehler aufgetreten(0000)" #TODO: Fehlernummer einfuegen
		end
	end

upload_status_for :update_pic
	def update_pic
		@user = User.find(params[:id])
    	upload_progress.message = "Upload ..."
		if @user.update_attribute(:user_pic, params[:user][:user_pic])
    		redirect_to :action => 'show', :id => @user.id
		else
			render :text => "Es ist ein Fehler aufgetreten(0000)" #TODO: Fehlernummer einfuegen
		end
	end

  def upload_status
    render :inline => '<%= upload_progress.completed_percent rescue 0 %> % complete <div>Uploaded am <%= Time.now %></div>', :layout => false
  end
 
  def destroy
    User.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
end
