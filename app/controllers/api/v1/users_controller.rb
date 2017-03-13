class Api::V1::UsersController < Api::V1::BaseController
  skip_before_action :authenticate_user, only: [:create, :show]

  def create
    render(json: User.create!(user_params))
  end

  def show
    render(json: user)
  end

  def update
    render(json: user.tap { |u| u.update!(user_params) })
  end

  def destroy
    render(json: user.tap { |u| u.destroy! })
  end

  private

  def user
    @user ||= User.find(params[:id])
  end

  def user_params
    @user_params ||= params.require(:user).permit(
      :accepts_tos,
      :email,
      :password,
      :password_confirmation
    )
  end
end
