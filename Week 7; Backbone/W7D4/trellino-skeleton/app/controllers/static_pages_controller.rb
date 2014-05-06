class StaticPagesController < ApplicationController
  def root
    @boards = Board.includes(:lists, :cards).all
  end
end
