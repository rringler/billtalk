class Api::V1::CommentsController < Api::V1::BaseController
  skip_before_action :authenticate_user, only: :show

  def create
    render(json: current_user.comments.create!(comment_params))
  end

  def show
    render(json: Comment.find(params[:id]))
  end

  def update
    render(json: comment.tap { |c| c.update!(comment_params) })
  end

  def destroy
    render(json: comment.tap { |c| c.destroy! })
  end

  private

  def comment
    @comment ||= current_user.comments.find(params[:id])
  end

  def comment_params
    @comment_params ||= params.require(:comment).permit(
      :commentable_id,
      :commentable_type,
      :text,
      :measure_start,
      :measure_end
    )
  end
end
