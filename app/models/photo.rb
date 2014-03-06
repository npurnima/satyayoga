class Photo < ActiveRecord::Base
  attr_accessible :album_id, :caption, :title,:owner

  belongs_to :album,
             :class_name => 'Album',
             :foreign_key => 'album_id'

  validates_format_of :title, :with    => %r{\.(gif|jpg|png|jpeg)$}i, :allow_blank => true,
                      :message => "Must be a URL for a GIF, JPG, or PNG image"

end
