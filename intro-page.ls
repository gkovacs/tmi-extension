Polymer {
  is: 'intro-page'
  properties: {
    experiment_list: Array
  }
  ready: ->
    self = this
    experiment_list_text <- $.get 'experiment_list.yaml'
    self.experiment_list = jsyaml.safeLoad experiment_list_text
}
