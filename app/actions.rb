# Homepage (Root path)

# Is it better to store the logged in user in session?

get '/' do
  erb :index
end

get '/songs' do
  @songs = Song.all
  erb :'songs/index'
end

get '/songs/new' do
  @song = Song.new
  erb :'songs/new'
end

get '/songs/show/:song_id' do
  @song = Song.find(params[:song_id])
  erb :'songs/show'
end

get '/songs/from/:user_id' do
  @user = User.find(params[:user_id])
  @songs = @user.songs
  erb :'songs/from_user'
end

get '/login' do
  @user = User.new
  erb :'users/login'
end

get '/logout' do
  session[:user_id] = nil
  redirect '/songs'
end

get '/register' do
  @user = User.new
  erb :'users/register'
end

post '/songs' do
  @song = Song.new(
    title: params[:title],
    url: params[:url],
    user_id: session[:user_id]
  )
  if @song.save
    redirect '/songs'
  else
    erb :'/songs/new'
  end
end

post '/login' do
  @user = User.find_by(email: params[:email])
  # TODO: display message when login fails
  case 
  when @user.nil?
    @login_error = "User not find."
    erb :'users/login'
  when params[:password] == @user.password
    session[:user_id] = @user.id
    redirect '/songs'
  else
    @login_error = "Wrong password."
    erb :'users/login'
  end
end

post '/register' do
  @user = User.new(
    email: params[:email],
    password: params[:password]
  )
  if @user.save
    session[:user_id] = @user.id
    redirect '/songs'
  else
    erb :'users/register'
  end
end

post '/songs/upvote/:id' do
  @upvote = Upvote.new
  @upvote.user = User.find(session[:user_id])
  @upvote.song = Song.find(params[:id]) # This query seems like a waste
  if @upvote.save
    redirect '/songs'
  else
    # TODO: display the errors on the songs/index page
    
  end
end
