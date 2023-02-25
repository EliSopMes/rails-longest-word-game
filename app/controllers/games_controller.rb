require 'open-uri'
require 'json'

# This ia the GamesController documentation comment
class GamesController < ApplicationController
  def new
    # @letters = (0...10).map { (65 + rand(26)).chr }
    @letters = []
    let = ('A'..'Z').to_a
    vowel = %w[A E I O U]
    2.times do
      @letters << vowel[rand(0..4)]
    end
    8.times do
      @letters << let[rand(0..25)]
    end
    @letters
  end

  def score
    @answer = params[:answer].upcase.chars
    @letters = params[:letters].split
    if grid_check?
      english? ? @result = 'valid' : @result = 'invalid'
    else
      @result = 'not in grid'
    end
  end

  private

  def grid_check?
    answer = params[:answer].upcase.chars
    answer.all? { |letter| params[:letters].include?(letter) }
  end

  def english?
    response = URI.open("https://wagon-dictionary.herokuapp.com/#{params[:answer]}")
    json = JSON.parse(response.read)
    json['found']
  end
end
