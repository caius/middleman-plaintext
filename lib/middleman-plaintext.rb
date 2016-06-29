require "middleman-core"
require "middleman-plaintext/extension"

Middleman::Extensions.register(:plaintext) { Middleman::PlaintextExtension }
