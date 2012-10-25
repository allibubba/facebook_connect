require 'active_model'
class Locale
  
  extend  ActiveModel::Naming
  extend  ActiveModel::Translation
  
  def i18n_scope
    :activerecord
  end

  def self.all
    {
      :en_US => {:label => self.human_attribute_name("en_US"), :code => 'en_US', :altcode => 'en-US', :short => 'en'},
      :en_GB => {:label => self.human_attribute_name("en_GB"), :code => 'en_GB', :altcode => 'en-GB', :short => 'en'},
      :fr_FR => {:label => self.human_attribute_name("fr_FR"), :code => 'fr_FR', :altcode => 'fr-FR', :short => 'fr'}
      #:en_IN => {:label => self.human_attribute_name("en_IN"), :code => 'en_IN', :altcode => 'en-IN', :short => 'en'}
    }
  end    
    
end