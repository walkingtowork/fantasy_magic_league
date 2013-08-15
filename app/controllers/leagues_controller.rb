class LeaguesController < ApplicationController
  def index
    @leagues = League.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @leagues }
    end
  end

  def show
    @league = League.find(params[:id])
    @user = User.find_by_username(params[:username])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @league }
    end
  end

  # Adds a User to the league
  def add_user
    @league = League.find(params[:id])
    @user = User.find_by_email(params[:email])
    # Check to see if User exists
    if @user == nil
      # redirect_to @league, notice: 'Could not find that User.'
      respond_to do |format|
        format.js
      end
    else
      @league.users << @user
      redirect_to @league
    end
  end

  # Option only appears if league hasn't started drafting yet
  def start_draft
    @league = League.find(params[:id])
    @user = User.all

    @league.set_turn_order
    @league.active_user_id = @league.users.where("turn_order = ?", 1).first.id
    @league.in_process = true
    @league.save

    redirect_to draft_path(@league)
  end

  # Populates the draft page
  def draft
    @league = League.find(params[:id])

    # All Players
    platinum_players = Player.where("pro_club_level = ?", "Platinum")
    gold_players = Player.where("pro_club_level = ?", "Gold")
    silver_players = Player.where("pro_club_level = ?", "Silver")

    # Players that have already been drafted
    selected_players = @league.players

    # Remaining players at each pro level
    @remaining_platinum_players = platinum_players - selected_players
    @remaining_gold_players = gold_players - selected_players
    @remaining_silver_players = silver_players - selected_players
  end

  # Controls the drafting-player action
  def select_player
    @league = League.find(params[:id])
    @player = Player.find(params[:selected_player])
    @user = current_user

    # Adds the player to the league
    # Adds the player to the User's Team
    @league.players << @player
    @user.players << @player

    # Increment turn order here
    # Active user changes
    @league.active_user_id = @league.increment_turn_order(current_user)
    @league.save
    redirect_to @league
  end

  # Ends the draft
  def end_draft
    @league = League.find(params[:id])

    @league.in_process = false
    @league.save

    redirect_to draft_path(@league)
  end

  # Determines winner of the League
  def determine_winner
    @league = League.find(params[:id])

    @league.find_winner
    binding.pry
    if @winner != nil
      binding.pry
      respond_to do |format|
        format.js
      end
    end
  end

  def new
    @league = League.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @league }
    end
  end

  def edit
    @league = League.find(params[:id])
  end

  def create
    @league = League.new(params[:league])

    respond_to do |format|
      if @league.save
        @user = current_user
        @league.users << @user

        format.html { redirect_to @league, notice: 'League was successfully created.' }
        format.json { render json: @league, status: :created, location: @league }
      else
        format.html { render action: "new" }
        format.json { render json: @league.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @league = League.find(params[:id])

    respond_to do |format|
      if @league.update_attributes(params[:league])
        format.html { redirect_to @league, notice: 'League was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @league.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @league = League.find(params[:id])
    @league.destroy

    respond_to do |format|
      format.html { redirect_to leagues_url }
      format.json { head :no_content }
    end
  end
end
