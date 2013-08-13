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

  #Only appears if they haven't started drafting yet
  def start_draft
    @league = League.find(params[:id])
    @user = User.all

    @league.set_turn_order
    @league.active_user_id = @league.users.where("turn_order = ?", 1).first.id
    @league.in_process = true
    @league.save

    redirect_to draft_path(@league)
  end

  def draft
    @league = League.find(params[:id])
    @silver_players = Player.where("pro_club_level = ?", "Silver")
    @gold_players = Player.where("pro_club_level = ?", "Gold")
    @platinum_players = Player.where("pro_club_level = ?", "Platinum")

  end

  def add_user
    @league = League.find(params[:id])
    @user = User.find_by_email(params[:email])
    @league.users << @user
    redirect_to @league
  end

  def select_player
    @league = League.find(params[:id])
    @player = Player.find(params[:selected_player])
    @user = current_user

    @league.players << @player
    @user.players << @player

    # increment turn order here
    # active user changes
    @league.active_user_id = @league.increment_turn_order(current_user)

    redirect_to @league
  end

  def new
    @league = League.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @league }
    end
  end

  # GET /leagues/1/edit
  def edit
    @league = League.find(params[:id])
  end

  # POST /leagues
  # POST /leagues.json
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

  # PUT /leagues/1
  # PUT /leagues/1.json
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

  # DELETE /leagues/1
  # DELETE /leagues/1.json
  def destroy
    @league = League.find(params[:id])
    @league.destroy

    respond_to do |format|
      format.html { redirect_to leagues_url }
      format.json { head :no_content }
    end
  end
end
