class Api::V1::StatesController < Api::V1::BaseController
  skip_before_action :authenticate_user, only: [:index, :show]

  def index
    render(json: states)
  end

  def create
    render(json: State.create!(state_params))
  end

  def show
    render(json: state)
  end

  def update
    render(json: state.tap { |s| s.update!(state_params) })
  end

  def destroy
    render(json: state.tap { |s| s.destroy! })
  end

  private

  def state
    @state ||= State.find(params[:id])
  end

  def states
    @states ||= State.all
  end

  def state_params
    @state_params ||= params.require(:state).permit(
      :code
    )
  end
end
