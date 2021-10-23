# frozen_string_literal: true

class NewsPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    user.admin? || record.user == user
  end

  def create?
    true
  end

  def update?
    user.admin? || record.user == user
  end

  def destroy?
    user.admin? || record.user == user
  end

  class Scope < Scope
    def resolve
      user.admin? ? scope.all : user.news
    end
  end
end