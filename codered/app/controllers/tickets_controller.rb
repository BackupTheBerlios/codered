class TicketsController < ApplicationController
before_filter :login_required
  def index
    list
    render :action => 'list'
  end

  def list 
        @ticketstatus_namen = ["Neu", "Zugewiesen", "Vollzug gemeldet", "Abgeschlossen","","Ungültig"]

	@my_ticket_pages, @my_tickets = paginate :tickets, :per_page => 10,
	:conditions => ["betreuer_id = ? && ticket_status <= 2", @session[:user].id],
						  				:order => 'created_on'
	@all_ticket_pages, @all_tickets = paginate :tickets, :per_page => 10,
	:conditions => ["betreuer_id != ? && ticket_status <= 2 ", @session[:user].id],
						  				:order => 'created_on'
	@old_ticket_pages, @old_tickets = paginate :tickets, :per_page => 10,
	:conditions => ["Ticket_status >= 3 ", @session[:user].id],
						  				:order => 'created_on DESC'

  end
  
  def show
    @ticket = Ticket.find(params[:id])
    @ticket[:status_namen] = ["Neu", "Zugewiesen", "Vollzug gemeldet", "Abgeschlossen","","Ungültig"]
    @workflows = Workflow.find(:all, :conditions => ["ticket_id = (?)", @ticket.id] , :order => "created_on DESC")
  end

  def new
    if @session[:rechte] >= 2 && @session[:rechte] <= 4
		@ticket = Ticket.new
	end	
  end

  def create
if @session[:rechte] >= 2 && @session[:rechte] <= 4
    @ticket = Ticket.new(params[:ticket])
if @session[:user].user_rule ==	2 then 		#wenn ein neues Ticket erstellt wird von einem Mentor	
	@ticket.betreuer_id = @session[:user].id # wird es auch sofort diesem Mentor zugewiesen
else
	@mentoren = User.find(:all, :conditions => "user_rule = 2") # bei einem anderen Nutzer
	@ticket.betreuer_id = @mentoren[rand * @mentoren.size].id # wird ein "zufälliger" Mentor ausgesucht
end
	@ticket.user_id = @session[:user].id
    if @ticket.save
	CodeRedMailer::deliver_ticket_new(@ticket , User.find(@ticket.betreuer_id),
		Client.find(:first, :conditions => ["id=(?)",@ticket.client_id]))
      flash[:notice] = 'Ticket was successfully created.'
      redirect_to :action => 'list'
    else
      flash[:notice] = 'Ticket was not created.'
      render :action => 'new'
    end
	end
  end

  def edit
	if @session[:rechte] == 1
    	@ticket = Ticket.find(params[:id])
	else
      render :action => 'new'
    end
  end

  def update
	if @session[:rechte] == 1
    @ticket = Ticket.find(params[:id])
    if @ticket.update_attributes(params[:ticket])
      flash[:notice] = 'Ticket was successfully updated.'
      redirect_to :action => 'show', :id => @ticket
    else
      render :action => 'edit'
    end
	else
      render :action => 'new'
    end
  end

  def destroy
	if @session[:rechte] == 1	  
    Ticket.find(params[:id]).destroy
    redirect_to :action => 'list'
	else
      render :action => 'new'
    end
  end
end
