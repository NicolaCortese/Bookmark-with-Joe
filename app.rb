require 'sinatra/base'
require 'sinatra/reloader'
require_relative './lib/bookmark'
require_relative './lib/database_connection_setup'
require 'sinatra/flash'

class BookmarkManager < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end
  register Sinatra::Flash
  enable :method_override, :sessions

  get '/' do
    'Bookmark Manager'
    redirect '/bookmarks'
  end

  get '/bookmarks' do
    @list = Bookmark.all
    erb :bookmarks
    # "List of Bookmarks"
  end

  get '/bookmarks/new' do
    erb :add_bookmark
  end

  post '/bookmarks' do
    url = params[:url]
    title = params[:title]
    flash[:notice] = "Please input a complete url" unless Bookmark.add(url,title)
    redirect '/bookmarks'
  end

  delete '/bookmarks/:id' do
    Bookmark.delete(params[:id])
    redirect '/bookmarks'
  end

  patch '/bookmarks/update/:update_id' do
    session[:update_id] = params[:update_id] 
    redirect '/bookmarks/update'
  end
    
  get '/bookmarks/update' do
    @current_bookmark = Bookmark.find(session[:update_id])
    erb :update_bookmark
  end

  post '/bookmarks/update' do
    Bookmark.update(session[:update_id],params[:new_url],params[:new_title])
    redirect '/bookmarks'
  end

  run! if app_file == $0
end
