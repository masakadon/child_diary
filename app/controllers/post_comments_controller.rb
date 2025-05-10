class PostCommentsController < ApplicationController
  def create
    image = Image.find(params[:image_id])
    comment = current_user.post_comments.build(post_comment_params)
    comment.image_id = image.id
    comment.save
    redirect_to image_path(image)
  end
  
  def destroy
    PostComment.find(params[:id]).destroy
    redirect_to image_path(params[:image_id])
  end

  private

  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end
end
