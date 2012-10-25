class User < ActiveRecord::Base
  
  attr_accessible :fbid, :name_first, :name_last, :email, :token
  attr_encrypted :email, :key => 'MySuperLiciousFreakingAwesomeEncryptionStringBroughtToYouBytheLetter3', :encode => true
  
end
