# frozen_string_literal: true

require "date"

module MetaTagList
  def self.tag(name, **kwargs)
    "<#{name} #{kwargs.map { |k, v| "#{k}=\"#{v}\"" }.join(' ')}>"
  end

  HEAD_META = [
    ->(data) { tag(:meta, name: "author", content: data.meta.author) if data.meta.author },
    ->(data) { tag(:meta, name: "description", content: data.person.description) if data.person.description },
    ->(_)    { tag(:meta, name: "generator", content: "Mark Morga's Resume Generator") },
    ->(data) { tag(:meta, name: "keywords", content: data.meta.keywords) if data.meta.keywords },
    ->(data) { tag(:meta, name: "copyright", content: data.meta.copyright) if data.meta.copyright },
    ->(_)    { tag(:meta, name: "referrer", content: "same-origin") },
    ->(_)    { tag(:meta, name: "robots", content: "index,follow") },

    ->(_)    { tag(:link, rel: "schema.dcterms", href: "http://purl.org/dc/terms/") },
    lambda { |data|
      tag(:meta, name: "dcterms.created", content: data.meta.created || DateTime.now.iso8601)
    },
    ->(_)    { tag(:meta, name: "dcterms.modified", content: DateTime.now.iso8601) },

    ->(data) { tag(:link, rel: "license", href: data.meta.license) if data.meta.license },

    ->(data) { tag(:link, rel: "canonical", href: data.meta.canonical_link) if data.meta.canonical_link },
    ->(data) { tag(:link, rel: "alternate", type: "application/pdf", href: data.meta.pdf_link) if data.meta.pdf_link },

    ->(data) { tag(:meta, name: "twitter:card", content: data.meta.twitter.card) if data.meta.twitter.card },
    ->(data) { tag(:meta, name: "twitter:site", content: data.meta.twitter.site) if data.meta.twitter.site },
    ->(data) { tag(:meta, name: "twitter:creator", content: data.meta.twitter.creator) if data.meta.twitter.creator },
    ->(data) { tag(:meta, name: "twitter:domain", content: data.meta.twitter.domain) if data.meta.twitter.domain },
    ->(data) { tag(:meta, name: "twitter:description", content: data.person.description) if data.person.description },
    ->(data) { tag(:meta, name: "twitter:title", content: data.meta.twitter.title) if data.meta.twitter.title },
    ->(data) { tag(:meta, name: "twitter:image", content: data.meta.twitter.image) if data.meta.twitter.image }
  ].freeze

  def meta_tag_list(data)
    HEAD_META.map { |l| l.call(data) }.compact.join("\n")
  end
end
