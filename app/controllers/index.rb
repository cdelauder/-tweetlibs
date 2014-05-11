get '/' do
  erb :index
end

post '/' do
  redirect '/genre'
end

get '/genre' do
  erb :genre
end

post '/genre' do
  @genre = Genre.find(params[:genre])
  redirect '/select_users'
end

get '/select_users' do
  erb :select_users
end