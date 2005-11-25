class TicketsController < ApplicationController
  def index
    list
    render :action => 'list'
  end

  def list
    @ticket_pages, @tickets = paginate :ticket, :per_page => 10
  end

  def show
    @ticket = Ticket.find(params[:id])
  end

  def new
    @ticket = Ticket.new
  end

  def create
    @ticket = Ticket.new(params[:ticket])
    if @ticket.save
      flash[:notice] = 'Ticket was successfully created.'
      redirect_to :action => 'list'
    else
      render :action => 'new'
    end
  end

  def edit
    @ticket = Ticket.find(params[:id])
  end

  def update
    @ticket = Ticket.find(params[:id])
    if @ticket.update_attributes(params[:ticket])
      flash[:notice] = 'Ticket was successfully updated.'
      redirect_to :action => 'show', :id => @ticket
    else
      render :action => 'edit'
    end
  end

  def destroy
    Ticket.find(params[:id]).destroy
    redirect_to :action => 'list'
  end

 def workflow
    Ticket.find(params[:id]).workflows.create(params[:workflow])
    flash[:notice] = "Eintrag hinzugefügt!"
    redirect_to :action => "show", :id => params[:id] 
 end	 
  
end