class DomainsController < ApplicationController
  before_action :set_domain, except: [:new, :create, :index, :domain_index]


  def show
    @action_fields = @domain.action_fields
    @actions = Action.where(actionable: [@domain, *@action_fields])
                   .where(visible: true)
                   .order(domain_rank: :asc, action_field_rank: :asc)

    @achievements = Achievement.where(achievementable: [@domain, *@action_fields])
                        .where(visible: true)
                        .order(domain_rank: :asc, action_field_rank: :asc)
  end

  def new
    @domain = Domain.new
    @achievements = @domain.achievements
    @actions = @domain.actions
  end

  def create

    @domain = Domain.new(domain_params)
    if @domain.save
      redirect_to "#{admin_dashboard_path}#domains", success: t('domains.flashes.create.successfull')
    else
      render :new
    end
  end

  def edit
    @action_fields = @domain.action_fields
    @actions = Action.where(actionable: [@domain, *@action_fields])
                   .order(domain_rank: :asc, action_field_rank: :asc)
    @achievements = Achievement.where(achievementable: [@domain, *@action_fields])
                        .order(domain_rank: :asc, action_field_rank: :asc)
  end

  def update
    respond_to do |format|
      if @domain.update(domain_params)
        format.html { redirect_to @domain, notice: t('domains.flashes.update.successfull') }
        format.json { respond_with_bip(@domain) }
      else
        format.html { render :edit }
        format.json { respond_with_bip(@domain) }
      end
    end
  end

  def destroy
    @domain.destroy
    redirect_to "#{admin_dashboard_path}#domains", notice: t('domains.flashes.destroy.successfull')
  end

  private

  def domain_params
    params.require(:domain).permit(:name,
                                   :editor_id,
                                   :editor_name,
                                   :deputy_id,
                                   :deputy_name,
                                   :adjust_solution,
                                   :adjust_skills,
                                   :adjust_organization,
                                   :solution_category_id,
                                   :achievements_attributes => [:id,
                                                                :name,
                                                                :domain_rank,
                                                                :visible,
                                                                :additional_info,
                                                                :media,
                                                                :ready,
                                                                :rollout,
                                                                :domain_id,
                                                                :_destroy],
                                   :actions_attributes => [:id,
                                                           :name,
                                                           :additional_info,
                                                           :domain_id,
                                                           :domain_rank,
                                                           :visible,
                                                           :due_date,
                                                           :_destroy],
                                   :action_fields_attributes => [:id, :name, :domain_weight, :domain_id, :_destroy,
                                                                 :achievements_attributes => [:id,
                                                                                              :name,
                                                                                              :domain_rank,
                                                                                              :visible,
                                                                                              :additional_info,
                                                                                              :media,
                                                                                              :ready,
                                                                                              :rollout,
                                                                                              :domain_id,
                                                                                              :_destroy],
                                                                 :actions_attributes => [:id,
                                                                                         :name,
                                                                                         :additional_info,
                                                                                         :domain_id,
                                                                                         :domain_rank,
                                                                                         :visible,
                                                                                         :due_date,
                                                                                         :_destroy],
                                   ])
  end

  def set_domain
    @domain = Domain.find(params[:id])
  end
end
