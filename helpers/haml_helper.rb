#encoding: utf-8

helpers do

  def partial(name)
    parts = name.to_s.split('/')
    parts.last.sub!(/\A/, '_')
    path = parts.join('/')

    haml path.to_sym, {layout: false}
  end

  def truncate(text, length = 40, trunc_string = '…')
    if text && text.length > length
      text[0..(length-1)] + trunc_string
    else
      text
    end
  end

end
