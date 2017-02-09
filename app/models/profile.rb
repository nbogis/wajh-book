class Profile < ApplicationRecord

  belongs_to :user

  validates :about_me, length: {maximum: 500}

  has_attached_file :profile_pic, :styles => { :medium => "200x200", :thumb => "100x100" },
      default_url: "/img/elliot.jpg"
  validates_attachment_content_type :profile_pic, :content_type => /\Aimage\/.*\Z/
  validates_with AttachmentSizeValidator, :attributes => :profile_pic, :less_than => 1.megabytes

  has_attached_file :cover_pic, :styles => { :medium => "400x300"}

  validates_attachment_content_type :cover_pic, :content_type => /\Aimage\/.*\Z/,
      default_url: "/img/background.jpg"

  validates_with AttachmentSizeValidator, :attributes => :cover_pic, :less_than => 10.megabytes
end
