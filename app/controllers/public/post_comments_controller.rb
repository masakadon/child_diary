class Public::PostCommentsController < ApplicationController
  def create
    @image = Image.find(params[:image_id])
    @comment = PostComment.new(post_comment_params)
    @comment.user_id = current_user.id
    @comment.image_id = @image.id

    if @comment.save
     redirect_to image_path(@image), notice: "コメントを投稿しました。"
    else
     flash.now[:alert] = "コメントを入力して下さい。"
     redirect_to image_path(@image)
    end
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
