class Api::V1::ElectionsController < Api::V1::BaseController
  skip_before_action :authenticate_user, only: :show

  def create
    render(json: Election.create!(election_params))
  end

  def show
    render(json: election, include: :measures)
  end

  def update
    render(json: election.tap { |e| e.update!(election_params) })
  end

  def destroy
    render(json: election.tap { |e| e.destroy! })
  end

  private

  def election
    @election ||= Election.find(params[:id])
  end

  def election_params
    params.require(:election).permit(
      :state_id,
      :date
    )
  end
end
