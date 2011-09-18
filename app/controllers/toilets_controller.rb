class ToiletsController < ApplicationController
  # GET /toilets
  # GET /toilets.xml
  def nearby
@lat = params[:lat]
@lng = params[:lng]
@lat = @lat.sub('^','-')
@lat = @lat.sub('~','.')
@lng = @lng.sub('^','-')
@lng = @lng.sub('~','.')

@lng = @lng.to_f

@lat = @lat.to_f
    @toilets = Toilet.all #near([@lat,@lng],5)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @toilets }
    end
  end

  def index
        respond_to do |format|
      format.html # index.html.erb]
    end
  end

  # GET /toilets/1
  # GET /toilets/1.xml
  def show
    @toilet = Toilet.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @toilet }
    end
  end

end