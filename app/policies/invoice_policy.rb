# frozen_string_literal: true

# policy rules for invoice
class InvoicePolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    record.user_id == user.id
  end

  def create?
    true
  end

  def preview?
    show?
  end

  def destroy?
    record.user_id == user.id && record.draft?
  end

  def approve?
    record.user_id == user.id && record.draft?
  end

  # only user scope
  class Scope < ApplicationPolicy::Scope
    def resolve
      scope.where(user_id: user.id)
    end
  end
end
