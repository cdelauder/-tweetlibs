get '/' do
  erb :index
end

post '/' do
  redirect '/genre'
end

get '/genre' do
  @genre = Genre.find(params)
  p params
end