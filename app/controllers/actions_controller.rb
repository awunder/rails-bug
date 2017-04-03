class ActionsController < ApplicationController
  before_action :set_actionable

  def index
    @actions = @actionable.actions
  end

  def new
    @action = @actionable.actions.new
  end

  def create
    @action = @actionable.actions.create(action_params)
    respond_to do |format|
      if @action.save
        @actions = @actionable.actions
        format.js { render layout: false, content_type: 'text/javascript' }
      else
        format.js { render layout: false, content_type: 'text/javascript' }
        format.json { render json: @action.errors, status: :unprocessable_entity }
      end
    end
  end


  private

  def set_actionable
    resource, id = request.path.split('/')[1,2]
    @actionable = resource.singularize.classify.constantize.find(id)
  end

  def action_params
    params.require(:act).permit(:name, :additional_info, :actionable_id, :actionable_type)
  end
end
