helpers do

  def partial(name)
    parts = name.to_s.split('/')
    parts.last.sub!(/\A/, '_')
    path = parts.join('/')

    haml path.to_sym, {layout: false}
  end

end
