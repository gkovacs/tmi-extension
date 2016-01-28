// Generated by LiveScript 1.4.0
(function(){
  var main;
  main = function(){
    var params, query, item;
    console.log('running main in bing_search');
    if (window.location.host !== 'www.bing.com') {
      console.log('not on www.bing.com');
      console.log('host location is:');
      console.log(window.location.host);
      return;
    }
    params = getUrlParameters();
    query = params.q;
    if (query == null) {
      return;
    }
    item = {
      query: query,
      timestamp: Date.now(),
      time: new Date().toString()
    };
    return addtolist('bing_history', item);
  };
  onlocationchanged(main);
}).call(this);
