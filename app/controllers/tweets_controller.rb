class TweetsController < ApplicationController
	$streak = 0
	$lives = 3
	$guessInfo = ''
	$score = 0
	$prevScore = 0

	def index
		reset
	end

	def reset
		$lives = 3
		$streak = 0
		$score = 0
		$guessInfo = ''
		getView
	end

	def getView
		$word = getTweet();
		@tweet.text.gsub! $word, '__________'
	end

	def getTweet
		offset = rand(Tweet.count)

		@tweet = Tweet.offset(offset).first
		getRandomWord(@tweet);
	end

	def getRandomWord(tweet)

		# Not a quoted retweet
		if(tweet.text.match(/^"/))
			return getTweet
		end

		# make sure it's actually a word
	 	text = tweet.text.split(' ');
		text.delete_if { |x| x.match(/^"/) }
		text.delete_if { |x|  x.match(/^@/) }
		text.delete_if { |x|  x.match(URI.regexp) } # url
		text.delete_if { |x| x.length < 4 }
		text.delete_if { |x| x.match(/[^a-z0-9\s]/) }
	    randomWord = text[rand(text.count) - 1]

		if(text.length < 2)
			return getTweet
		else
			return randomWord
		end
	end

	def guess
		if params == nil
			redirect_do index
		end

		if params[:guess].downcase.strip == $word.downcase
			$guessInfo = "Correct!"
			$streak = $streak + 1
			$score = $score + $streak
		else
			if $lives == 0
				$prevScore = $score
				$lives = 3
				$streak = 0
				$score = 0
				$guessInfo = ''
				redirect_to tweets_lose_path
				return
			end

			$guessInfo = $word 
			$streak = 0
			$lives = $lives - 1
		end
		params[:guess] = ''
		getView
		render "index"
	end

	def lose
	end

	def new
		# Uncomment for importing from "tweets.csv" file
		# options = {}
		#   SmarterCSV.process('tweets.csv', options) do |chunk|
     	#       chunk.each do |data_hash|
		#	    	if (data_hash[:text] != nil
	    #              Tweet.create!( data_hash )
	    #               Tweet.count
	    #            end
	    #        end
	    #    end

        puts "--------"
        puts Tweet.count
        puts "---------"
	end


	def show
       redirect_to "index"
    end
end
