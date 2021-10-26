class Post < ActiveRecord::Base
  belongs_to :user

  validates :name,  presence: true
  validates :url,   presence: true
  validates :user_id,   presence: true

  scope :by_most_popular, -> { order(votes: :desc) }

  def self.random_photo
    PHOTOS.sample
  end

  PHOTOS = %w(
  https://frinkiac.com/img/S05E07/1046544.jpg
  https://frinkiac.com/img/S10E13/430012.jpg
  https://frinkiac.com/img/S11E10/867360.jpg
  https://frinkiac.com/img/S10E16/553969.jpg
  https://frinkiac.com/img/S02E06/175181.jpg
  https://frinkiac.com/img/S02E17/439205.jpg
  https://frinkiac.com/img/S14E07/618076.jpg
  https://frinkiac.com/img/S08E07/585550.jpg
  https://frinkiac.com/img/S16E21/43085.jpg
  https://frinkiac.com/img/S05E20/682881.jpg
  https://frinkiac.com/img/S07E22/575357.jpg
  https://frinkiac.com/img/S04E20/581413.jpg
  https://frinkiac.com/img/S16E21/43085.jpg
  https://frinkiac.com/img/S16E17/574033.jpg
  https://frinkiac.com/img/S09E07/843308.jpg
  )

end
