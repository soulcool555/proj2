# app/controllers/workers_controller.rb
class WorkersController < ApplicationController
  def index
    @workers = Worker.all
    # new lines
    respond_to do |format|
      format.html { render :html => @workers }
      format.json { render :json => @workers }
    end
    # new lines ends
  end
  def create
    require "digest/md5"
    pass = Digest::MD5.hexdigest(params[:password])
    Worker.create(:name => params[:name],
      :username => params[:username],
      :password => pass,
      :department => params[:department])
  end
  def login
    if params[:username] == nil
      username = password = ""
    else
      username = params[:username]
      password = params[:password]
    end
    conn = ActiveRecord::Base.connection
    idString = conn.select_value("select get_id('" +
      username + "','" + password + "')")
    id = idString.to_i
    cookies.signed[:id] = id
    if id == 1
      redirect_to :controller => "workers", 
        :action => "admin"
    elsif id > 1
      redirect_to :controller => "workshops", :action => "index"
    end 
  end
  def logout
    cookies.signed[:id] = nil;
    redirect_to :controller => "workshops", :action => "summary"
  end
end
