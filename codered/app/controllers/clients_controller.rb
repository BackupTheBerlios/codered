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
    @client = Client.find(params[:id])
  end

  def update
    @client = Client.find(params[:id])
    if @client.update_attributes(params[:client])
      flash[:notice] = 'Client was successfully updated.'
      redirect_to :action => 'show', :id => @client
    else
      render :action => 'edit'
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
    Client.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
end
