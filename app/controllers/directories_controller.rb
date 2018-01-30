class DirectoriesController < ApplicationController
  helper_method :testers_all, :subdirectories, :manual_results_options

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

  def manual_results_options
    @manual_results_options ||= Result.where(manual: true).pluck(:id,:name)
  end
end
