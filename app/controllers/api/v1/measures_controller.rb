class Api::V1::MeasuresController < Api::V1::BaseController
  skip_before_action :authenticate_user, only: :show

  def create
    render(json: Measure.create!(measure_params))
  end

  def show
    render(json: measure)
  end

  def update
    render(json: measure.tap { |m| m.update!(measure_params) })
  end

  def destroy
    render(json: measure.tap { |m| m.destroy! })
  end

  private

  def measure
    @measure ||= Measure.find(params[:id])
  end

  def measure_params
    params.require(:measure).permit(
      :election_id,
      :title,
      :description,
      :text,
      :result
    )
  end
end
