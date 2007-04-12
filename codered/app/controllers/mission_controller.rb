class MissionController < ApplicationController

  def index
    list
    render :action => 'list'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
    # Nur Mentoren können alle Einsätze einsehen, alle anderen nur ihre eigenen
    if session[:rechte] == 2
      @mission_pages, @missions = paginate :missions, :per_page => 10
    else
      @mission_pages, @missions = paginate :missions, :per_page => 10, :conditions => ["user_id = ?", session[:user].id]
    end
  end

  def show
    @mission = Mission.find(params[:id])
  end

  def new
    @mission = Mission.new
  end

  def create
    @mission = Mission.new(params[:mission])
    @mission[:user_id] = session[:user].id
    if @mission.save
     flash[:notice] = 'Mission was successfully created.'
     redirect_to :action => 'list'
    else
      render :action => 'new'
    end
  end

  def edit
    @mission = Mission.find(params[:id])
  end

  def update
    @mission = Mission.find(params[:id])
    if @mission.update_attributes(params[:mission])
      flash[:notice] = 'Mission was successfully updated.'
      redirect_to :action => 'show', :id => @mission
    else
      render :action => 'edit'
    end
  end

  def destroy
    Mission.find(params[:id]).destroy
    redirect_to :action => 'list'
  end

end
