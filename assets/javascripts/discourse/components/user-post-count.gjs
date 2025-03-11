import Component from "@ember/component";
import { service } from "@ember/service";
import { i18n } from "discourse-i18n";

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
    return i18n("user_post_count.content", { count: this.postCount });
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
