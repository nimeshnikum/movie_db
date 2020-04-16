module YamlSeedLoading
  def yaml_seed(name)
    YAML.load_file(seed_path(name))
  end

  def seed_path(name)
    Rails.root.join('db', 'samples', "#{name}.yml").to_s
  end
end
