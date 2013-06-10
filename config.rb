set :css_dir, 'styles'
set :js_dir, 'scripts'

Tilt.mappings.delete('md')

configure :build do
    activate :minify_css
end
