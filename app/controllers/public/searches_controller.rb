class Public::SearchesController < ApplicationController
  def search
    @model = params[:model]
		@content = params[:content]
		@method = params[:method]
		
		if @content.blank?
			@records = []
			flash.now[:alert] = "検索ワードを入力してください。"
			render :search and return
		end
		
		if @model == 'user'
			@records = User.search_for(@content, @method)
		else
			@records = Image.search_for(@content, @method)
		end
  end
end
