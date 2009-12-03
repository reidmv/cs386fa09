
# Please do not read this. it will hurn your eyes and your brain.
# it was cobbled together with great rapidity and little care
# for a class project, and during the initial rails learning 
# curve. Seriously, don't look at it.

class HostsController < ApplicationController
  # GET /hosts
  # GET /hosts.xml
  def index
    @hosts = Host.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @hosts }
    end
  end

  def admin
    render
  end

  def edit_wiring
    @hosts = Host.all
    render
  end

  def editing_wiring
    @ports = Port.find_by_sql("
               SELECT ports.id AS port_id, ports.label AS port_label, TEXTCAT(hosts.hostname, TEXTCAT(' (', TEXTCAT(ports.label, ')'))) AS desc
               FROM   ports LEFT JOIN hosts ON (ports.host_id=hosts.id)")

    @h_ports = Port.find_by_sql("
               SELECT ports.id AS port_id, ports.label AS port_label, hosts.hostname AS hostname
               FROM   ports LEFT JOIN hosts ON (ports.host_id=hosts.id)
               WHERE  ports.host_id = #{params[:hostname][:id]};")                   
    
    
    if @h_ports.first.nil?
      @h_ports = Host.find(params[:hostname][:id])
      flash[:notice] = @h_ports.hostname + " does not have any ports."
      redirect_to :action => :edit_wiring
    else
      render :action => :editing_wiring
    end
  end

  def edited_wiring

    if params[:commit] == 'Connect'
      @wiring = Wiring.new
      @wiring.port_id1 = params[:h_port][:id]
      @wiring.port_id2 = params[:f_port][:id]
      @wiring.save
      flash[:notice] = "Connection added"
      redirect_to :action => :edit_wiring 
    elsif params[:commit] == 'Disconnect'
      @wiring = Wiring.find_by_sql("
               SELECT id
               FROM   connections
               WHERE  port_id = #{params[:h_port][:id]}
               LIMIT 1;")
 
      if @wiring.first.nil?
        flash[:notice] = "Not connected"
        redirect_to :action => :edit_wiring and return
      else
        @wiring.first.destroy
        flash[:notice] = "Disconnected"
        redirect_to :action => :edit_wiring and return
      end
    end
  end

  def show_wiring
    @hosts = Host.all
    render
  end

  def shown_wiring
    @connections = Host.find_by_sql("
             SELECT hosts.hostname AS hostname, ports.label AS label, f_hosts.hostname AS f_host, f_ports.label AS f_label
             FROM   hosts LEFT JOIN ports ON (hosts.id=ports.host_id)
                    LEFT JOIN connections ON (ports.id=connections.port_id)
                    LEFT JOIN ports f_ports ON (connections.port_id2=f_ports.id)
                    LEFT JOIN hosts f_hosts ON (f_ports.host_id=f_hosts.id)
             WHERE  hosts.id = #{params[:hostname][:id]};")

   #@hosts = Host.find(:all, 
   #                   :joins => [{:ports => :mac_addrs}, {:ports => :connection}],
   #                   :conditions => { "hosts.id" => params[:hostname][:id] },
   #                   :select => "hosts.hostname AS hostname,
   #                               ports.id AS port_id,
   #                               ports.label AS port_label,
   #                               mac_addrs.mac_address AS mac_address,
   #                               connections.port_id2 AS port_id2")

    if @connections.first.nil?
      @connections = Host.find(params[:hostname][:id]) 
      flash[:notice] = @connections.hostname + " does not have any connected ports."
      redirect_to :action => :show_wiring
    else
      render :action => :shown_wiring
    end
  end

  # GET /hosts/1
  # GET /hosts/1.xml
  def show
    @host = Host.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @host }
    end
  end

  # GET /hosts/new
  # GET /hosts/new.xml
  def new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @host }
    end
  end

  # GET /hosts/test
  # GET /hosts/test.xml
  def test
    @hosts = nil

    render :nothing => true
  end

  # GET /hosts/1/edit
  def edit
    @host = Host.find(params[:id])
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @hosts }
    end
  end

  def create
    @host = Host.new
    @port = Port.new
    @mac_addr = MacAddr.new

	ActiveRecord::Base.transaction do
      begin
        @host.hostname = params[:hostname]
        @host.building = params[:building]
        @host.room     = params[:room]
        @host.owner    = params[:owner]
        @host.save!
 
        @port.host_id  = @host.id
        @port.label    = params[:label]
        @port.save!
 
        @mac_addr.port_id = @port.id
        @mac_addr.mac_address = params[:mac_addr]
        @mac_addr.save!

        flash[:notice] = 'Host was successfully created.'
        render :action => :admin
      rescue
        flash[:notice] = 'Unable to create host.'
        render :action => :new
        raise ActiveRecord::Rollback
      end
	end
  end

  # PUT /hosts/1
  # PUT /hosts/1.xml
  def update
    @host = Host.find(params[:id])

    respond_to do |format|
      if @host.update_attributes(params[:host])
        flash[:notice] = 'Host was successfully updated.'
        format.html { redirect_to(@host) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @host.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /hosts/1
  # DELETE /hosts/1.xml
  def destroy
    @host = Host.find(params[:id])
    @host.destroy

    respond_to do |format|
      format.html { redirect_to(hosts_url) }
      format.xml  { head :ok }
    end
  end
end
