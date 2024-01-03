import Component from "@ember/component";
import { inject as service } from "@ember/service";
import I18n from "discourse-i18n";

export default class UserPostCount extends Component {
  @service siteSettings;

  <template>
    {{#if this.shouldRender}}
      <div class="user-post-count" data-count={{this.postCount}}>
        {{this.content}}
      </div>
    {{/if}}
  </template>

  get shouldRender() {
    return this.postCount > 0;
  }

  get content() {
    return I18n.t("user_post_count.content", { count: this.postCount });
  }

  get postCount() {
    return (
      (this.siteSettings.user_post_count_include_topic
        ? this.outletArgs?.user.post_count + this.outletArgs?.user.topic_count
        : this.outletArgs?.user.post_count) ||
      this.count ||
      0
    );
  }
}
