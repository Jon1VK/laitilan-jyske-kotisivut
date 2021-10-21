# frozen_string_literal: true

class RecordPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    true
  end

  def create?
    true
  end

  def update?
    user.admin || !record.reviewed
  end

  def destroy?
    user.admin || !record.reviewed
  end
end