class BooksController < ApplicationController
  def index
    @ratings = Rating.all

    if params[:rating] == "Most Reviewed"
      @books = Book.popular
    else
      @books = Book.all
    end
  end

  def new
    @book = Book.new
  end

  def show
    @book = Book.find_by(id: params[:id])
  end

  def create
    @book = Book.find_or_create_by(book_params)
    @book.creator_id = current_user.id
    if @book.valid?
      # Run the validations WITHOUT attempting to save to the database,
      # returning true if valid, false if not.
      @book.save
      redirect_to @book
      # Tells browser to perform a NEW REQUEST (throw @book away and let
      # the show action worry about re-reading it from the database)
    else
      render :new
      #If book is invalid, hold on to @book (because of useful error messages)
      # and re-render the :new page.
    end
  end

  def edit
    @book = Book.find_by(id: params[:id])
  end

  def update
    @book = Book.find_by(id: params[:id])
    @book.update(book_params)
    redirect_to @book
  end

  private

  def book_params
    params.require(:book).permit(:title, :genre, :author)
  end

end
