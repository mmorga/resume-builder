# frozen_string_literal: true

require "delegate"
require "erb"
require "json"
require "meta_tag_list"

autoload(:Style, "style.rb")
autoload(:UnorderedList, "unordered_list.rb")

class Partial < SimpleDelegator
  include MetaTagList

  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  attr_reader :data

  def initialize(template_file, data)
    @erb_template = File.read(template_file)
    @data = data
    super(data)
  end

  def link_emails(str)
    if str =~ EMAIL_REGEX
      "<a href=\"mailto:#{str}\">#{str}</a>"
    else
      str
    end
  end

  def style
    Style.new(@data).result
  end

  def unordered_list(ary)
    UnorderedList.new(@data, ary).result
  end

  def json_ld
    JSON.pretty_generate(@data.person.json_ld)
  end

  def result
    template = ERB.new(@erb_template, trim_mode: '%<>')
    template.result(binding)
  end

  def metadata
    meta_tag_list(@data)
  end
end
