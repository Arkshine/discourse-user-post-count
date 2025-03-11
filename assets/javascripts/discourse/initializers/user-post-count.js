import { hbs } from "ember-cli-htmlbars";
import { apiInitializer } from "discourse/lib/api";
import { registerWidgetShim } from "discourse/widgets/render-glimmer";
import UserPostCount from "../components/user-post-count";

export default apiInitializer("0.8", (api) => {
  const siteSettings = api.container.lookup("service:site-settings");

  if (siteSettings.user_post_count_in_post) {
    api.includePostAttributes("user_post_count");
    api.includePostAttributes("user_topic_count");

    registerWidgetShim(
      "user-post-count",
      "span.user-post-user__container",
      hbs`<UserPostCount @count={{ @data.count }} />`
    );

    api.decorateWidget("poster-name:after", (helper) => {
      return helper.attach("user-post-count", {
        count: siteSettings.user_post_count_include_topic
          ? helper.attrs.user_post_count + helper.attrs.user_topic_count
          : helper.attrs.user_post_count,
      });
    });
  }

  if (siteSettings.user_post_count_in_usercard) {
    api.renderInOutlet("user-card-post-names", UserPostCount);
  }
});
