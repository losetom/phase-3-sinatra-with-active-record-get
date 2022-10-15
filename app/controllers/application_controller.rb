class ApplicationController < Sinatra::Base

  set :default_content_type, 'application/json'

  get '/games' do
    #gets all the games from the database
    games = Game.all.order(:title)
    #returns a JSON response with an array of all the game data
    games.to_json
  end

  #uses :id syntax to create a dynamic route
  get '/games/:id' do
    #look up the game in the database using its ID
    game = Game.find(params[:id])
    #sending a JSON-formatted response of the game data
    game.to_json(only: [:id, :title, :genre, :price], include: {
      reviews: { only: [:comment, :score], include: {
        user: { only: [:name] }
      } }
    })
  end

end
