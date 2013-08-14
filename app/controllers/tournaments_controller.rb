class TournamentsController < ApplicationController
  def index
    @tournaments = Tournament.all
  end

  def new
    # binding.pry
    @tournament = Tournament.new
  end

  def create
    @tournament = Tournament.new(params[:tournament])

    if @tournament.save
      #Calls function in tournament.rb
      @tournament.update_player_info

      redirect_to root_path
    else
      render new_tournament_path
    end
  end


end