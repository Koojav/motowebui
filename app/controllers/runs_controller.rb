class RunsController < ApplicationController

  def index
    @runs = Run.where(suite_id: params[:suite_id])
  end

  def show
    @run = Run.find(params[:id])

    @tests = @run.tests

    results = @tests.group(:result_id).count(:result_id)
    @stats = [0, 0, 0, 0, 0]

    results.each do |result_id, result_count|
      case result_id
        when 1
          @stats[0] += result_count
        when 2,6
          @stats[1] += result_count
        when 3,7
          @stats[2] += result_count
        when 4,8
          @stats[3] += result_count
        when 5,9
          @stats[4] += result_count
        else
          raise 'Unknown "result_id" in "test" table.'
      end
    end

  end

  def query(sql)
    results = ActiveRecord::Base.connection.execute(sql)
    if results.present?
      return results
    else
      return nil
    end
  end
  private :query

end
