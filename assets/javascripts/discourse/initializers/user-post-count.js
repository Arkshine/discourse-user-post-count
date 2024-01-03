import { apiInitializer } from "discourse/lib/api";
import UserPostCount from "../components/user-post-count";

export default apiInitializer("0.8", (api) => {
  const siteSettings = api.container.lookup("service:site-settings");

  if (siteSettings.user_post_count_in_post) {
    api.includePostAttributes("user_post_count");
    api.includePostAttributes("user_topic_count");

    api.decorateWidget("poster-name:after-name", (helper) => {
      return helper.attach("user-post-count", helper.attrs);
    });
  }

  if (siteSettings.user_post_count_in_usercard) {
    api.renderInOutlet("user-card-post-names", UserPostCount);
  }
});
