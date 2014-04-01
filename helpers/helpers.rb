helpers do
  # If @title is assigned, add it to the page's title.
  def title
    if @title
      "#{@title} - Linda R James"
    else
      "The Artwork of Linda R James"
    end
  end
 
  # Format the Ruby Time object returned from a post's created_at method
  # into a string that looks like this: 06 Jan 2012
  def pretty_date(time)
   time.strftime("%B %d, %Y")
  end

  def truncate(body)
    "#{body.slice!(0..170)}..."
  end

  #session helpers
  def admin_present?
    session[:user].present?
  end
end