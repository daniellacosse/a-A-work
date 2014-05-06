NewReader.Routers.Feeds = Backbone.Router.extend({

  routes: {
    "": "feedsIndex",
    "feeds/:feed_id/entries": "feedEntriesIndex"
  },

  initialize: function(options) {
    this.$el = options.$el;
  },

  feedsIndex: function () {
    var that = this;

    var feeds = NewReader.feeds;

    feeds.fetch({
      success: function () {
        var view = new NewReader.Views.FeedsIndex({
          collection: feeds
        });

        that._swapView(view);
      }
    });
  },

  feedEntriesIndex: function (id) {
    var that = this;

    var feed = NewReader.feeds.get(id);

    var view = new NewReader.Views.ShowFeed({
      model: feed
    });

    that._swapView(view);
  },

  _swapView: function (view) {
    this._currentView && this._currentView.remove();
    this._currentView = view;
    this.$el.html(view.render().$el);
  }
});