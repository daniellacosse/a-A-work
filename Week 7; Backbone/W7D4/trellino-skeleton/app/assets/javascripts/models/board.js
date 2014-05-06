Trellino.Models.Board = Backbone.Model.extend({

  // collection: Trellino.Collections.Boards,
  urlRoot: '/api/boards',

  parse: function (jsonResp) {

    if (jsonResp.lists) {
      this.lists().set(jsonResp.lists)
      delete jsonResp.lists
    }

    return jsonResp
  },

  lists: function () {
    if (!this.lists) this._lists = new Trellino.Collections.Lists([])

    return this._lists
  }
});
