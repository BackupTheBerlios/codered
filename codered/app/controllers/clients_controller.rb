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
  end

  def new
    @client = Client.new
  end

  def create
    @client = Client.new(params[:client])
	@client.user_id = User.find(params[:user]).id
    if @client.save
      flash[:notice] = 'Client wurde erfolgreich erstellt' 
      redirect_to :action => 'show', :id => @client.id 
    else
      render :action => 'new'
    end
  end

  def edit
	if @session[:rechte] == 1
		@client = Client.find(params[:id])
	else 
	   render :action => 'new'
    end
  end

  def update
    @client = Client.find(params[:id])
	if @session[:rechte] == 1
    if @client.update_attributes(params[:client])
      flash[:notice] = 'Client was successfully updated.'
      redirect_to :action => 'show', :id => @client
    else
      render :action => 'show'
    end
	else 
	   render :action => 'new'
    end
  end
	def update_name
		@client = Client.find(params[:id])
		if @client.update_attribute(:client_name, params[:value])
			render :layout => false, :inline => "<%= h(@client.client_name) %>" 
		else
			render :text => "Es ist ein Fehler aufgetreten(0000)" #TODO: Fehlernummer einfuegen
		end
	end
	def update_strasse
		@client = Client.find(params[:id])
		if @client.update_attribute(:client_strasse, params[:value])
			render :layout => false, :inline => "<%= h(@client.client_strasse) %>" 
		else
			render :text => "Es ist ein Fehler aufgetreten(0000)" #TODO: Fehlernummer einfuegen
		end
	end
	def update_plz
		@client = Client.find(params[:id])
		if @client.update_attribute(:client_plz, params[:value])
			render :layout => false, :inline => "<%= h(@client.client_plz) %>" 
		else
			render :text => "Es ist ein Fehler aufgetreten(0000)" #TODO: Fehlernummer einfuegen
		end
	end
	def update_ort
		@client = Client.find(params[:id])
		if @client.update_attribute(:client_ort, params[:value])
			render :layout => false, :inline => "<%= h(@client.client_ort) %>" 
		else
			render :text => "Es ist ein Fehler aufgetreten(0000)" #TODO: Fehlernummer einfuegen
		end
	end
	def update_email
		@client = Client.find(params[:id])
		if @client.update_attribute(:client_email, params[:value])
			render :layout => false, :inline => "<%= h(@client.client_email) %>" 
		else
			render :text => "Es ist ein Fehler aufgetreten(0000)" #TODO: Fehlernummer einfuegen
		end
	end
	def update_beschreibung
		@client = Client.find(params[:id])
		if @client.update_attribute(:beschreibung, params[:value])
			render :layout => false, :inline => "<%= h(@client.beschreibung) %>" 
		else
			render :text => "Es ist ein Fehler aufgetreten(0000)" #TODO: Fehlernummer einfuegen
		end
	end

upload_status_for :update_pic
	def update_pic
		@client = Client.find(params[:id])
    	upload_progress.message = "Upload ..."
		if @client.update_attribute(:client_pic, params[:client][:client_pic])
    		redirect_to :action => 'show', :id => @client.id
		else
			render :text => "Es ist ein Fehler aufgetreten(0000)" #TODO: Fehlernummer einfuegen
		end
	end

  def upload_status
    render :inline => '<%= upload_progress.completed_percent rescue 0 %> % complete <div>Uploaded am <%= Time.now %></div>', :layout => false
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
