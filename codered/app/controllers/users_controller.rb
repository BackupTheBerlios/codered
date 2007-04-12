class UsersController < ApplicationController
before_filter :login_required

 def index
    list
    render :action => 'list'
  end

  def list
    @user_pages, @users = paginate :users, :per_page => 10
    @mentor_user_pages, @mentor_users = paginate :users, :per_page => 10,
	:conditions => ["user_rule = 2"],
	:order => 'updated_on'
    @betreuer_user_pages, @betreuer_users = paginate :users, :per_page => 10,
	:conditions => ["user_rule = 3"],
	:order => 'updated_on'
    @deaktivatet_user_pages, @deaktivatet_users = paginate :users, :per_page => 10,
	:conditions => ["user_rule = 5"],
	:order => 'updated_on'
    @kontakt_user_pages, @kontakt_users = paginate :users, :per_page => 10,
	:conditions => ["user_rule = 4"],
	:order => 'updated_on'
  end

  def show
    
    @user = User.find(params[:id])
    @selected = @user.knows.collect { |t| t.know_id.to_i }
    @knows = Know.find(:all, :conditions => params[:id])
      
    if @user.user_strasse.blank?
    	@user.user_strasse = "Kein Eintrag"
    end
    if @user.user_telefon.blank?
    	@user.user_telefon = "Kein Eintrag"
    end
    if @user.user_ort.blank?
    	@user.user_ort = "Kein Eintrag"
    end
    if @user.user_klasse.blank?
    	@user.user_klasse = "Kein Eintrag"
    end
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
      render :action => 'show'
    end
  end

  def set_user_password
    @user = User.find(params[:id])
    @user.password_confirmation = params[:user][:password_confirmation]
    @user.password = params[:user][:password]
    if @user.save
       flash['notice']  = "Password change successful"
       render(:action => 'show', :id => params[:id])
    else
          flash['notice']  = "alert", @user.errors.each_full { |msg| puts msg }
       	  render(:action => 'show', :id => params[:id])
    end
  end
  def set_user_user_klasse
    @@user = User.find(params[:id])
    @@user.password_confirmation =  @@user.password
    old = @@user.user_klasse
    if params[:value].blank?
	@@print = 'Keine Eingabe'
    else
        @@print = params[:value]
    end
    @@user.user_klasse = params[:value]
    if @@user.save
       render :update do |page|
        page.replace_html( "user_user_klasse_#{params[:id]}_in_place_editor", 
                          @@print )
       end 
    else
            render :update do |page| 
	    page.replace_html( "user_user_klasse_#{params[:id]}_in_place_editor", 
                           old )
            page.call( "alert", @@user.errors.each_full { |msg| puts msg } )
            end
    end
  end
	
  def set_user_user_ort
    @@user = User.find(params[:id])
    @@user.password_confirmation =  @@user.password
    old = @@user.user_ort
    if params[:value].blank?
	@@print = 'Keine Eingabe'
    else
        @@print = params[:value]
    end
    @@user.user_ort = params[:value]
    if @@user.save
       render :update do |page|
        page.replace_html( "user_user_ort_#{params[:id]}_in_place_editor", 
                          @@print )
       end 
    else
            render :update do |page| 
	    page.replace_html( "user_user_ort_#{params[:id]}_in_place_editor", 
                           old )
            page.call( "alert", @@user.errors.each_full { |msg| puts msg } )
            end
    end
  end
	
  def set_user_user_strasse
    @@user = User.find(params[:id])
    @@user.password_confirmation =  @@user.password
    old = @@user.user_strasse
    if params[:value].blank?
	@@print = 'Keine Eingabe'
    else
        @@print = params[:value]
    end
    @@user.user_strasse = params[:value]
    if @@user.save
       render :update do |page|
        page.replace_html( "user_user_strasse_#{params[:id]}_in_place_editor", 
                          @@print )
       end 
    else
            render :update do |page| 
	    page.replace_html( "user_user_strasse_#{params[:id]}_in_place_editor", 
                           old )
            page.call( "alert", @@user.errors.each_full { |msg| puts msg } )
            end
    end
  end
