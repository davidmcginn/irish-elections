class Candidate < ActiveRecord::Base
  extend FriendlyId
  acts_as_api
  belongs_to :constituency
  belongs_to :party

  friendly_id :slug_candidates, use: :slugged

  before_save :normalize_twitter_handle, if: :twitter_handle

  api_accessible :default do |template|
    template.add :first_name
    template.add :last_name
    template.add :email
    template.add :aka
    template.add :date_of_birth
    template.add :gender
    template.add :current_td
    template.add :photo_url
    template.add :party_profile_url
    template.add :website_url
    template.add :twitter_url
    template.add :facebook_url
    template.add :instagram_url
    template.add :linkedin_url
    template.add :youtube_url
    template.add :snapchat_url
    template.add :phone_1
    template.add :phone_2
    template.add :source_url
    template.add :voting_record_url
    template.add :claimed_expenses
    template.add :party
    template.add :constituency
    template.add :path
  end

  def self.search(term)
    search = "%#{term}%"
    with_associations.joins("LEFT OUTER JOIN constituencies ON constituencies.id = candidates.constituency_id").where(
        [
            "candidates.first_name || candidates.last_name ILIKE ? OR constituencies.name ILIKE ?", search, search
        ]
    )
  end

  def self.list
    with_associations.all
  end

  def self.with_associations
    self.includes(:party, :constituency)
  end

  def twitter_url
    "https://twitter.com/#{twitter_handle}" unless twitter_handle.blank?
  end

  def slug_candidates
    [
      [:first_name, :last_name],
      [:first_name, :last_name, :id]
    ]
  end

  def full_name
    name = "#{first_name} #{last_name}"
    name += " (#{aka})" if aka.present?
    name
  end

  def label
    [first_name, last_name].join(' ')
  end

  def path
    "/candidates/#{slug}"
  end

  def position
    return 'Councillor' if current_councillor
    return 'Senator' if current_senator
  end

  def constituency_name
    constituency.try(:name)
  end

  def party_name
    party.try(:name)
  end

  private

  def normalize_twitter_handle
    self.twitter_handle = twitter_handle.to_s.split(".com/").last.to_s.split("@").last
  end
end
