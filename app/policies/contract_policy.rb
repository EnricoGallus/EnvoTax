# frozen_string_literal: true

# policy for contract
class ContractPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    record.user_id == user.id
  end

  def create?
    true
  end

  def edit?
    record.user_id == user.id
  end

  def update?
    record.user_id == user.id
  end

  def destroy?
    record.user_id == user.id
  end

  # only user scope
  class Scope < ApplicationPolicy::Scope
    def resolve
      scope.where(user_id: user.id)
    end
  end
end
