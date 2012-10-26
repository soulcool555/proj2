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
  def modify 
    worker = Worker.find_by_id(params[:id])
    require "digest/md5"
    pass = Digest::MD5.hexdigest(params[:password])
    worker.update_attributes(:name => params[:name],
      :username => params[:username],
      :password => pass,
      :department => params[:department])
  end  
  def destroy
    id = params[:id]
    Worker.destroy(id)   
  end 
  def login
    if params[:username] == nil
      username = password = ""
    else
      username = params[:username]
      password = params[:password]
 
    conn = ActiveRecord::Base.connection
    idString = conn.select_value("select get_id('" +
      username + "','" + password + "')")
    id = idString.to_i
    cookies.signed[:id] = id
      redirect_to :controller => "workers", 
        :action => "idlogin"
    end  
  end
  def idlogin
    id = cookies.signed[:id]
    respond_to do |format|
       format.html { render :text => id }
    end
  end
  def logout
    cookies.signed[:id] = nil;
    redirect_to :controller => "workshops", :action => "summary"
  end
end
