class Rate < ActiveRecord::Base
  belongs_to :restaurant

  def self.rate_by_user(rid,user)
    rate = self.where('restaurant_id = ? AND user_id = ?', rid, user.id).first
    rate.present? ? rate.rating : 0
  end

  def self.build_rate(data, user)
    self.create(rate_fields(data,user))
  end

  def self.user_cancel(data,user)
    rate = self.where('restaurant_id = ? AND user_id = ?', data[:restaurant_id], user.id).first
    if rate.present?
      rate.destroy
    end
  end

  def self.rate_fields(data,user)
    {
      restaurant_id: data[:restaurant_id],
      rating: data[:score],
      user_id: user.id
    }
  end
end
