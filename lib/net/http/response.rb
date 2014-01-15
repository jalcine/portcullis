module DecodeHttpResponseOverride
  def initialize(h,c,m)
    super(h,c,m)
    @decode_content = true
  end

  def body
    res = super
    self['content-length']= res.bytesize if self['content-length']
    res
  end
end

module Net
  class HTTPResponse
    prepend DecodeHttpResponseOverride
  end
end
