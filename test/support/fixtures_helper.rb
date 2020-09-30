# frozen_string_literal: true

def fixture_file_path(filename)
  Rails.root.join("test/fixtures/#{filename}").to_s
end

def read_fixture_file(filename)
  File.read fixture_file_path(filename)
end

def yaml_fixture_file(filename)
  YAML.load_file(fixture_file_path(filename))
end
