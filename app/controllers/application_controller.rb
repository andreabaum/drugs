class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  include ApplicationHelper

  # Basic HTTP authentication
  http_basic_authenticate_with name: ENV['name'], password: ENV['password']

  layout 'application'

  # Success notices
  # http://stackoverflow.com/questions/7098023
  def create_success_notice
    t(:'msg.actions.created', item: controller_name.classify.constantize.model_name.human)
  end

  def update_success_notice
    t(:'msg.actions.updated', item: controller_name.classify.constantize.model_name.human)
  end

  def destroy_success_notice
    t(:'msg.actions.deleted', item: controller_name.classify.constantize.model_name.human)
  end
end
