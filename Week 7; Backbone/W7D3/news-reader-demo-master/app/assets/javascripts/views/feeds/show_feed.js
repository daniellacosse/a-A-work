NewReader.Views.ShowFeed = Backbone.View.extend({
  template: JST['feeds/show'],

  events: {
    "click .refresh": "refreshEntries"
  },

  initialize: function () {
    this.listenTo(this.model.get("entries"), "add", this.render)
  },

  render: function() {
    var entries = this.model.get("entries");

    console.log(entries.first().get("title"))

    var renderedContent = this.template({
      feed: this.model,
      entries: entries
    });

    this.$el.html(renderedContent);

    return this;
  },

  refreshEntries: function() {
    this.model.get("entries").fetch();
  }
});