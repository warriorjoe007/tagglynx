class WebpagesController < ApplicationController
  # GET /webpages
  # GET /webpages.json
  def index
    if !params[:url].nil?
      crt_pg = Webpage.find_by_url(params[:url])
        if crt_pg.nil?
          @pg = Webpage.new(:url => params[:url],
                           :user_id => session[:user_id],
                           :title => params[:title])
          @pg.save!
          session[:url]=@pg.url
          puts "crt_url is" + session[:url]
          redirect_to @pg
          return
        else
          session[:url]=crt_pg.url
          puts "crt_url is" + session[:url]
          redirect_to crt_pg
          return
        end
    end


    @webpages = Webpage.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @webpages }
    end
  end

  # GET /webpages/1
  # GET /webpages/1.json
  def show
    @webpage = Webpage.find(params[:id])
    @discussions = @webpage.discussions.all.sort_by{ |d| d[:created_at] }
    session[:web_id]=@webpage.id
    @discussion = Discussion.new
    @comment = Comment.new
    respond_to do |format|
          session[:url]=@webpage.url
          puts "crt_url is" + session[:url]      
      format.html # show.html.erb
      format.json { render json: @webpage }
    end
  end

  # GET /webpages/new
  # GET /webpages/new.json
  def new
    @webpage = Webpage.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @webpage }
    end
  end

  # GET /webpages/1/edit
  def edit
    @webpage = Webpage.find(params[:id])
  end

  # POST /webpages
  # POST /webpages.json
  def create
    @webpage = Webpage.new(params[:webpage])

    respond_to do |format|
      if @webpage.save
        format.html { redirect_to @webpage, notice: 'Webpage was successfully created.' }
        format.json { render json: @webpage, status: :created, location: @webpage }
      else
        format.html { render action: "new" }
        format.json { render json: @webpage.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /webpages/1
  # PUT /webpages/1.json
  def update
    @webpage = Webpage.find(params[:id])

    respond_to do |format|
      if @webpage.update_attributes(params[:webpage])
        format.html { redirect_to @webpage, notice: 'Webpage was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @webpage.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /webpages/1
  # DELETE /webpages/1.json
  def destroy
    @webpage = Webpage.find(params[:id])
    @webpage.destroy

    respond_to do |format|
      format.html { redirect_to webpages_url }
      format.json { head :no_content }
    end
  end
end
