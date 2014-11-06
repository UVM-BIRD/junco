class Verb < ActiveRecord::Base
  def url
    "http://rdaregistry.info/Elements/w/#{rdaw_id}"
  end
end
