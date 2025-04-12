# frozen_string_literal: true

# policy rules for client
class ClientPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    record.user_id == user.id
  end

  def create?
    true
  end

  def update?
    record.user_id == user.id
  end

  def destroy?
    record.user_id == user.id
  end

  # only user clients scope
  class Scope < ApplicationPolicy::Scope
    def resolve
      scope.where(user_id: user.id)
    end
  end
end
