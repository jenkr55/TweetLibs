class FixColumnType < ActiveRecord::Migration[5.0]
  def change
  	change_column :tweets, :tweetid, :string
  end
end
