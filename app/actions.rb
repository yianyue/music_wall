# Homepage (Root path)

enable :sessions

get '/' do
  erb :index
end

get '/songs' do
  @user = session[:user]
  @songs = Song.all
  erb :'songs/index'
end

get '/songs/new' do
  @song = Song.new
  erb :'songs/new'
end

get '/login' do
  @user = User.new
  erb :'users/login'
end

get '/logout' do
  session[:user] = nil
  redirect '/songs'
end

get '/register' do
  @user = User.new
  erb :'users/register'
end

get '/songs/from/:user_id' do
  @user = session[:user]
  @songs = @user.songs
  erb :'songs/index'
end

post '/songs' do
  @song = Song.new(
    title: params[:title],
    author: params[:author],
    url: params[:url]
  )
  
  if @song.save
    redirect '/songs'
  else
    erb :'/songs/new'
  end
end

post '/login' do
  @user = User.find_by(email: params[:email])
  session[:user] = @user if @user && params[:password] == @user.password
  if session[:user]
    redirect '/songs'
  else
    erb :'users/login'
  end
end

post '/register' do
  @user = User.new(
    email: params[:email],
    password: params[:password]
  )
  if @user.save
    session[:user] = @user
    redirect '/songs'
  else
    erb :'users/register'
  end
end