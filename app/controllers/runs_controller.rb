class RunsController < ApplicationController

  def index
    @runs = Run.where(suite_id: params[:suite_id])
  end

  def show
    @run = Run.find(params[:id])

    @tests = @run.tests

    unprocessed_stats = @tests.select('results.category').joins(:result).group(:category).count(:category)

    # gather all result categories
    categories = Result.all.group(:category).count(:category).keys

    @stats = {}

    categories.each do |category|
      @stats[category.downcase.to_sym] = unprocessed_stats[category] || 0
    end

    @stats

  end

end
