module StrongParams
  extend Grape::API::Helpers

  def permitted_params(more_params = {})
    ActionController::Parameters.new(
      declared(params, include_missing: false).merge(more_params)
    ).permit!
  end
end
