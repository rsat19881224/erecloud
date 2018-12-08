# -*- coding: utf-8 -*-
# TODO: reconsider search interface
class BaseController < ApplicationController
  include ResourceDetector

  skip_before_action :load_objects
  before_action :initialize_search, :load_objects, :save_search,  only: [:index]
  before_action :pickup_param
  before_action :delivery_action_gon
  before_action :set_company, :set_created_user, only: [:create]
  before_action :set_updated_user, only: [:create, :update]
  prepend_before_action :load_company

  def index
    respond_to do |format|
      format.html
      format.json
    end
  end

  def show
    respond_to do |format|
      format.html
      format.json
    end
  end

  def new
    respond_to do |format|
      format.html
    end
  end

  def edit
    respond_to do |format|
      format.html
    end
  end

  def create
    respond_to do |format|
      unless @instance.save
        format.html { render action: 'new' }
        format.json { render action: 'error', status: :unprocessable_entity }
      else
p params
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
        format.html { redirect_to redirect_path, notice:  I18n.t(:successfully_updated, model: model.model_name.human, scope: [:views, :messages]) }
        format.json { render action: 'show' }
      else
        format.html { render action: 'edit' }
        format.json { render action: 'error', status: :unprocessable_entity }
      end
    end
  end

  def destroy
    respond_to do |format|
      if @instance.destroy
        format.html { redirect_to redirect_path }
        format.json
      else
        format.html { render action: (request.referer && Rails.application.routes.recognize_path(request.referer)[:action] || :show) }
        format.json { render action: 'error', status: :unprocessable_entity }
      end
    end
  end

  def redirect_path
    polymorphic_path([model])
  end

  def initialize_search
    if params[:clear]
      params.delete(:q)
      session[controller_path][:search].delete(action_name) rescue nil
    elsif !params[:q] && (session[controller_path][:search][action_name] rescue nil)
      params[:q] = session[controller_path][:search][action_name]
    end
    params[:q] || ((defaults = (Settings.search.defaults.send(controller_name.underscore).send(action_name) rescue nil)) && params[:q] = defaults)
  end

  def ordering(search)
    model
  end

  def load_objects
    instance_variable_set \
      "@#{model_name.underscore.pluralize}",
      (@instances = (@search = ordering(params[:q]).search(params[:q])).result.page(params[:page]).per(params[:per_page]))
  end

  def save_search
    [controller_path, :search].inject(session) { |s, k| s[k] || (s[k] = {}) }[action_name] = params[:search] if params[:search]
  end

  def load_company
    @my_company = current_user.company if current_user
  end

  def set_company
    @instance.company_id = @my_company.id if @instance.respond_to?(:company_id)
  end

  def set_created_user
    @instance.created_user_id = current_user.id if @instance.respond_to?(:created_user_id)
  end

  def set_updated_user
    @instance.updated_user_id = current_user_id if @instance.respond_to?(:updated_user_id)
  end

  def pickup_param
    @pickup_param = {}
    @pickup_param = @pickup_param.merge(:search => params[:search]) if params.has_key? :search
    @pickup_param = @pickup_param.merge(:page => params[:page]) if params.has_key? :page

    @deleted_at_param = Marshal.load(Marshal.dump(@pickup_param))
    @deleted_at_param[:search] = {:deleted_at_is_null => 'true'} unless @deleted_at_param.has_key? :search
    @deleted_at_param[:search][:deleted_at_is_null] = (@deleted_at_param[:search][:deleted_at_is_null] == 'true') ? '' : 'true'

    @deleted_at_param.delete(:page) if @deleted_at_param.has_key? :page
  end

  def delivery_action_gon
    gon.controller_name = controller_name
    gon.action_name = action_name
  end
end
