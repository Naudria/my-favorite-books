class RatingsController <
  before_action :find_rating, only: [:show, :edit, :update]

  def index
  end

  def new
  end

  def show
  end

  def edit
  end

  private

  def rating_params
    params.require(:rating).permit(:stars, :book_id, :user_id, :notes)
  end

  def find_rating
    @rating = Rating.find_by(id: params[:id])
  end

end
