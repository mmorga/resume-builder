# frozen_string_literal: true

require "date"

HEAD_META = [
  ->(meta) { tag(:meta, name: "author", content: meta.author) if meta&.author },
  ->(meta) { tag(:meta, name: "description", content: meta.description) if meta&.description },
  ->(_)    { tag(:meta, name: "generator", content: "Mark Morga's Resume Generator") },
  ->(meta) { tag(:meta, name: "keywords", content: meta.keywords) if meta&.keywords },
  ->(meta) { tag(:meta, name: "copyright", content: meta.copyright) if meta&.copyright },
  ->(_)    { tag(:meta, name: "referrer", content: "same-origin") },
  ->(_)    { tag(:meta, name: "robots", content: "index,follow") },

  ->(_)    { tag(:link, rel: "schema.dcterms", href: "http://purl.org/dc/terms/") },
  ->(meta) { tag(:meta, name: "dcterms.created", content: meta&.created ? meta.created : DateTime.now.iso8601) },
  ->(_)    { tag(:meta, name: "dcterms.modified", content: DateTime.now.iso8601) },

  ->(meta) { tag(:link, rel: "license", href: meta.license) if meta&.license },

  ->(meta) { tag(:link, rel: "canonical", href: meta.canonical_link) if meta.canonical_link },
  ->(meta) { tag(:link, rel: "alternate", type: "application/pdf", href: meta.pdf_link) if meta&.pdf_link },

  ->(meta) { tag(:meta, name: "twitter:card", content: meta.twitter.card) if meta&.twitter&.card },
  ->(meta) { tag(:meta, name: "twitter:site", content: meta.twitter.site) if meta&.twitter&.site },
  ->(meta) { tag(:meta, name: "twitter:creator", content: meta.twitter.creator) if meta&.twitter&.creator },
  ->(meta) { tag(:meta, name: "twitter:domain", content: meta.twitter.domain) if meta&.twitter&.domain },
  ->(meta) { tag(:meta, name: "twitter:description", content: meta.description) if meta&.description },
  ->(meta) { tag(:meta, name: "twitter:title", content: meta.twitter.title) if meta&.twitter&.title },
  ->(meta) { tag(:meta, name: "twitter:image", content: meta.twitter.image) if meta&.twitter&.image }
].freeze

def tag(name, **kwargs)
  "<#{name} #{kwargs.map { |k, v| "#{k}=#{v.inspect}" }.join(' ')}>"
end

def meta_tag_list(data)
  HEAD_META.map { |l| l.call(data.meta) }.compact.join("\n")
end
