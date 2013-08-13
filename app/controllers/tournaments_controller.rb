class TournamentsController < ApplicationController
  def index
    @tournaments = Tournament.all
  end

  def new
    @tournament = Tournament.new
  end

  def create
    @tournament = Tournament.new(params[:tournament])

    if @tournament.save
      redirect_to tournaments_path
    else
      render new_tournament_path
    end
  end


end