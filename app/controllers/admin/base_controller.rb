class Admin::BaseController < Admin::ApplicationController

  def create
    respond_to do |format|
      unless @instance.save
        format.html { render action: 'new' }
        format.json { render action: 'error', status: :unprocessable_entity }
      else
        format.html { redirect_to redirect_path, notice: I18n.t(:successfully_created, model: model.model_name.human, scope: [:views, :messages]) }
        format.json do
          render \
            status: :created,
            location: send(:"#{route_name}_url", *(resource_ancestors || []).reverse.map { |ancestor_name| instance_variable_get("@#{ancestor_name}") }, @instance.id)
        end
      end
    end
  end

  def update
    respond_to do |format|
      if @instance.save
        format.html { redirect_to redirect_path, notice: I18n.t(:successfully_updated, model: model.model_name.human, scope: [:views, :messages]) }
        format.json { render action: 'show' }
      else
        format.html { render action: 'edit' }
        format.json { render action: 'error', status: :unprocessable_entity }
      end
    end
  end

  def redirect_path
    polymorphic_path([:admin, model]) 
  end

end
