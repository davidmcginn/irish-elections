namespace :social do
  desc "Update twitter counts for all candidates."
  task :update_twitter_counts do
    candidates = Candidate.where.not(twitter_handle: nil)

    candidates.each do |candidate|
      next unless twitter_handle.present?

      followers_count = begin TwitterService.new.user(twitter_handle).followers_count
      rescue Twitter::Error::NotFound
        nil
      end

      next unless followers_count.present?
      puts "Update twitter counts for: #{candidate.full_name} - #{followers_count} followers"
      attributes = { twitter_followers_count: followers_count, candidate_id: candidate.id }
      SocialCount.upsert(attributes, by: { date: Date.today.iso8601 })
    end

  end

  desc "Create Twitter lists for each constituency"
  task :create_twitter_lists => [ :environment ] do
    client = Twitter::REST::Client.new do |config|
    end

    Constituency.all.each do |constituency|
      client.create_list(constituency.twitter_list) unless constituency.twitter_list.nil?
      # client.destroy_list("#{constituency.twitter_list}1") unless constituency.twitter_list.nil?
      # client.destroy_list("#{constituency.twitter_list}2") unless constituency.twitter_list.nil?
    end

  end

  desc "Add candidates to constituency Twitter lists"
  task :add_candidates_to_lists => [ :environment ] do
    client = Twitter::REST::Client.new do |config|
    end

    Constituency.all.each do |constituency|
      constituency.candidates.each do |candidate|
        if constituency.twitter_list && candidate.twitter_handle
          begin
            response = client.add_list_member(constituency.twitter_list, candidate.twitter_handle)
          rescue Exception => e
            print "Could not add #{candidate.twitter_handle} to #{constituency.twitter_list}\n"
          end
        end

      end
    end

  end
end