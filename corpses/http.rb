#!/bin/env ruby
# encoding: utf-8

module CorpseHttp

  def metas

    return "<meta charset='UTF-8'>#{@metas}"

  end

  def add_meta name, content

    @metas = !@metas ? "" : @metas
    @metas += "<meta name='#{name}' content='#{content}' />"

  end

  # Scripts

  def scripts

    return "#{@scripts}"

  end

  def add_script name

    @scripts = !@scripts ? "" : @scripts
    @scripts += "<script src='scripts/#{name}'></script>"

  end

  # Links

  def links

    return "#{@links}"

  end

  def add_link rel = 'stylesheet', type = 'text/css', name

    @links = !@links ? "" : @links
    @links += "<link rel='#{rel}' type='#{type}' href='links/#{name}' />"

  end

  # Title

  def title

    return "<title>#{@title}</title>"

  end

  def set_title name

    @title = name

  end

  # Title

  def body

    return "<body>#{@body}</body>"

  end

  def set_body body

    @body = body

  end

  # Output

  def result

    return "
<!DOCTYPE html>
<html> 
<head>
  #{metas}
  #{scripts}
  #{links}
  #{title}
</head>
#{body}
</html>"

  end

end