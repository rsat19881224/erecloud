class ApproversController < BaseController
  permit_attributes :user_id, :menu_id, :approver_type, :mail_delivered, :selected_user_id
  helper_method :menu_collection

  def create
    if approver_exsit?
     super
    else
      respond_to do |format|
        @instance.errors[:approver_exist] = t('approvers.approver_exist')
        format.html { render action: 'new' }
        format.json { render action: 'error', status: :unprocessable_entity }
      end
    end
  end

  def approver_exsit?
    model.of_ours(@my_company).where(user_id: @instance.user_id).where(menu_id: @instance.menu_id).blank?
  end

  def menu_collection
    menus = Menu.our_menus(@my_company)

    if params[:selected_user_id]
      selected_user_id = params[:selected_user_id]
    elsif @instance
      selected_user_id = @instance.user_id
    else
      selected_user_id = User.of_ours(@my_company).first.id
    end

    settinged_menus = Approver.of_ours(@my_company).where(user_id: selected_user_id).map {|a| Menu.find_by_id(a.menu_id)}
    menus -= settinged_menus

    render :partial => 'menu_collection', locals: {menus: menus, object: @instance} 
  end
end
