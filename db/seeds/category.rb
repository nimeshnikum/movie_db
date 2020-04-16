class Seeds::Category
  extend ::YamlSeedLoading

  def self.seed_all
    return if ::Category.count > 0
    category_attributes.each do |attributes|
      ::Category.find_or_create_by!(attributes)
    end
  end

  protected

  def self.category_attributes
    @category_attributes ||= yaml_seed('categories')
  end
end