def set_user_user_telefon
    @@user = User.find(params[:id])
    old = @@user.user_telefon
    if params[:value].blank?
	@@print = 'Keine Eingabe'
    else
        @@print = params[:value]
    end
    @@user.user_telefon = params[:value]
    @@user.password_confirmation =  @@user.password
    if @@user.save
       render :update do |page|
        page.replace_html( "user_user_telefon_#{params[:id]}_in_place_editor", 
                          @@print )
       end 
    else
            render :update do |page| 
	    page.replace_html( "user_user_telefon_#{params[:id]}_in_place_editor", 
                           old )
            page.call( "alert", @@user.errors.each_full { |msg| puts msg } )
            end
    end
  end
	
  def set_user_user_plz
    @@user = User.find(params[:id])
    @@user.password_confirmation =  @@user.password
    old = @@user.user_plz
    if params[:value].blank?
	@@print = 'Keine Eingabe'
    else
        @@print = params[:value]
    end
    @@user.user_plz = params[:value]
    if @@user.save
       render :update do |page|
        page.replace_html( "user_user_plz_#{params[:id]}_in_place_editor", 
                          @@print )
       end 
    else
            render :update do |page| 
	    page.replace_html( "user_user_plz_#{params[:id]}_in_place_editor", 
                           old )
            page.call( "alert", @@user.errors.each_full { |msg| puts msg } )
            end
    end
  end
	
  def set_user_user_name
    @@user = User.find(params[:id])
    @@user.password_confirmation =  @@user.password
    old = @@user.user_name
    if params[:value].blank?
	@@print = 'Keine Eingabe'
    else
        @@print = params[:value]
    end
    @@user.user_name = params[:value]
    if @@user.save
       render :update do |page|
        page.replace_html( "user_user_name_#{params[:id]}_in_place_editor", 
                          @@print )
       end 
    else
            render :update do |page| 
	    page.replace_html( "user_user_name_#{params[:id]}_in_place_editor", 
                           old )
            page.call( "alert", @@user.errors.each_full { |msg| puts msg } )
            end
    end
  end
	
  def set_user_user_vorname
    @@user = User.find(params[:id])
    @@user.password_confirmation =  @@user.password
    old = @@user.user_vorname
    if params[:value].blank?
	@@print = 'Keine Eingabe'
    else
        @@print = params[:value]
    end
    @@user.user_vorname = params[:value]
    if @@user.save
       render :update do |page|
        page.replace_html( "user_user_vorname_#{params[:id]}_in_place_editor", 
                          @@print )
       end 
    else
            render :update do |page| 
	    page.replace_html( "user_user_vorname_#{params[:id]}_in_place_editor", 
                           old )
            page.call( "alert", @@user.errors.each_full { |msg| puts msg } )
            end
    end
  end
	
  def set_user_login
    @@user = User.find(params[:id])
    @@user.password_confirmation =  @@user.password
    old = @@user.login
    if params[:value].blank?
	@@print = 'Keine Eingabe'
    else
        @@print = params[:value]
    end
    @@user.login = params[:value]
    if @@user.save
       render :update do |page|
        page.replace_html( "user_login_#{params[:id]}_in_place_editor", 
                          @@print )
       end 
    else
            render :update do |page| 
	    page.replace_html( "user_login_#{params[:id]}_in_place_editor", 
                           old )
            page.call( "alert", @@user.errors.each_full { |msg| puts msg } )
            end
    end
  end
	
  def set_user_user_email
    @@user = User.find(params[:id])
    @@user.password_confirmation =  @@user.password
    old = @@user.user_email
    if params[:value].blank?
	@@print = 'Keine Eingabe'
    else
        @@print = params[:value]
    end
    @@user.user_email = params[:value]
    if @@user.save
       render :update do |page|
        page.replace_html( "user_user_email_#{params[:id]}_in_place_editor", 
                          @@print )
       end 
    else
            render :update do |page| 
	    page.replace_html( "user_user_email_#{params[:id]}_in_place_editor", 
                           old )
            page.call( "alert", @@user.errors.each_full { |msg| puts msg } )
            end
    end
  end
	
upload_status_for :update_pic
	def update_pic
		@user = User.find(params[:id])
    		upload_progress.message = "Upload ..."
	if @session[:rechte] == 1 || @user == @session[:user] then
		@user.user_pic = params[:user][:user_pic]
    		@user.password_confirmation =  @user.password
		if @user.save then
			flash[:notice] = 'Bild erfolgreich hochgeladen'
    			redirect_to :action => 'show', :id => @user.id
		else
			flash[:notice] = 'Die Datei muss ein Bild sein' 
    			redirect_to :action => 'show', :id => @user.id
		end
	end
	end

  def upload_status
    render :inline => '<%= upload_progress.completed_percent rescue 0 %> % complete <div>Uploaded am <%= Time.now %></div>', :layout => false
  end
 def update_rule
	@user = User.find(params[:id])
       if @session[:rechte] <= 2
	if @user.update_attribute(:user_rule, params[:user][:user_rule])
		CodeRedMailer::deliver_user_rule_change(@user)
		redirect_to :action => 'show', :id => @user.id
	else
		render :text => "Es ist ein Fehler aufgetreten(0000)" #TODO: Fehlernummer einfuegen
	end
       end
 end


  def destroy
    if @session[:rechte] == 1
    	@user = Ticket.find(:first, :conditions => [ "user_id = ?", params[:id]])
	if @user
		#update mit kram
		@user = User.find(params[:id])
		@user.update_attribute(:login, "disable")
		@user.update_attribute(:user_name, "disable")
		@user.update_attribute(:user_vorname, "disable")
		@user.update_attribute(:user_plz, "0")
		@user.update_attribute(:user_klasse, "disable")
		@user.update_attribute(:user_email, "disable")
		@user.update_attribute(:user_ort, "disable")
		@user.update_attribute(:user_telefon, "disable")
		@user.update_attribute(:user_rule, "0")
		@user.update_attribute(:user_strasse, "disable")
		@user.update_attribute(:password, "")
		@user.update_attribute(:user_pic, nil)
	else
    		@betreuer = Ticket.find(:first, :conditions => [ "betreuer_id = ?", params[:id]])
		if @betreuer
		 #update mit kram
		@user = User.find(params[:id])
		@user.update_attribute(:login, "disable")
		@user.update_attribute(:name, "disable")
		@user.update_attribute(:vorname, "disable")
		@user.update_attribute(:user_plz, "0")
		@user.update_attribute(:user_klasse, "disable")
		@user.update_attribute(:user_email, "disable")
		@user.update_attribute(:user_ort, "disable")
		@user.update_attribute(:user_telefon, "disable")
		@user.update_attribute(:user_rule, "0")
		@user.update_attribute(:user_strasse, "disable")
		@user.update_attribute(:password, "")
		@user.update_attribute(:user_pic, nil)
		else
		#wenn der nutzer noch nie benutzt wurde kann er einfach gelöscht werden
		User.find(params[:id]).destroy
		end
	end
    	redirect_to :action => 'list'
	else
		render :action => 'new'
    end
  end
  
  def addknows 

  @user_id = @session[:user].id #hole die id aus der session 
  @user = User.find(@user_id) #hole den user zur id 
  @user.update_attributes(params[:user])
  redirect_to :action => 'show', :id => @user.id
 end 

end
