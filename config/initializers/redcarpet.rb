html_renderer = Redcarpet::Render::HTML.new(render_options = {})
MARKDOWN_RENDERER = Redcarpet::Markdown.new(html_renderer, extensions = {
    fenced_code_blocks: true,
    disable_indented_code_blocks: true
})