# Homepage (Root path)
helpers do
  def current_user
    @current_user = User.find_by(id: session[:user_id]) if session[:user_id]
  end
end



get '/' do
  #erb :index
  redirect '/login'
end

get '/login' do
  erb :login
end

post '/login' do
  username_or_email = params[:username_or_email]
  password = params[:password]

  user = User.where("username = ? or email = ?", username_or_email, username_or_email).first
  if user && user.password == password
    session[:user_id] = user.id
    erb :profile
  else
    redirect '/login'
  end
end

get '/signup' do
  erb :signup
end

post '/signup' do
  first_name = params[:first_name]
  last_name = params[:last_name]
  username = params[:username]
  email = params[:email]
  password = params[:password]
  
  user = User.find_by(username: username)
  if user
    redirect '/login'
  else
    user = User.create(first_name: first_name, last_name: last_name, username: username, email: email, password: password)
    session[:user_id] = user.id
    erb :account_created
  end
end

get '/edit_profile' do
  erb :edit_profile
end

get '/profile' do
  @user = User.find_by(params[:id])
  @movies = Movie.find_by(params[:id])
  erb :profile
end

post '/profile' do
  first_name = params[:first_name]
  last_name = params[:last_name]
  username = params[:username]
  email = params[:email]
  password = params[:password]

  current_user.update(first_name: first_name, last_name: last_name, username: username, email: email, password: password)
  
  if current_user
    redirect '/profile'
  else
    erb :logged_in
  end
  
end

get '/logout' do
  session.clear
  erb :logout
end

get '/movies/new' do
  erb :new_movie
end

post '/movies/create' do
  title = params[:title]
  release_date = params[:release_date]
  genre = params[:genre]
  director = params[:director]
  synopsis = params[:synopsis]

 movie = Movie.new(title: title, release_date: release_date, genre: genre, director: director, synopsis: synopsis)
  if movie.save
    redirect "/movies/#{movie.id}"
  else
    redirect '/movies/new'
  end
end
  
get '/movies/search' do
  title = params[:title]
  @movies = Movie.where("title like ?", "%#{title}%")
  if @movies.length > 1
    erb :movie_list
  else
    redirect "/movies/#{@movies.first.id}"
  end
end

get '/movies/:id' do
  @movie = Movie.find(params[:id])
  erb :movie
end

get '/movies/' do
  #how do i search and display a movie?!
  #if current_user
  #@movie = my movies
  "im here"

end

#  CREATE
get '/movies/:id/reviews/new' do
  #return an HTML form for creating a review
  @movie = Movie.find(params[:id])
  erb :new_review
end

post '/movies/:id/reviews/create' do
  rating = params[:rating]

  movie = Movie.find(params[:id])
  review = current_user.reviews.new(movie: movie, rating: rating)
  if review.save
    redirect "/movies/#{movie.id}"
  else
    redirect '/reviews/new'
  end
end

get '/movies' do
@movies = Movie.all
erb :all_movie
end
