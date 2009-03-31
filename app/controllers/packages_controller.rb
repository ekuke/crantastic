class PackagesController < ApplicationController


  # GET /package
  # GET /package.xml
  def index
     #, :include => :versions

    respond_to do |format|
      format.html do
        if (id = params[:id] )
	  @packages = Package.find(:all, :order => "lower(package.name)", :offset =>((id.to_i-1)*5),:limit =>5)
        else
          @packages = Package.find(:all, :order => "lower(package.name)", :limit =>5)
	end
      end
      
      format.atom do
        @packages = Package.find(:all, :order => "package.created_at", :include => :versions, :conditions => "package.created_at IS NOT NULL")        
      end
    end
  end


  # GET /package/1
  # GET /package/1.xml
  def show
    id = params[:id]
    if (id.to_i != 0) 
      pkg = Package.find(id)
      response.headers["Status"] = "301 Moved Permanently"
      redirect_to url_for(pkg)
      return
    end
    
    @package = Package.find_by_name(id.gsub("-", "."))
        @version = @package.latest
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @package }
    end
  end


  # GET /package/search/package_name
  def search
      #format.html do
      	id = params[:id]
      @packages = Package.find(:all,:conditions => ["name like ?", "%"+id+"%"],:limit =>5)
      #end
      render :layout => false 
  end

end
