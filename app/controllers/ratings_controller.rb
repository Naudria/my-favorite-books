class RatingsController < ApplicationController
  before_action :find_rating, only: [:show, :edit, :update, :index]

  def index
    if params[:book_id]
      @ratings = Book.find(params[:book_id]).ratings

    else
      @ratings = Rating.all
    end


  end

  def new
    if params[:book_id] && !Book.exists?(params[:book_id])
      redirect_to books_path, flash[:message] = "Book not found."
    elsif @rating = Rating.find_by(user_id: current_user.id, book_id: params[:book_id])
      flash[:message] = "You've already reviewed this book."
      redirect_to book_rating_path(@rating.book_id, @rating)
    else
      @rating = Rating.new(:book_id => params[:book_id], :user_id => current_user.id)
    end
  end

  def show
    @rating = Rating.find(params[:id])
  end

  def create
    if @rating = Rating.find_by(user_id: current_user.id, book_id: params[:rating][:book_id])
      flash[:message] = "You've already reviewed this book."
      redirect_to book_rating_path(@rating.book_id, @rating)
    else
      @rating = Rating.new(rating_params)
      if @rating.save
        redirect_to book_rating_path(@rating.book, @rating)
      else
        render :new
      end
    end
  end

  def edit
    @book = Book.find_by(id: params[:book_id])

    if @rating.user_id != current_user.id
      redirect_to books_path
    end
  end

  def update
    @rating.update(rating_params)

    redirect_to book_rating_path(@rating.book, @rating)
  end


  private

  def rating_params
    params.require(:rating).permit(:stars, :book_id, :user_id, :notes)
  end

  def find_rating
    @rating = Rating.find_by(id: params[:id])
  end


end
