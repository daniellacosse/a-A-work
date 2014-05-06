NewReader.Views.FeedsIndex = Backbone.View.extend({

  template: JST['feeds/index'],

  initialize: function () {
    this.listenTo(this.collection, "change", this.render)
    this.listenTo(this.collection, "add", this.renderSingleFeed)
  },

  render: function () {
    var renderedContent = this.template({
      feeds: this.collection
    })

    this.$el.html(renderedContent);

    return this;
  },

  renderSingleFeed: function (model) {
    var view = NewReader.Views.FeedShow({ model: model });

    this.$el.append(view.render().$el);
  }

});
