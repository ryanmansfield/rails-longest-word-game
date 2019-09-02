# frozen_string_literal: true
require 'open-uri'
class GamesController < ApplicationController
  def new
    @letters = []
    charset = Array('a'..'z')
    @letters << Array.new(9) { charset.sample }
  end

  def score
    @score = compute_score(params[:word], params[:letters])
  end

  def compute_score(word, letters)
    if included?(word, letters.split('')) && english_word?(word)
      word.split('').count
    else
      0
    end
  end

  private

  def included?(guess, grid)
    guess.chars.all? { |letter| guess.count(letter) <= grid.count(letter) }
  end

  def english_word?(word)
    response = open("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(response.read)
    return json['found']
  end
end
