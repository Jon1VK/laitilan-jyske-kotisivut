# frozen_string_literal: true

class AthletePolicy < ApplicationPolicy
  def index?
    user.admin?
  end

  def show?
    user.admin?
  end

  def update?
    user.admin?
  end
end