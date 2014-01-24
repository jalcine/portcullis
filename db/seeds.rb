# Define the parent categories.
Category.destroy_all

categories = YAML.load_file File.expand_path('../categories.yml', __FILE__)
categories.each do | parent, children |
  parent_category = Category.create! name: parent
  children.each do | child |
    child_category = Category.create! name: child, category: parent_category
  end
end
