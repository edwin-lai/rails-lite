require 'json'

class Flash < Session
  def now
    @now = JSON.parse(req.cookies['_rails_lite_app'])
  end

  def store_session(res)
    super
    clean_up!
  end

  def clean_up!
    @now = nil
    @cookie = {} if @cookie[:expire] == true
    @cookie[:expire] = true unless @cookie.key?(:expire)
  end
end
