NewReader.Models.Feed = Backbone.Model.extend({

  url: "/feeds",

  parse: function(jsonResp) {
    if (jsonResp.entries) {

      var that = this;

      _(jsonResp.entries).each(function(entry){
        entry.feed = that;
      })

      jsonResp.entries = new NewReader.Collections.FeedEntries(jsonResp.entries);
      jsonResp.entries.feed = that;
    }

    return jsonResp;
  }

});
