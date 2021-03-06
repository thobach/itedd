class Event < ActiveRecord::Base

  include Authority::Abilities

  scope :upcoming_events, -> { oldest_first.where('happens_at >= :now', now: Time.now) }
  scope :finished_events, -> { newest_first.where('happens_at < :now',  now: Time.now) }

  scope :oldest_first, -> { order('happens_at asc') }
  scope :newest_first, -> { order('happens_at desc') }

  scope :for_organizer, -> (org) { where('user_id=?', org) if org.present? }

  belongs_to :organizer, foreign_key: :user_id

  validates_presence_of :link
  validates_presence_of :text
  validates_presence_of :happens_at
  validates_presence_of :organizer
  validates_length_of   :link, :maximum => 200
  validates_length_of   :text, :maximum => 200
end
