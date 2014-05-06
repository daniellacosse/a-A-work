NewReader.Collections.FeedEntries = Backbone.Collection.extend({

  url: function(){
   return "feeds/" + this.feed.get("id") + "/entries/";
  },
  model: NewReader.Models.Entry,


});
