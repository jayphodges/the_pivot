class PermissionsService
  def initialize(user, controller, action)
    @user = user || User.new
    @controller = controller
    @action = action
  end

  def authorized?
    return true if controller == 'welcome' && action.in?(%w(index))
    return true if controller == 'stores' && action == 'index'
    return true if controller == 'sessions' && action.in?(%w(new create destroy))
    return true if controller == 'items' && action.in?(%w(index show))
    return true if controller == 'categories' && action.in?(%w(show))
    return true if controller == 'carts' && action.in?(%w(new edit show update destroy create))

    if user.platform_admin?
      platform_admin_permissions
    elsif user.business_admin?
      business_admin_permissions
    elsif user.business_manager?
      business_manager_permissions
    elsif user.registered?
      registered_permissions
    else
      guest_permissions
    end
  end

  private
    attr_reader :user, :controller, :action

    def platform_admin_permissions
      return true if controller == 'users' && action.in?(%w(index show edit))
      return true if controller == 'orders' && action.in?(%w(index))
      return true if controller == 'stores/orders' && action.in?(%w(index))
      return true if controller == 'stores/items' && action.in?(%w(index))
      return true if controller == 'stores/admins' && action.in?(%w(index))
      return true if controller == 'admin/stores' && action.in?(%w(index update))
      return true if controller == 'admin/items' && action.in?(%w(index create new edit update))
      return true if controller == 'admin/admin' && action.in?(%w(show))
    end

    def  business_admin_permissions
      return true if controller == 'admin/admin' && action.in?(%w(show))
      return true if controller == 'admin/stores' && action.in?(%w(index update))
      return true if controller == 'admin/items' && action.in?(%w(index create new edit update))
      return true if controller == 'stores/orders' && action.in?(%w(index))
      return true if controller == 'stores/admins' && action.in?(%w(index)) # or maybe just the action here?
    end

    def business_manager_permissions
      return true if controller == 'admin/admin' && action.in?(%w(show))
      return true if controller == 'admin/stores' && action.in?(%w(index))
      return true if controller == 'admin/items' && action.in?(%w(index create new edit update))
      return true if controller == 'stores/orders' && action.in?(%w(index))
      return true if controller == 'orders' && action.in?(%w(index show))

    end

    def registered_permissions
      return true if controller == 'users' && action.in?(%w(show index create new edit update))
    end

    def guest_permissions
      return true if controller == 'sessions'
      return true if controller == 'stores' && action.in?(%w(index show))
      return true if controller == 'items' && action.in?(%w(index show))
    end
end
