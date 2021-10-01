class StaticPagesController < ApplicationController
  def home
    @tournaments = Tournament.all
  end
end
