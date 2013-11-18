Portcullis::Application.configure do
  config.eager_load_paths += %W(
    "#{config.root}/lib/ext"
  )
end
