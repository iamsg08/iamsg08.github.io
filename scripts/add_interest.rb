#!/usr/bin/env ruby

require "date"
require "fileutils"
require "json"
require "net/http"
require "nokogiri"
require "optparse"
require "pathname"
require "uri"
require "yaml"

ROOT = Pathname.new(__dir__).join("..").expand_path
DATA_FILE = ROOT.join("_data/interests.yml")
IMAGE_DIR = ROOT.join("assets/images/interests")

options = { status: "recommended", type: nil, note: nil, dry_run: false }
parser = OptionParser.new do |opts|
  opts.banner = "Usage: bundle exec ruby scripts/add_interest.rb URL [options]"
  opts.on("--status STATUS", %w[now recommended], "now or recommended") { |value| options[:status] = value }
  opts.on("--type TYPE", %w[article video book film other], "content type; inferred for YouTube") { |value| options[:type] = value }
  opts.on("--note NOTE", "short personal note") { |value| options[:note] = value }
  opts.on("--dry-run", "print the generated entry without changing files") { options[:dry_run] = true }
end
parser.parse!

abort(parser.to_s) unless ARGV.length == 1
source_url = ARGV.first

def fetch(uri, redirects = 5)
  raise "Too many redirects" if redirects.zero?

  request = Net::HTTP::Get.new(uri)
  request["User-Agent"] = "Shubham-Gupta-Portfolio-Link-Preview/1.0"
  response = Net::HTTP.start(uri.host, uri.port, use_ssl: uri.scheme == "https", open_timeout: 10, read_timeout: 20) do |http|
    http.request(request)
  end

  if response.is_a?(Net::HTTPRedirection)
    return fetch(URI.join(uri.to_s, response["location"]), redirects - 1)
  end

  raise "Request failed: #{response.code} #{response.message}" unless response.is_a?(Net::HTTPSuccess)
  [response.body, response["content-type"].to_s, uri]
end

def youtube_id(url)
  uri = URI(url)
  return uri.path.split("/").reject(&:empty?).first if uri.host&.include?("youtu.be")
  return URI.decode_www_form(uri.query.to_s).to_h["v"] if uri.path == "/watch"
  return uri.path.split("/")[2] if uri.path.start_with?("/shorts/", "/embed/")
  nil
rescue URI::InvalidURIError
  nil
end

def slugify(value)
  slug = value.downcase.encode("ASCII", invalid: :replace, undef: :replace, replace: "")
              .gsub(/[^a-z0-9]+/, "-").gsub(/\A-|\-\z/, "")
  slug.empty? ? "interest-#{Date.today}" : slug
end

uri = URI(source_url)
abort("Only http and https links are supported") unless %w[http https].include?(uri.scheme)

video_id = youtube_id(source_url)
type = options[:type] || (video_id ? "video" : "article")
entry = {
  "id" => nil,
  "status" => options[:status],
  "type" => type,
  "title" => nil,
  "creator" => nil,
  "url" => source_url,
  "date_added" => Date.today.iso8601
}

if video_id
  oembed = URI("https://www.youtube.com/oembed?url=#{URI.encode_www_form_component(source_url)}&format=json")
  body, = fetch(oembed)
  metadata = JSON.parse(body)
  entry["title"] = metadata["title"]
  entry["creator"] = metadata["author_name"]
else
  body, content_type, final_uri = fetch(uri)
  abort("The URL did not return HTML") unless content_type.include?("html")
  document = Nokogiri::HTML(body)
  meta = lambda do |name|
    document.at_css("meta[property='#{name}']")&.[]("content") ||
      document.at_css("meta[name='#{name}']")&.[]("content")
  end

  entry["title"] = meta.call("og:title") || document.at_css("title")&.text&.strip || final_uri.host
  entry["creator"] = meta.call("og:site_name") || meta.call("author") || final_uri.host.sub(/^www\./, "")
  published = meta.call("article:published_time") || meta.call("datePublished")
  entry["year"] = published[/\A\d{4}/].to_i if published&.match?(/\A\d{4}/)

  image_url = meta.call("og:image") || meta.call("twitter:image")
  if image_url
    image_uri = URI.join(final_uri.to_s, image_url)
    image_body, image_type, = fetch(image_uri)
    extension = case image_type
                when /png/ then ".png"
                when /webp/ then ".webp"
                else ".jpg"
                end
    image_name = "#{slugify(entry["title"])}#{extension}"
    unless options[:dry_run]
      FileUtils.mkdir_p(IMAGE_DIR)
      IMAGE_DIR.join(image_name).binwrite(image_body)
    end
    entry["image"] = "/assets/images/interests/#{image_name}"
  end
end

entry["id"] = slugify(entry["title"])
entry["note"] = options[:note] if options[:note] && !options[:note].empty?
entry.compact!

existing = DATA_FILE.read
abort("An entry with id '#{entry["id"]}' already exists") if existing.match?(/^\s*-?\s*id:\s*["']?#{Regexp.escape(entry["id"])}["']?\s*$/)

serialized = entry.to_yaml.sub(/\A---\s*\n/, "")
if options[:dry_run]
  puts serialized
else
  base = existing.sub(/\[\]\s*\z/, "").rstrip
  DATA_FILE.write("#{base}\n\n- #{serialized.sub(/\A/, "").lines.join("  ").sub(/\A  /, "")}")
  puts "Added #{entry["title"]} to #{DATA_FILE.relative_path_from(ROOT)}"
end
