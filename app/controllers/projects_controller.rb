class ProjectsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  before_action :change_state, only: %i[submit approve reject cancel]

  def index
    @projects = Project.all
  end

  def show
    @comments = @project.comments.includes(:author)
  end

  def submit; end

  def approve; end

  def reject; end

  def cancel; end

  private

  def change_state
    if @project.send("#{action_name}!")
      flash[:notice] = "Project state is now: #{@project.state}"
    else
      flash[:alert] = "Failed to change project state using action '#{action_name}'."
    end
    redirect_to @project
  end
end
