module HomeHelper
  def select_star
    star = []
    (1..5).each do |a|
      star << [a,a]
    end
    star
  end
end
