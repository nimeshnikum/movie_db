class MoviePolicy < ApplicationPolicy
  def create?
    user.present?
  end

  def update?
    user.present? && user == record.user
  end

  def destroy?
    update?
  end
end
