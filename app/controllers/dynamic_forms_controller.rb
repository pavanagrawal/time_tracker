class DynamicFormsController < ApplicationController
  before_filter :authenticate_user!
  def index
    @dynamic_form = current_user.dynamic_form_instance
  end
  
  def builder
    @dynamic_form = current_user.dynamic_form_instance
  end
  
  def preserve_form_data
    @dynamic_form = current_user.dynamic_form_instance
    @dynamic_form.update(form_data: params[:form_data])
  end
end
