require 'sinatra/base'
require 'sinatra/reloader'
require_relative './lib/bookmark'

class BookmarkManager < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end
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
    Bookmark.add(url,title)
    redirect '/bookmarks'
  end

  delete '/bookmarks/:id' do
    Bookmark.delete(params[:id])
    redirect '/bookmarks'
  end

  post '/bookmarks/update/:update_id' do
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
