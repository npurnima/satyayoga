class Album < ActiveRecord::Base
  attr_accessible :caption, :coverpage, :title ,:owner

  has_many  :photos,
            :class_name => 'Photo',
            :foreign_key => 'album_id'
  belongs_to :user,
             :class_name => 'User',
             :foreign_key => 'owner'

  validates_format_of :coverpage, :with    => %r{\.(gif|jpg|png|jpeg)$}i, :allow_blank => true,
                      :message => "Must be a URL for a GIF, JPG, or PNG image"

  def self.find_all_user_albums(userid)
    @albums = Album.where("owner=?",userid).order("updated_at")
  end
end