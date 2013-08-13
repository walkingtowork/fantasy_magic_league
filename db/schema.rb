ActiveRecord::Schema.define(:version => 20130813020713) do

  create_table "league_player_joins", :force => true do |t|
    t.integer  "player_id"
    t.integer  "league_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "leagues", :force => true do |t|
    t.string   "name"
    t.integer  "admin_id"
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at",                        :null => false
    t.integer  "active_user_id"
    t.boolean  "in_process",     :default => false
    t.boolean  "increment_up",   :default => true
  end

  create_table "leagues_players", :force => true do |t|
    t.integer "league_id"
    t.integer "player_id"
    t.integer "pick_order"
    t.integer "user_id"
  end

  create_table "players", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "nationality"
    t.string   "pro_club_level"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "seasons", :force => true do |t|
    t.integer  "turn_order"
    t.integer  "user_id"
    t.integer  "league_id"
    t.boolean  "in_process", :default => false
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
  end

  create_table "teams", :force => true do |t|
    t.integer  "user_id"
    t.integer  "player_id"
    t.boolean  "is_active",  :default => false
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
  end

  create_table "tournaments", :force => true do |t|
    t.date     "date"
    t.string   "location"
    t.string   "tournament_type"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "username",                                      :null => false
    t.string   "email"
    t.string   "crypted_password"
    t.string   "salt"
    t.datetime "created_at",                                    :null => false
    t.datetime "updated_at",                                    :null => false
    t.string   "remember_me_token"
    t.datetime "remember_me_token_expires_at"
    t.integer  "buy_points",                   :default => 648
    t.integer  "victory_points"
  end

  add_index "users", ["remember_me_token"], :name => "index_users_on_remember_me_token"

end
