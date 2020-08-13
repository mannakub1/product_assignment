class UserService::GetInfo < ApplicationService

  def call(dc)
    dc = args[:dc]
    scope_dc(dc) if dc.present?

    { id: 1, name: 'GEN' }
  end

  private

  def scope_dc(dc)
    { }
  end
end

