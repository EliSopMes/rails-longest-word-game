require "open-uri"
require "json"

class GamesController < ApplicationController
  before_action :set_games, only: [:new, :score]

  def new
    @letters = (0...10).map { (65 + rand(26)).chr }
  end

  def score
    @valid_inputs = []
    @score = 0
    @answer = params[:answer].upcase.chars
    if grid_check?
      if english?
        @result = 'valid'
        @valid_inputs << params[:answer]
        @score += params[:answer].length
        # @valid_inputs.each do |word|
        #   @score += word.length
        # end
      else
        @result = 'invalid'
      end
    else
      @result = 'not in grid'
    end
  end

  def grid_check?
    answer = params[:answer].upcase.chars
    answer.all? { |letter| params[:array].include?(letter) }
  end

  def english?
    response = URI.open("https://wagon-dictionary.herokuapp.com/#{params[:answer]}")
    json = JSON.parse(response.read)
    json["found"]
  end
end
