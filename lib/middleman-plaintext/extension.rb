require "middleman-plaintext/version"
require "middleman-core"

module Middleman
  class PlaintextExtension < Extension

    option :layout, "layout.text", "Layout to use for text file"
    option :handle_file, -> (resource) { false }, "block to decide whether to plaintext a resource"

    # This should run after most other sitemap manipulators so that it
    # gets a chance to modify any new resources that get added.
    self.resource_list_manipulator_priority = Float::INFINITY

    # A Sitemap Manipulator
    def manipulate_resource_list(resources)
      resources | resources.select(&method(:handled_by_us?)).map(&method(:textify))
    end

    private

    def handled_by_us?(resource)
      options[:handle_file].call(resource)
    end

    def textify(resource)
      to = resource.destination_path.sub("/index.html", "/index.text")
      source = resource.file_descriptor[:full_path].to_s

      ::Middleman::Sitemap::Resource.new(app.sitemap, to, source).tap do |r|
        r.options.merge!(resource.options.merge(
          :directory_index => false,
          :layout => options[:layout]
        ))
        r.add_metadata resource.metadata
        r.extend Middleman::Blog::BlogArticle
        r.blog_controller = app.extensions[:blog]["instance_0"]
      end
    end
  end
end
