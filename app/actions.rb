# Homepage (Root path)

# Is it better to store the logged in user in session?

get '/' do
  erb :index
end

get '/songs' do
  @songs = Song.all.order(upvotes_count: :desc)
  erb :'songs/index'
end

get '/songs/new' do
  @song = Song.new
  erb :'songs/new'
end

get '/songs/show/:song_id' do
  @song = Song.find(params[:song_id])
  @reviews = @song.reviews
  @new_review = Review.new
  erb :'songs/show'
end

get '/songs/from/:user_id' do
  @user = User.find(params[:user_id])
  @songs = @user.songs
  erb :'songs/from_user'
end

get '/login' do
  @user = User.new
  @errors = []
  erb :'users/login'
end

get '/logout' do
  session[:user_id] = nil
  redirect '/songs'
end

get '/register' do
  @user = User.new
  @errors = []
  erb :'users/register'
end

post '/songs' do
  @song = Song.new(
    title: params[:title],
    url: params[:url],
    user_id: session[:user_id]
  )
  @errors = []
  if @song.save
    redirect '/songs'
  else
    @errors = @user.errors.full_messages
    erb :'/songs/new'
  end
end

post '/login' do
  @user = User.find_by(email: params[:email])
  @errors = []
  case 
  when @user.nil?
    @errors << "User not found."
    erb :'users/login'
  when params[:password] == @user.password
    session[:user_id] = @user.id
    redirect '/songs'
  else
    @errors << "Wrong password."
    erb :'users/login'
  end
end

post '/register' do
  @user = User.new(
    email: params[:email],
    password: params[:password]
  )
  @errors = []
  if @user.save
    session[:user_id] = @user.id
    redirect '/songs'
  else
    @errors = @user.errors.full_messages
    erb :'users/register'
  end
end

post '/songs/upvote/:id' do
  @upvote = Upvote.new(user_id: session[:user_id], song_id: params[:id])
  @upvote.save
  # if upvote.save fails, it would do so silently
  redirect '/songs'
end

post '/review/:song_id' do
  @new_review = Review.new(
    user_id: session[:user_id], 
    song_id: params[:song_id],
    rating: params[:rating],
    content: params[:content]
    )
  if @new_review.save
    redirect "/songs/show/#{@new_review.song_id}"
  else
    @song = Song.find(params[:song_id])
    @reviews = @song.reviews
    # WARNING: wet code
    erb :'/songs/show'
  end
end

post '/reviews/delete/:review_id' do
  @delete_review = Review.find(params[:review_id])
  @delete_review.destroy!
  redirect "/songs/show/#{@delete_review.song.id}"
end