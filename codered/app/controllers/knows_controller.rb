class KnowsController < ApplicationController
  def index
    list
    render :action => 'list'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
    @know_pages, @knows = paginate :knows, :per_page => 10
  end

  def show
    @know = Know.find(params[:id])
  end

  def new
    @know = Know.new
  end

  def create
    @know = Know.new(params[:know])
    if @know.save
      flash[:notice] = 'Know was successfully created.'
      redirect_to :action => 'list'
    else
      render :action => 'new'
    end
  end

  def edit
    @know = Know.find(params[:id])
  end

  def update
    @know = Know.find(params[:id])
    if @know.update_attributes(params[:know])
      flash[:notice] = 'Know was successfully updated.'
      redirect_to :action => 'show', :id => @know
    else
      render :action => 'edit'
    end
  end

  def destroy
    Know.find(params[:id]).destroy
    redirect_to :action => 'list'
  end

end   