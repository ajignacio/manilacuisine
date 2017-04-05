class RatesController < ApplicationController

  def build_rate
    @rate = Rate.build_rate(params, current_user)
    render text: ""
  end

  def cancel_rate
    @rate = Rate.user_cancel(params, current_user)
    render text: ""
  end

end
