(function(root){
  var PT = root.PT = (root.PT || {})

  var PhotosListView = PT.PhotosListView = function(){
    this.$el = $('<div>');

    var that = this;

    this.$el.on('click', 'a', function(event){
      that.showDetail(event);
    });
  }

  PhotosListView.prototype.render = function(){
    var $$el = this.$el

    $$el.html('');
    $$el.append($('<ul>'));
    _(PT.Photo.all).each( function(photo) {
      $$el.append($('<li><a href="#" data-id="'+ photo.id +'">' + photo.title + '</a></li>'));
    })
    return $$el
  }

  PhotosListView.prototype.showDetail = function(event){
    event.preventDefault();

    var photo = PT.Photo.find($(event.currentTarget).attr('data-id'))
    PT.showPhotoDetail(photo);
  }

})(this)

