require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = [*('A'..'Z')].sample(10).join
  end

  def score
    #is it an english word
    #whether the letter are inlcuded in the word
    @word = params[:word] # string
    @letters = params[:letters].split("") #string
      if included?(@word, @letters) === true
        api = JSON.parse(open("https://wagon-dictionary.herokuapp.com/#{@word}").read)
        if api["found"] === true
          @answer = "The word is valid according to the grid and is an English word"
        else
          @answer = "The word is valid according to the grid, but is not a valid English word"
        end
      else
        @answer = "The word can't be built out of the original grid"
      end
  end


  private

  def included?(word, letters)
    word.upcase.chars.all?{ |letter| word.count(letter) <= letters.count(letter) }
  end

  def isEnglish?(word)

  end

end

