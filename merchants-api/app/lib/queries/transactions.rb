# frozen_string_literal: true

module Queries
  class Transactions
    attr_reader :transactions

    def initialize(transactions = Transaction.all)
      @transactions = transactions
    end

    def call(params = {})
      scope = transactions
      scope = by_status(scope, params[:status])
      scope = by_type(scope, params[:type])
      scope = sort_column(scope, params[:sort], params[:direction])
      scope = scope.page(params[:page]).per(params[:limit])
    end

    private

    def by_status(scope, status = nil)
      status ? scope.where(status: status) : scope
    end

    def by_type(scope, type = nil)
      type ? scope.where(type: type) : scope
    end

    def sort_column(scope, sort, direction)
      sort_column = sort || 'created_at'
      sort_direction = %w[asc desc].include?(direction) ? direction : 'desc'
      scope.reorder(sort_column => sort_direction)
    end
  end
end
