module RatingsHelper


  def show_stars(rating)
    case rating
    when 5
      "*""*""*""*""*"
    when 4
      "*""*""*""*"
    when 3
      "*""*""*"
    when 2
      "*""*"
    when 1
      "*"
    else
      "This book has not been rated yet."
    end
  end


  def book_id_field(rating)
    if rating.book.nil?
      select_tag "rating[book_id]", options_from_collection_for_select(Book.all, :id, :title), :prompt => "Select a book"
    else
      hidden_field_tag "rating[book_id]", rating.book.id
    end

  end
end
