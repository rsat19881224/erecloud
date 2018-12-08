module HtmlHelper

  def button_link_to(name = nil, options = nil, html_options = nil, &block)
    name = raw('<span>' + name + '</span>') unless block_given?
    html_options, options, name = options, name, block if block_given?

    link_to(name, options, html_options)
  end

end
