Trellino.Views.NewBoard = Backbone.View.extend({
  tagName: "section",
  className: "new-board",

  template: JST["boards/new"],

  events: {
    "submit" : "submitBoard"
  },

  submitBoard: function (event) {
    event.preventDefault();

    var formData = $(event.target).serializeJSON();
    this.collection.create(formData, {
      success: function () {
        // alert("hi from success callback");
        Backbone.history.navigate("/", {trigger: true});
      }
    });
  },

  render: function () {
    var content = this.template()

    this.$el.html(content)

    return this
  }

});