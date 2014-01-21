module DecodeHttpResponseOverride
  def initialize(h,c,m)
    super(h,c,m)
    @decode_content = false
  end

  def body
    res = super
    if self['content-length']
      self['content-length'] = res.bytesize
    end
    res
  end
end

module Net
  class HTTPResponse
    prepend DecodeHttpResponseOverride
  end
end
