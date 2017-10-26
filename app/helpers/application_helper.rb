module ApplicationHelper
  def all_for_nav
    Category.all
  end

  def platform_admin?
    current_user && current_user.platform_admin?
  end

  def business_admin?
    current_user && current_user.business_admin?
  end

  def business_manager?
    current_user && current_user.business_manager?
  end

  def registered?
    current_user && current_user.registered?
  end

end
