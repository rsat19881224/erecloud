class MenuAuthoritiesController < BaseController
  permit_attributes :user_id, :menu_id, :authority_type, :selected_user_id

  helper_method :menu_option_collections

  def menu_option_collections
    menus = Menu.our_menus(@my_company)

    if params[:selected_user_id]
      selected_user_id = params[:selected_user_id]
    elsif @instance.user_id
      selected_user_id = @instance.user_id
    else
      selected_user_id = User.of_ours(@my_company).first.id
    end

    settinged_menus = MenuAuthority.of_ours(@my_company).where(user_id: selected_user_id).map {|ma| Menu.find_by_id(ma.menu_id) }
    menus -= settinged_menus

    render :partial => 'menu_option_collections', :locals => {:menus => menus}
  end
end
