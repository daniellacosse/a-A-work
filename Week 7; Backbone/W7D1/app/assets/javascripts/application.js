// This is a manifest file that'll be compiled into application.js,
// which will include all the files listed below.
//
// Any JavaScript/Coffee file within this directory,
// lib/assets/javascripts, vendor/assets/javascripts, or
// vendor/assets/javascripts of plugins, if any, can be referenced
// here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll
// appear at the bottom of the the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE
// PROCESSED, ANY BLANK LINE SHOULD GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require jquery.serializeJSON
//= require underscore
//
//= require_tree ./models
//= require_tree ../templates
//
//= require_tree .

PT.initialize = function(id) {
  PT.Photo.fetchByUserId(id,function(){

    PT.showPhotosIndex()
    PT.listRefresh()
    PT.formRefresh()

  });
}

PT.showPhotosIndex = function(){
    PT.photoList = new PT.PhotosListView()
    PT.form = new PT.PhotoFormView()
}

PT.showPhotoDetail = function(photo){
  var photoDetailView = new PT.PhotoDetailView(photo)

  $('#content').html(photoDetailView.render())
}

PT.listRefresh = function() {
  $('#content').append(PT.photoList.render())
}

PT.formRefresh = function() {
  $('#content').append(PT.form.render())
}
// var Photo = function (attributes) {
//
//   this.attributes = _.extend({}, attributes)
// }
//
// Photo.all = [];
//
// Photo.prototype.get = function (attribute) {
//   return this.attributes[attribute]
// }
//
// Photo.prototype.set = function (attribute, val) {
//   this.attributes[attribute] = val
// }
//
// Photo.prototype.create = function (callback) {
//   var that = this;
//
//   if (this.get("id")) return;
//   console.log(that.attributes);
//
//   thisPhoto = $.ajax({
//     url: "/api/photos",
//     type: "POST",
//     data: {'photo': that.attributes},
//     success: function(data) {
//       that.attributes = _.extend(that.attributes, data)
//       callback(that)
//     }
//   })
//
//   Photo.all.push(thisPhoto)
// }
//
// Photo.prototype.save = function (callback) {
//   var that = this;
//
//   if (!this.get("id")) return;
//
//   $.ajax({
//     url: "/api/users/" + that.get('owner_id') + "/photos/" + that.get('id'),
//     type: "PATCH",
//     data: {'photo': that.attributes},
//     success: function(data) {
//       that.attributes = _.extend(that.attributes, data)
//       callback(that)
//     }
//   })
// }
//
// Photo.fetchByUserId = function(userId, callback) {
//   thesePhotos = $.ajax({
//     url: "/api/users/" + userId + "/photos",
//     type: "GET",
//     success: function(data) {
//       callback(data)
//     }
//   });
//
//   Photos.all.concat(thesePhotos)
// }




