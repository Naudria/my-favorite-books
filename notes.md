rake routes
                   Prefix Verb   URI Pattern                                                                              Controller#Action
                     root GET    /                                                                                        welcome#home
                    users POST   /users(.:format)                                                                         users#create
                 new_user GET    /users/new(.:format)                                                                     users#new
                     user GET    /users/:id(.:format)                                                                     users#show
             book_ratings GET    /books/:book_id/ratings(.:format)                                                        ratings#index
                          POST   /books/:book_id/ratings(.:format)                                                        ratings#create
          new_book_rating GET    /books/:book_id/ratings/new(.:format)                                                    ratings#new
         edit_book_rating GET    /books/:book_id/ratings/:id/edit(.:format)                                               ratings#edit
              book_rating GET    /books/:book_id/ratings/:id(.:format)                                                    ratings#show
                          PATCH  /books/:book_id/ratings/:id(.:format)                                                    ratings#update
                          PUT    /books/:book_id/ratings/:id(.:format)                                                    ratings#update
                          DELETE /books/:book_id/ratings/:id(.:format)                                                    ratings#destroy
                    books GET    /books(.:format)                                                                         books#index
                          POST   /books(.:format)                                                                         books#create
                 new_book GET    /books/new(.:format)                                                                     books#new
                edit_book GET    /books/:id/edit(.:format)                                                                books#edit
                     book GET    /books/:id(.:format)                                                                     books#show
                          PATCH  /books/:id(.:format)                                                                     books#update
                          PUT    /books/:id(.:format)                                                                     books#update
                          DELETE /books/:id(.:format)                                                                     books#destroy
                  ratings GET    /ratings(.:format)                                                                       ratings#index
                          POST   /ratings(.:format)                                                                       ratings#create
               new_rating GET    /ratings/new(.:format)                                                                   ratings#new
              edit_rating GET    /ratings/:id/edit(.:format)                                                              ratings#edit
                   rating GET    /ratings/:id(.:format)                                                                   ratings#show
                          PATCH  /ratings/:id(.:format)                                                                   ratings#update
                          PUT    /ratings/:id(.:format)                                                                   ratings#update
                          DELETE /ratings/:id(.:format)                                                                   ratings#destroy
                   signin GET    /signin(.:format)                                                                        sessions#new
                          POST   /signin(.:format)                                                                        sessions#create
                  signout POST   /signout(.:format)                                                                       sessions#destroy


My ‘/books/:id’ convention becomes ‘/books/:book_id/ratings/:id’ once I navigate into my ratings routes. Why is this syntax change important? Now when my application receives a request to any of the actions defined in my RatingsController, a book ID is passed to me in the format of ‘params[:book_id].’

If I want my books#index action to display a collection of ratings that belong to the book that I am navigating under, I will need to pass ‘params[:book_id]’ in as an argument to stipulate that I only want ratings from the book who’s ID matches:

# file => app/controllers/ratings_controller.rb

def index
  @ratings = Rating.where("book_id = ?", params[:rating_id])
end

The ‘form_for’ Rails helper method requires you to pass in an object for each level of nesting.
Rails comes pre-loaded with a bunch of different useful helper methods, one of which is ‘form_for,’ which assists with the routing for model-based form input.

Typically, I would use an instance of a model as the sole argument in a form. When we create a new rating, with the models outlined earlier, what we are really doing is creating a new rating object that belongs to a book object. Therefore, without letting our ‘form_for’ element know which book we want to relate the form input to as well as which rating, our ‘form_for’ model will not work. An example of my form for creating a new rating is below.


