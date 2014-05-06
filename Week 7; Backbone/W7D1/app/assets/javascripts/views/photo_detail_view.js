(function(root){
  var PT = root.PT = (root.PT || {})

  var PhotoDetailView = PT.PhotoDetailView = function(photo){
    this.photo = photo;
    this.$el = $('<div>');

    var that = this;
    this.$el.on("click", "img", function(event) {
      event.preventDefault();
      that.popTagSelectView(event);
    })
  }


  PhotoDetailView.prototype.render = function(){
    this.$el.html('');

    var template = JST["photo_detail"]({photo: this.photo});
    this.$el.append(template);

    return this.$el
  }

  PhotoDetailView.prototype.popTagSelectView = function(event) {
    console.log(event.offsetX, event.offsetY);

    $('#tagger').css({
      'left': event.offsetX,
      'top': event.offsetY
    })
  }


})(this)