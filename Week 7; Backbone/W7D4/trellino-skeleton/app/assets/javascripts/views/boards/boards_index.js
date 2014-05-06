Trellino.Views.BoardsIndex = Backbone.View.extend({
  tagName: "ul",
  className: "boards-list",

  template: JST['boards/index'],

  initialize: function () {
    this.listenTo(this.collection, "add", this.render)
  },

  render: function() {
    var content = this.template({
      boards: this.collection
    })

    this.$el.html(content)

    return this
  }

});
