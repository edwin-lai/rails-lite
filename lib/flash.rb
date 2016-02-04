require 'json'

class Flash
  attr_accessor :now
  attr_reader :current_cookie, :old_cookie

  def initialize(req)
    biscuit = req.cookies['_rails_lite_app_flash']
    if biscuit.nil?
      @cookie0 = {}
    else
      @cookie0 = JSON.parse(biscuit)
    end
    @cookie1 = {}
    @current_cookie = @cookie0
    @old_cookie = @cookie1
  end

  def now
    old_cookie
  end

  def [](key)
    current_cookie.key?(key) ? current_cookie[key] : old_cookie[key]
  end

  def []=(key, val)
    current_cookie[key] = val
  end

  def store_flash(res)
    res.set_cookie(
      '_rails_lite_app_flash',
      path: '/',
      value: @current_cookie.to_json)
    @old_cookie = {}
    @current_cookie, @old_cookie = @old_cookie, @current_cookie
  end
end
