#Filters
before do
  puts "This is process #{Process.pid}"
  puts "[params] ="
  p params
end

before "/admin/*" do
  unless admin_present?
    redirect "/admin?unauthorized=true"
  end
end


#page routes
get "/" do 
  haml :"pages/index", layout: :landing
end

get "/bio" do
  haml :"pages/bio"
end

get "/commentary" do
  haml :"commentary/index"
end

get "/gallery" do
  haml :"gallery/index"
end

get "/contact" do
  haml :"pages/contact"
end


#admin
get "/admin" do
  if params[:unauthorized]
    @flash = "You do not have permission to access this page. Please login to continue."
  end
  haml :"admin/login"
end

post "/login" do
  @admin = Admin.find_by(username: params[:username])
  if @admin.authenticate(params[:password])
    session[:user] = @admin
    redirect "/admin/index"
  else
    @flash = "Invalid username or password"
    haml :"admin/login"
  end 
end

get "/logout" do
  session[:user] = nil
  redirect "/"
end

get "/admin/index" do
  haml :"admin/index"
end

get "/admin/gallery" do
  @gallery = GalleryImage.all
  haml :"admin/gallery/index"
end

get "/admin/gallery/new" do
  @image = GalleryImage.new
  haml :"admin/gallery/new"
end

post "/admin/gallery" do
  @image = GalleryImage.new(params[:image])
  @image.image = params[:image][:image]
  if @image.save
    redirect "admin/gallery"
  else
    haml :"admin/gallery/new"
  end
end

delete "/admin/gallery/:id" do
  GalleryImage.find(params[:id]).destroy
  redirect "admin/gallery"
end
