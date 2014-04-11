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
  @homepage_images = GalleryImage.get_homepage_images
  haml :"pages/index", layout: :default
end

get "/bio" do
  @nav = "bio"
  haml :"pages/bio", layout: :default
end

get "/documents" do
  @nav = "documents"
  @docs = Document.all
  haml :"pages/bio", layout: :default
end

get "/commentary" do
  @nav = "commentary"
  @commentaries = Post.order("created_at DESC").limit(8)
  @commentary = @commentaries.first
  haml :"commentary/index", layout: :default
end

get "/commentary/:id" do
  @nav = "commentary"
  @commentaries = Post.order("created_at DESC").limit(8)
  @commentary = Post.find(params[:id])
  haml :"commentary/index", layout: :default
end

get "/gallery" do
  @categories = Category.all
  @category = @categories.first
  @image = @category.gallery_images.first
  @nav = "gallery"
  haml :"gallery/index", layout: :default
end

get "/gallery/:id" do
  @categories = Category.all
  @category = Category.find(params[:id])
  @image = @category.gallery_images.first
  @nav = "gallery"
  haml :"gallery/index", layout: :default
end

get "/image/:id" do
  @categories = Category.all
  @image = GalleryImage.find(params[:id])
  @category = @image.category
  @nav = "gallery"
  haml :"gallery/index", layout: :default
end

get "/galleryget/:id" do
  @image = GalleryImage.find(params[:id]).to_xml
end

get "/contact" do
  @nav = "contact"
  haml :"pages/contact", layout: :default
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
  if @admin && @admin.authenticate(params[:password])
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
  @nocat = GalleryImage.where(category_id: false)
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
  cat = Category.find(params[:id])
  cat.gallery_images.each do |img|
    img.update_attributes(category_id: false)
  end
  cat.destroy
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
  @doc = Document.find(params[:id])
  haml :"admin/bio/documents/edit"
end

put "/admin/docs/:id" do
  @doc = Document.find(params[:id])
  if @doc.update_attributes(params[:doc])
    redirect "admin/commentaries"
  else
    haml :"admin/bio/documents/edit"
  end
end
