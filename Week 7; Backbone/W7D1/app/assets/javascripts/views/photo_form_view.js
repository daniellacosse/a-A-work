(function(root){
  var PT = root.PT = (root.PT || {})

  var PhotoFormView = PT.PhotoFormView = function(){
    this.$el = $('<div>');
    var that = this;
    this.$el.on("submit", "form", function(event) {
      event.preventDefault();
      that.submit(event);
    })
  }

  PhotoFormView.prototype.render = function(){
    this.$el.html('');

    var template = JST["photo_form"]()
    this.$el.append(template);

    return this.$el
  }

  PhotoFormView.prototype.submit = function(event) {
    var $form = $('#new-photo');
    var attr = $form.serializeJSON()['photo'];
    var photo = new PT.Photo(attr);
    console.log("pregame", PT.Photo.all);
    photo.create(function(newPhoto){
      PT.listRefresh()
      console.log('successful creation of:' + newPhoto);
    });
  }

})(this)