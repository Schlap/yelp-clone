class Restaurant < ActiveRecord::Base
  has_many :reviews, dependent: :destroy
  has_attached_file :image,
                    styles: { medium: "300x300>",
                              thumb: "100x100>" },
                    default_url: "/images/:style/missing-restaurant.png",
                    storage: :s3,
                    s3_credentials: Proc.new{|a| a.instance.s3_credentials }
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
  validates :name, length: { minimum: 3 }, uniqueness: true

  def average_rating
    return 'No ratings yet' if reviews.none?
    reviews.average(:rating)
  end

  def s3_credentials
    { bucket: 'ch2ch3-yelp', access_key_id: Rails.application.secrets[:access_key_id], secret_access_key: Rails.application.secrets[:secret_access_key] }
  end

end
