module Projects
  class CommentsController < ApplicationController
    before_action :set_project

    def create
      @comment = @project.comments.build(comment_params)
      @comment.author = current_user
      if @comment.save
        redirect_to @project, notice: 'Comment created successfully.'
      else
        redirect_to @project, notice: 'Comment was not saved.'

      end
    end

    private

    def set_project
      @project = Project.find(params[:project_id])
    end

    def comment_params
      params.require(:comment).permit(:content)
    end
  end
end
