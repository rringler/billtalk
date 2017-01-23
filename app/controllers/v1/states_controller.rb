class V1::StatesController < V1::BaseController
  skip_before_action :authenticate_user, only: :show

  def create
    render(json: State.create!(state_params))
  end

  def show
    render(json: state)
  end

  def update
    render(json: state.update!(state_params))
  end

  def destroy
    render(json: state.destroy!)
  end

  private

  def state
    @state ||= State.find(params[:id])
  end

  def state_params
    @state_params ||= params.require(:state).permit(
      :code
    )
  end
end
