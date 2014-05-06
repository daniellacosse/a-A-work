Trellino.Routers.Boards = Backbone.Router.extend({
  initialize: function (boards, $rootEl) {
    this.boards = boards;
    this.$rootEl = $rootEl;
  },

  routes: {
    '': 'index',
    'boards/new': 'create',
    'boards/:id': 'show'
  },

  index: function () {
    console.log(this.boards)

    var boardsIndexView = new Trellino.Views.BoardsIndex({
      collection: this.boards
    })

    this._swapView(boardsIndexView)
  },

  create: function () {
    var boardCreateView = new Trellino.Views.NewBoard({
      collection: this.boards
    })

    this._swapView(boardCreateView)
  },

  show: function (id) {
    var board = this.boards.get(id);
    var boardShowView = new Trellino.Views.ShowBoard({
      model: board
    })

    this._swapView(boardShowView)
  },

  _swapView: function (view) {
    this._currentView && this._currentView.remove();
    this._currenView = view;
    this.$rootEl.html(view.render().$el);
  }
});
