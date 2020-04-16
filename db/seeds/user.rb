module Seeds
  class User
    extend ::YamlSeedLoading

    def self.seed_all
      user_attributes.each do |_, attributes|
        if ::User.find_by(email: attributes[:email]).nil?
          user = ::User.new(attributes)
          user.password = 'test1234'
          user.save(validate: false)
        end
      end
    end

    protected

    def self.user_attributes
      @user_attributes ||= ActiveSupport::HashWithIndifferentAccess.new(yaml_seed('users'))
    end
  end
end
