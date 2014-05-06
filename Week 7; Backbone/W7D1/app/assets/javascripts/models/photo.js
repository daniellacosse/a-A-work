(function(root){

  var PT = root.PT = (root.PT || {})

  var Photo = PT.Photo = function (attributes) {

    this.attributes = _.extend({}, attributes)
  }

  Photo.all = [];

  Photo.prototype.get = function (attribute) {
    return this.attributes[attribute]
  }

  Photo.prototype.set = function (attribute, val) {
    this.attributes[attribute] = val
  }

  Photo.prototype.create = function (callback) {
    if (this.get("id")) return;
    var that = this;

    $.ajax({
      url: "/api/photos",
      type: "POST",
      data: {'photo': that.attributes},
      success: function(data) {
        that.attributes = _.extend(that.attributes, data)
        callback(that)
        PT.Photo.all.push(data)
        PT.listRefresh()
        PT.formRefresh()
      }
    })
  }

  Photo.prototype.save = function (callback) {
    var that = this;

    if (!this.get("id")) return;

    var thisPhoto = $.ajax({
      url: "/api/users/" + that.get('owner_id') + "/photos/" + that.get('id'),
      type: "PATCH",
      data: {'photo': that.attributes},
      success: function(data) {
        that.attributes = _.extend(that.attributes, data)
        callback(that)
      }
    })

    Photo.all.push(thisPhoto)
  }

  Photo.fetchByUserId = function(userId, callback) {
    $.ajax({
      url: "/api/users/" + userId + "/photos",
      type: "GET",
      success: function(data) {
        PT.Photo.all = PT.Photo.all.concat(data)
        callback(data)
      }
    });
  }

  Photo.find = function(id) {
    var photoObj;
    // debugger
    _(PT.Photo.all).each( function(photo){
      if (photo.id === parseInt(id)) photoObj = photo
    })

    return photoObj
  }
})(this)