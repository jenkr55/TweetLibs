class FixColumnName < ActiveRecord::Migration[5.0]
  def change
  	rename_column :tweets, :Text, :text
  	rename_column :tweets, :Date, :date
  	rename_column :tweets, :Favorites, :favorites
  	rename_column :tweets, :Retweets, :retweets
  	rename_column :tweets, :TweetID, :tweetid
  end
end
