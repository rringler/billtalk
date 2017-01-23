class V1::ElectionsController < ApplicationController
  def create
    render(json: Election.create!(election_params))
  end

  def show
    render(json: election)
  end

  def update
    render(json: election.update!(election_params))
  end

  def destroy
    render(json: election.destroy!)
  end

  private

  def election
    @election ||= Election.find(params[:id])
  end

  def election_params
    @election_params ||= params.require(:election).permit(
      :state_id,
      :date
    )
  end
end
