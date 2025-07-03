class Public::EventsController < ApplicationController
 before_action :authenticate_user!

  def index
    @events = Event.where(user_id: current_user.id)
  end

  def update
    @event = Event.find(params[:id])
  
    if @event.update(start: params[:event][:date])
      head :ok
    else
      head :unprocessable_entity
    end
  end

  def create
    @event = Event.new(event_params)
    @event.user_id = current_user.id

    if @event.save
      render json: @event, status: :created
    else
      render json: @event.errors, status: :unprocessable_entity
    end
  end

  private

  def event_params
    params.require(:event).permit(:title, :start)
  end
end
