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
  erb :'login/default'
end

post '/songs' do
  @song = Song.new(
    title: params[:title],
    author: params[:author],
    url: (params[:url].empty?) ? nil : params[:url]
  )
  
  if @song.save
    redirect '/songs'
  else
    erb :'/songs/new'
  end
end

post '/login' do
  session[:user] = User.find_by(email: params[:email])
  redirect '/songs'
  # erb :'login/user'
end