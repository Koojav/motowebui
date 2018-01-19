class DirectoriesController < ApplicationController
  helper_method :testers_all, :tests_stats, :subdirectories

  def index
    show
  end

  def show
    @directory = Directory.find(params[:id])

    # views/tests/_list is sometimes rendered when using this controller and requires @tests
    @tests = @directory.tests.includes(:result)
  end

  def subdirectories
    @subdirectories ||= Directory.find(params[:id]).subdirectories
  end

  def testers_all
    @testers_all ||= Tester.all
  end

  # @return [Array]
  #    [0] running
  #    [1] pass
  #    [2] error
  #    [3] fail
  #    [4] skip
  def tests_stats
    @tests_stats ||= [5, 15, 3, 1, 4]
        # [@directory.stats_tests_running,
        #               @directory.stats_tests_pass,
        #               @directory.stats_tests_error,
        #               @directory.stats_tests_fail,
        #               @directory.stats_tests_skip]
  end

end
