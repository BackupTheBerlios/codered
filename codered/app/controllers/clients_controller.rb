class ClientsController < ApplicationController
before_filter :login_required
  def index
    list
    render :action => 'list'
  end

  def list
    @client_pages, @clients = paginate :clients, :per_page => 10
  end

  def show
    @client = Client.find(params[:id])
    @reports = Report.find(:all, :conditions => [ "client_id IN (?)", @client.id])
    @user = User.find(@client.user_id)
    if @client.client_ort.blank?
    	@client.client_ort = "Kein Eintrag"
    end
    if @client.client_email.blank?
    	@client.client_email = "Kein Eintrag"
    end
    if @client.client_strasse.blank?
    	@client.client_strasse = "Kein Eintrag"
    end
    if @client.beschreibung.blank?
    	@client.beschreibung = "Kein Eintrag"
    end
    
  end

  def new
	if @session[:rechte] >= 2 && @session[:rechte] <= 4
    	@client = Client.new
	end
  end

  def create
	if @session[:rechte] >= 2 && @session[:rechte] <= 4
    @client = Client.new(params[:client])
	@client.user_id = User.find(params[:user]).id
    if @client.save
      flash[:notice] = 'Client wurde erfolgreich erstellt' 
      redirect_to :action => 'show', :id => @client.id 
    else
      render :action => 'new'
    end
	end
  end

  def edit
	if @session[:rechte] == 1
		@client = Client.find(params[:id])
	else 
	   render :action => 'new'
    end
  end
def set_client_client_email
    @@client = Client.find(params[:id])
    old = @@client.client_email
    if params[:value].blank?
	@@print = 'Keine Eingabe'
    else
        @@print = params[:value]
    end
    @@client.client_email = params[:value]
    if @@client.save
       render :update do |page|
        page.replace_html( "client_client_email_#{params[:id]}_in_place_editor", 
                          @@print )
       end 
    else
            render :update do |page| 
	    page.replace_html( "client_client_email_#{params[:id]}_in_place_editor", 
                           old )
            page.call( "alert", @@client.errors.each_full { |msg| puts msg } )
            end
    end
  end
def set_client_client_ort
    @@client = Client.find(params[:id])
    old = @@client.client_ort
    if params[:value].blank?
	@@print = 'Keine Eingabe'
    else
        @@print = params[:value]
    end
    @@client.client_ort = params[:value]
    if @@client.save
       render :update do |page|
        page.replace_html( "client_client_ort_#{params[:id]}_in_place_editor", 
                          @@print )
       end 
    else
            render :update do |page| 
	    page.replace_html( "client_client_ort_#{params[:id]}_in_place_editor", 
                           old )
            page.call( "alert", @@client.errors.each_full { |msg| puts msg } )
            end
    end
  end
def set_client_client_plz
    @@client = Client.find(params[:id])
    old = @@client.client_plz
    if params[:value].blank?
	@@print = 'Keine Eingabe'
    else
        @@print = params[:value]
    end
    @@client.client_plz = params[:value]
    if @@client.save
       render :update do |page|
        page.replace_html( "client_client_plz_#{params[:id]}_in_place_editor", 
                          @@print )
       end 
    else
            render :update do |page| 
	    page.replace_html( "client_client_plz_#{params[:id]}_in_place_editor", 
                           old )
            page.call( "alert", @@client.errors.each_full { |msg| puts msg } )
            end
    end
  end
def set_client_client_strasse
    @@client = Client.find(params[:id])
    old = @@client.client_strasse
    if params[:value].blank?
	@@print = 'Keine Eingabe'
    else
        @@print = params[:value]
    end
    @@client.client_strasse = params[:value]
    if @@client.save
       render :update do |page|
        page.replace_html( "client_client_strasse_#{params[:id]}_in_place_editor", 
                          @@print )
       end 
    else
            render :update do |page| 
	    page.replace_html( "client_client_strasse_#{params[:id]}_in_place_editor", 
                           old )
            page.call( "alert", @@client.errors.each_full { |msg| puts msg } )
            end
    end
  end
def set_client_client_name
    @@client = Client.find(params[:id])
    old = @@client.client_name
    if params[:value].blank?
	@@print = 'Keine Eingabe'
    else
        @@print = params[:value]
    end
    @@client.client_name = params[:value]
    if @@client.save
       render :update do |page|
        page.replace_html( "client_client_name_#{params[:id]}_in_place_editor", 
                          @@print )
       end 
    else
            render :update do |page| 
	    page.replace_html( "client_client_name_#{params[:id]}_in_place_editor", 
                           old )
            page.call( "alert", @@client.errors.each_full { |msg| puts msg } )
            end
    end
  end
def update_beschreibung
		@client = Client.find(params[:id])
		if @client.update_attribute(:beschreibung, params[:value])
			render :layout => false, :inline => "<%= textilize(@client.beschreibung) %>" 
		else
			render :text => "Es ist ein Fehler aufgetreten(0000)" #TODO: Fehlernummer einfuegen
		end
	end

	def return_unformatted_text
		@client = Client.find(params[:id])
	    @unformatted_text =  @client.beschreibung
	    render :layout => false, :inline => "<%= @unformatted_text %>" 
	end

upload_status_for :update_pic
	def update_pic
		upload_progress.message = "Upload ..."
		@client = Client.find(params[:id])
		@client.client_pic = params[:client][:client_pic]
		if @client.save then
			flash[:notice] = 'Bild erfolgreich hochgeladen'
    			redirect_to :action => 'show', :id => @client.id
		else
			flash[:notice] = 'Das Bild muss ein Jpg,Png oder Bmp sein'
    			redirect_to :action => 'show', :id => @client.id
		end
	end

  def upload_status
    render :inline => '<div><%= upload_progress.completed_percent rescue 0 %> % complete Uploaded am <%= Time.now %></div>', :layout => false
  end


  def destroy
	if @session[:rechte] == 1	
    Client.find(params[:id]).destroy
    redirect_to :action => 'list'
	else 
	   render :action => 'new'
    end
  end
end
