class UsersController < ApplicationController
   skip_before_action :authenticate_user!, :only => [:index, :show]
  
  def index
    @users = User.all
   

    render("users/index.html.erb")
  end

  def show
    @user = User.find(params[:id])
    @photos = @user.photos

    render("users/show.html.erb")
  end

  def new
    @user = User.new

    render("user/new.html.erb")
  end

  def create
    @photo = Photo.new

    @photo.caption = params[:caption]
    @photo.image = params[:image]
    @photo.user_id = current_user.id

    save_status = @photo.save

    if save_status == true
      redirect_to("/photos/#{@photo.id}", :notice => "Photo created successfully.")
    else
      render("photos/new.html.erb")
    end
  end

  def edit
    @user = User.find(params[:id])

    render("users/edit.html.erb")
  end

  def update
    @user = User.find(params[:id])

    @user.name = params[:username]
    @user.password = params[:user_password]
    @user.id = params[:user_id]

    save_status = @user.save

    if save_status == true
      redirect_to("/user/#{@user.id}", :notice => "User updated successfully.")
    else
      render("user/edit.html.erb")
    end
  end

  def destroy
    @photo = Photo.find(params[:id])

    @photo.destroy

    if URI(request.referer).path == "/photos/#{@photo.id}"
      redirect_to("/", :notice => "Photo deleted.")
    else
      redirect_to(:back, :notice => "Photo deleted.")
    end
  end
end
