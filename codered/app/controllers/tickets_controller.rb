class TicketsController < ApplicationController
before_filter :login_required
  def index
    list
    render :action => 'list'
  end

  def list 
  # @tickets_pages, @tickets = paginate :tickets, :per_page => 10
	@my_ticket_pages, @my_tickets = paginate :tickets, :per_page => 10,
										:conditions => ["betreuer_id = ? && ticket_status != 3", @session[:user].id],
						  				:order => 'created_on'
	@all_ticket_pages, @all_tickets = paginate :tickets, :per_page => 10,
										:conditions => ["betreuer_id != ? && ticket_status != 3 ", @session[:user].id],
						  				:order => 'created_on'
	@old_ticket_pages, @old_tickets = paginate :tickets, :per_page => 10,
										:conditions => ["Ticket_status = 3 ", @session[:user].id],
						  				:order => 'created_on DESC'

  end
  
  def show
    @ticket = Ticket.find(params[:id])
  end

  def new
    if @session[:rechte] >= 2 && @session[:rechte] <= 4
		@ticket = Ticket.new
	end	
  end

  def create
	if @session[:rechte] >= 2 && @session[:rechte] <= 4
    @ticket = Ticket.new(params[:ticket])
	@ticket.betreuer_id = User.find(params[:user]).id  # TODO UNbeding noch auf ein "automatisch freien Mentor suchen" anpassen!!
	@ticket.user_id = User.find(params[:user]).id
    if @ticket.save
      flash[:notice] = 'Ticket was successfully created.'
      redirect_to :action => 'list'
    else
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
