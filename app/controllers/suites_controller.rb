class SuitesController < ApplicationController

  def index
    @suites = Suite.all
  end

  def show
    @suite = Suite.find(params[:id])
  end

end
