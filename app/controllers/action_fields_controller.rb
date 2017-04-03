class ActionFieldsController < ApplicationController
  before_action :set_action_field, except: [:new, :create, :index]

  def index
    respond_to do |format|
      format.json { render json: ActionFieldsDatatable.new(view_context)}
    end
  end

  def show
    @actions = @actionfield.actions
    @achievements = @actionfield.achievements
  end

  def new
    @actionfield = ActionField.new
  end

  def create
    @actionfield = ActionField.new(action_field_params)
    if @actionfield.save
      redirect_to "#{admin_dashboard_path}#action-fields", success: t('action_fields.flashes.create.successfull')
    else
      render :new
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @actionfield.update(action_field_params)
        format.html { redirect_to @actionfield, notice: t('action_fields.flashes.update.successfull') }
        format.json { respond_with_bip(@actionfield) }
      else
        format.html { render :edit }
        format.json { respond_with_bip(@actionfield) }
      end
    end
  end

  private

  def action_field_params
    params.require(:action_field).permit(:name,
                                         :target,
                                         :solution,
                                         :skills,
                                         :organization,
                                         :domain_weight,
                                         :domain_id,
                                         :domain_name,
                                         :editor_id,
                                         :editor_name,
                                         :deputy_id,
                                         :deputy_name,
                                         :achievements_attributes => [:id,
                                                                      :name,
                                                                      :additional_info,
                                                                      :media,
                                                                      :ready,
                                                                      :rollout,
                                                                      :action_field_rank,
                                                                      :domain_id,
                                                                      :_destroy],
                                         :actions_attributes => [:id,
                                                                 :name,
                                                                 :additional_info,
                                                                 :due_date,
                                                                 :action_field_rank,
                                                                 :domain_id,
                                                                 :_destroy])
  end

  def set_action_field
    @actionfield = ActionField.find(params[:id])
  end
end
