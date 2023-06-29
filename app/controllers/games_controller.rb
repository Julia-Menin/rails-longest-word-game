require "open-uri"

class GamesController < ApplicationController
  def new
    @letters = ('A'..'Z').to_a.sample(10)
  end

  def score
    answer = params[:answer].upcase.split("")
    letters = params[:letters].split
    if (answer - letters).empty? == false
      @answer = "I am sorry but '#{answer.join}' can't be built out of #{letters}"
    else
      valid = exist(answer.join)
      if valid
        @answer = "Congratulations! '#{answer.join}' is a valid English word"
      else
        @answer = "Mmm... Sorry, it looks like '#{answer.join}' is not a valid English word..."
      end
    end
  end

  def exist(answer)
    url = "https://wagon-dictionary.herokuapp.com/#{answer}"
    word = JSON.parse(URI.open(url).read)
    word["found"]
  end
end
