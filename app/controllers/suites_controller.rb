class SuitesController < ApplicationController

  def index
    @suites = Suite.all
  end

  def show
    @suite = Suite.find(params[:id])
    @runs = Run.where(suite_id: params[:id])
  end

end
