// Generated by LiveScript 1.4.0
(function(){
  Polymer({
    is: 'intro-page',
    properties: {
      experiment_list: Array
    },
    ready: function(){
      var self;
      self = this;
      return $.get('experiment_list.yaml', function(experiment_list_text){
        return self.experiment_list = jsyaml.safeLoad(experiment_list_text);
      });
    }
  });
}).call(this);