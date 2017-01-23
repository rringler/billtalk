class V1::UsersController < V1::BaseController
  skip_before_action :authenticate_user, only: [:create, :show]

  def create
    render(json: User.create!(user_params))
  end

  def show
    render(json: user)
  end

  def update
    render(json: user.update!(user_params))
  end

  def destroy
    render(json: user.destroy!)
  end

  private

  def user
    @user ||= User.find(params[:id])
  end

  def user_params
    @user_params ||= params.require(:user).permit(
      :email,
      :password,
      :password_confirmation
    )
  end
end
