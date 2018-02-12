class CreateTweets < ActiveRecord::Migration[5.0]
  def change
    create_table :tweets do |t|
      t.string :Text
      t.date :Date
      t.integer :Favorites
      t.integer :Retweets
      t.integer :TweetID

      t.timestamps
    end
  end
end
