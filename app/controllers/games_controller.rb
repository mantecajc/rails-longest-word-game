require 'json'
require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = []
    @alph = ('A'..'Z').to_a
    10.times do
      @letters << @alph.sample
    end
  end

  def score
    @letters = params[:letters].split(' ')
    @answer = params[:answer]
    @answer_splitted = @answer.split('')
    @url = "https://wagon-dictionary.herokuapp.com/#{@answer}"
    @user_serialized = open(@url).read
    @user = JSON.parse(@user_serialized)
    # if (@answer_splitted.all? { |e| @letters.include?(e) }) &&
    if @answer_splitted.all? { |x| @answer_splitted.count(x) <= @letters.count(x) } == false
      @result = 'The word is not valid according to the grid'
    elsif @user["found"] == false
      @result = 'The word is valid according to the grid but is not an English word'
    else
      @result = "Well done ! The word #{@answer} is valid according to the grid and is an English word"
    end
  end
end
