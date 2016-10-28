class RunsController < ApplicationController

  def index
    @runs = Run.where(suite_id: params[:suite_id])
  end

  def show
    @run = Run.find(params[:id])

    @tests = @run.tests

    test_result_stats = @tests.select('results.category').joins(:result).group(:category).count(:category)

    # gather all result categories
    categories = Result.select(:category).group(:category).collect { |i| i.category }

    @stats = {}

    categories.each do |category|
      @stats[category.downcase.to_sym] = test_result_stats[category] || 0
    end

  end

end
