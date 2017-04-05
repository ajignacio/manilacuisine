class Restaurant < ActiveRecord::Base

  belongs_to :cuisine
  has_many :rates

  validates :name,:address, :telephone_number, presence: true
  validates_format_of :telephone_number, :multiline => true, with: /^(?:(?:\(?(?:00|\+)([1-4]\d\d|[1-9]\d?)\)?)?[\-\.\ \\\/]?)?((?:\(?\d{1,}\)?[\-\.\ \\\/]?){0,})(?:[\-\.\ \\\/]?(?:#|ext\.?|extension|x)[\-\.\ \\\/]?(\d+))?$/i
  def self.build_restaurant(data)
    #raise data.inspect
    self.create(restaurant_fields(data))
  end

  def self.update_restaurant(id,data)
    rest = self.find id
    rest.update_attributes(restaurant_fields(data))
  end

  def self.restaurant_fields(data)
    {
      cuisine_id:       data[:cuisine].to_i,
      name:             data[:name],
      address:          data[:address],
      telephone_number: data[:telephone_number]
    }
  end

  def self.get_all_restaurant(search_data,user)
    data = {}
    data[:restaurant] = []
    data[:total_rate] = []
    data[:user_rate] = []
    _all = search_data[:cuisine].present? ? self.where(cuisine_id: search_data[:cuisine]) : self.all
    cnt = 0
    _all.each do |a|

      user_rate = user.present? ? Rate.rate_by_user(a.id,user) : 0
      #raise user_rate.nil? ? "WALA" : user_rate.rating.inspect
      #raise (a.rates.sum(:rating) / (a.rates.size * 5)).inspect
      if search_data[:star].present?
        if ((search_data[:star].to_i * 5) == restaurant_rate(a).to_i)
          #return data[:restaurant] = []
          data[:restaurant] <<
          {
            restaurant: a,
            cuisine: a.cuisine.name,
            name: a.name,
            rate: restaurant_rate(a)
          }
        end
      else
        data[:restaurant] <<
        {
          restaurant: a,
          cuisine: a.cuisine.name,
          name: a.name,
          rate: restaurant_rate(a)
        }

      end
      data[:total_rate] << restaurant_score(a)
      data[:user_rate] << user_rate
    end
    data
  end

  def self.restaurant_rate(data)
    !data.rates.blank? ? data.rates.average(:rating).round(2).to_f : 0
  end

  def self.restaurant_score(data)
    #return data.rates.sum(:rating) / (data.rates.size * 5) if data.rates.size != 0 else 0 end
    data.rates.size != 0 ? (data.rates.sum(:rating) / (data.rates.size * 5)) : 0
  end

  def self.random_restaurant
    self.order("RANDOM()").limit(3)
  end

end
