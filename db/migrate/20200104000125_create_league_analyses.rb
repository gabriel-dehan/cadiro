class CreateLeagueAnalyses < ActiveRecord::Migration[5.2]
  def change
    create_table :league_analyses do |t|
      t.references :league, foreign_key: true
      t.references :analysis, foreign_key: true
      t.float :max_buyout
      t.float :min_sellout
      t.string :buyout_currency
      t.string :sellout_currency
      t.integer :occurences, default: 0
      t.integer :trades, default: 0
      t.integer :estimated_swipe_difficulty
      t.jsonb :search_params
      t.string :search_id
      t.text :comments

      t.timestamps
    end
  end
end
