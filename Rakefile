# vim: set filetype=ruby et sw=2 ts=2:

require 'gem_hadar'

GemHadar do
  name        'list'
  author      'Florian Frank'
  email       'flori@ping.de'
  homepage    "http://github.com/flori/#{name}"
  summary     'A list extension'
  description 'It foos… mostly'
  test_dir    'spec'
  module_type :class
  ignore      '.*.sw[pon]', 'pkg', 'Gemfile.lock', '.rvmrc', '.AppleDouble',
    'tags', '.bundle', '.DS_Store'
  readme      'README.md'
  require_paths %w[ ext lib ]

  development_dependency 'rspec'
end

task :default => %i[ compile spec ]
