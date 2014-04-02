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
  @homepage_images = GalleryImage.where(homepage: true).limit(6)
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
  if admin_present?
    redirect "/admin/dashboard"
  elsif params[:unauthorized]
    @flash = "You do not have permission to access this page. Please login to continue."
  end
  haml :"admin/login"
end

post "/login" do
  @admin = Admin.find_by(username: params[:username])
  if @admin.authenticate(params[:password])
    session[:user] = @admin
    redirect "/admin/dashboard"
  else
    @flash = "Invalid username or password"
    haml :"admin/login"
  end 
end

get "/logout" do
  session[:user] = nil
  redirect "/"
end

get "/admin/dashboard" do
  haml :"admin/index"
end

#gallery
get "/admin/gallery" do
  @cat = Category.all
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

get "/admin/gallery/:id/edit" do
  @image = GalleryImage.find(params[:id])
  haml :"admin/gallery/edit"
end

put "/admin/gallery/:id" do
  @image = GalleryImage.find(params[:id])
  if @image.update_attributes(params[:image])
    redirect "admin/gallery"
  else
    haml :"admin/gallery/edit"
  end
end

get "/admin/gallery/category/new" do
  @cat = Category.new
  haml :"admin/gallery/category/new"
end

post "/admin/category" do
  @cat = Category.new(params[:cat])
  if @cat.save
    redirect "admin/gallery"
  else
    haml :"admin/gallery/category/new"
  end
end

delete "/admin/gallery/category/:id" do
  Category.find(params[:id]).destroy
  redirect "admin/gallery"
end

get "/admin/gallery/category/:id/edit" do
  @cat = Category.find(params[:id])
  haml :"admin/gallery/category/edit"
end

put "/admin/gallery/category/:id" do
  @cat = Category.find(params[:id])
  if @cat.update_attributes(params[:cat])
    redirect "admin/gallery"
  else
    haml :"admin/gallery/category/edit"
  end
end

#commentaries
get "/admin/commentaries" do
  @posts = Post.all
  haml :"admin/commentaries/index"
end

get "/admin/commentaries/new" do
  @post = Post.new
  haml :"admin/commentaries/new"
end

post "/admin/commentaries" do
  @post = Post.new(params[:commentary])
  if @post.save
    redirect "admin/commentaries"
  else
    haml :"admin/commentaries/new"
  end
end

delete "/admin/commentaries/:id" do
  Post.find(params[:id]).destroy
  redirect "admin/commentaries"
end

get "/admin/commentaries/:id/edit" do
  @post = Post.find(params[:id])
  haml :"admin/commentaries/edit"
end

put "/admin/commentaries/:id" do
  @post = Post.find(params[:id])
  if @post.update_attributes(params[:commentary])
    redirect "admin/commentaries"
  else
    haml :"admin/commentaries/edit"
  end
end

#biography admin
get "/admin/bio" do
  @docs = Document.all
  haml :"admin/bio/index"
end

get "/admin/docs/new" do
  @doc = Document.new
  haml :"admin/bio/documents/new"
end

post "/admin/docs" do
  @doc = Document.new(params[:doc])
  if @doc.save
    redirect "admin/bio"
  else
    haml :"admin/bio/documents/new"
  end
end

delete "/admin/docs/:id" do
  Document.find(params[:id]).destroy
  redirect "admin/bio"
end

get "/admin/docs/:id/edit" do
  @post = Post.find(params[:id])
  haml :"admin/bio/documents/edit"
end

put "/admin/docs/:id" do
  @post = Post.find(params[:id])
  if @post.update_attributes(params[:doc])
    redirect "admin/commentaries"
  else
    haml :"admin/bio/documents/edit"
  end
end
