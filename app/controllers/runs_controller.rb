class RunsController < ApplicationController

  def index
    @runs = Run.all
  end

  def show
    @run = Run.find(params[:id])
  end

end
