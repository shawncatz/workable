class Workable::WorkersController < Workable::ApplicationController
  def create
    logger.info "workers#create: #{params[:name]}"
    name = params[:name]
    name.constantize.perform_async
    render json: {success: true}
  end
end
