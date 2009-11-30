class IpAddrsController < ApplicationController
  # GET /ip_addrs
  # GET /ip_addrs.xml
  def index
    @ip_addrs = IpAddr.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @ip_addrs }
    end
  end

  # GET /ip_addrs/1
  # GET /ip_addrs/1.xml
  def show
    @ip_addr = IpAddr.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @ip_addr }
    end
  end

  # GET /ip_addrs/new
  # GET /ip_addrs/new.xml
  def new
    @ip_addr = IpAddr.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @ip_addr }
    end
  end

  # GET /ip_addrs/1/edit
  def edit
    @ip_addr = IpAddr.find(params[:id])
  end

  # POST /ip_addrs
  # POST /ip_addrs.xml
  def create
    @ip_addr = IpAddr.new(params[:ip_addr])

    respond_to do |format|
      if @ip_addr.save
        flash[:notice] = 'IpAddr was successfully created.'
        format.html { redirect_to(@ip_addr) }
        format.xml  { render :xml => @ip_addr, :status => :created, :location => @ip_addr }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @ip_addr.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /ip_addrs/1
  # PUT /ip_addrs/1.xml
  def update
    @ip_addr = IpAddr.find(params[:id])

    respond_to do |format|
      if @ip_addr.update_attributes(params[:ip_addr])
        flash[:notice] = 'IpAddr was successfully updated.'
        format.html { redirect_to(@ip_addr) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @ip_addr.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /ip_addrs/1
  # DELETE /ip_addrs/1.xml
  def destroy
    @ip_addr = IpAddr.find(params[:id])
    @ip_addr.destroy

    respond_to do |format|
      format.html { redirect_to(ip_addrs_url) }
      format.xml  { head :ok }
    end
  end
end
