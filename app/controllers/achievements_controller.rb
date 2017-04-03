class AchievementsController < ApplicationController
  before_action :set_actionable

  def index
    @achievements = @actionable.achievements
  end

  def new
    @achievement = @actionable.achievements.new
  end

  def create
    @achievement = @actionable.achievements.create(achievement_params)
    respond_to do |format|
      if @achievement.save
        @achievements = @actionable.achievements
        format.js {render layout: false, content_type: 'text/javascript'}
      else
        format.js {render layout: false, content_type: 'text/javascript'}
        format.json {render json: @achievement.errors, status: :unprocessable_entity}
      end
    end
  end


  private

  def set_actionable
    resource, id = request.path.split('/')[1,2]
    @actionable = resource.singularize.classify.constantize.find(id)
  end

  def achievement_params
    params.require(:act).permit(:name,
                                :additional_info,
                                :due_date,
                                :actionable_id,
                                :actionable_type)
  end
end
