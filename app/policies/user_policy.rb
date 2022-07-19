class UserPolicy < ApplicationPolicy

  def index?
    admin?
  end

  def update?
    admin? && role_user?
  end

  def destroy?
    admin? && role_user?
  end

  private

  def admin?
    user.admin?
  end

  def role_user?
    record.user?
  end
end