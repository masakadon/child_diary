class Public::EventsController < ApplicationController
 before_action :authenticate_user!

  def index
    @events = Event.where(user_id: current_user.id)
  end

  def show
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])
  if @event.update(event_params)
    redirect_to user_path(current_user), notice: "予定を更新しました"
  else
    render :show
  end
  end

  def create
    @event = Event.new(event_params)
    @event.user_id = current_user.id

    if @event.start.present? && @event.start.is_a?(Date)
      @event.start = @event.start.beginning_of_day
    end

    if @event.save
      redirect_to user_path(current_user), notice: "予定を作成しました"
    else
      render :new
    end
  end

  def destroy
    @event = Event.find(params[:id])
    @event.destroy
    redirect_to user_path(current_user), notice: "予定を削除しました"
  end

  private

  def event_params
    params.require(:event).permit(:title, :start, :end)
  end
end
