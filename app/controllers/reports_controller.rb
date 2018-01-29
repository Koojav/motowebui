class ReportsController < ApplicationController
  helper_method :tests_stats

  def show
    @directory = Directory.find(params[:directory_id])
  end

  # @return [Hash] where unique categories from Results are its keys and values correspond to amount of tests in a this directory's tree
  def tests_stats
    @tests_stats ||= @directory.test_statistics
  end
end
