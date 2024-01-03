# frozen_string_literal: true

# name: discourse-user-post-count
# about: Displays the user post count.
# meta_topic_id:
# version: 0.0.1
# authors: Arkshine
# url: https://github.com/Arkshine/discourse-user-post-count
# required_version: 2.7.0

register_asset "stylesheets/common/user-post-count.scss"

enabled_site_setting :user_post_count_enabled

module ::UserPostCount
  PLUGIN_NAME = "discourse-user-post-count"
end

require_relative "lib/user_post_count/engine"

after_initialize do
  add_class_method(:user, :topic_count) { stat.topic_count }

  add_to_serializer(
    :post,
    :user_post_count,
    include_condition: -> { SiteSetting.user_post_count_in_post },
  ) { object.user&.post_count }

  add_to_serializer(
    :post,
    :user_topic_count,
    include_condition: -> do
      SiteSetting.user_post_count_in_post && SiteSetting.user_post_count_include_topic
    end,
  ) { object.user&.topic_count }

  add_to_serializer(
    :user_card,
    :post_count,
    include_condition: -> { SiteSetting.user_post_count_in_usercard },
  ) { object.post_count }

  add_to_serializer(
    :user_card,
    :topic_count,
    include_condition: -> do
      SiteSetting.user_post_count_in_usercard && SiteSetting.user_post_count_include_topic
    end,
  ) { object.user_stat&.topic_count }
end
