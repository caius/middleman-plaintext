# middleman-plaintext

Generate plaintext versions of resources. Inspired heavily by John Gruber at [daring fireball][], displaying the raw markdown used to generate a post by appending `.text` to the URL. (eg, <http://daringfireball.net/2010/07/improved_regex_for_matching_urls.text>)

[daring fireball]: https://daringfireball.net/

## Usage

Out of the box the extension expects `layout/layout.text.erb` to be the layout for plaintext rendering of resources, and it also will ignore all resources.

You'll want to tell it which resources to generate a plaintext version of using the `handle_file` option, which expects a ruby block.

This basic example, will render all resources with `layout/layout.text.erb`, by putting the following in `config.rb`:

    activate :plaintext do |c|
      c.handle_file = -> (resource) { true }
    end

A slightly more real-world example overrides the template name, and only "plaintexts" HTML files in the post/ directory:

    activate :plaintext do |c|
      c.layout = "blog_post.text"
      c.handle_file = lambda do |resource|
        resource.path.start_with?("posts/") && resource.path.end_with?(".html")
      end
    end

You can also change the output filename with the `filename` option. Defaults to `index.text`.

## Helpful things to know

* Current resource is `current_page` in the layout as usual
* Link to the current page

        URI.join(app.config.site_url, current_page.path.sub("index.text", ""))

* Render the source file completely raw, without the frontmatter

        Middleman::FileRenderer.new(@app, current_page.file_descriptor[:full_path].to_s).template_data_for_file

## Changelog

* Turn output filename into an option, `filename`

### v0.8.0

* Initial release. Generates index.text files based on handler with specified layout.
