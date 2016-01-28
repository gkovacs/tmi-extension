require! {
  express
}

{MongoClient} = require 'mongodb'

mongourl = process.env.MONGOHQ_URL ? process.env.MONGOLAB_URI ? process.env.MONGOSOUP_URL ? 'mongodb://localhost:27017/default'

app = express()

app.set 'port', process.env.PORT ? 8080

app.use express.static __dirname

app.use require('body-parser').json()

app.listen app.get('port'), '0.0.0.0'

app.get '/somefunc', (req, res) ->
  res.send 'hello world'

app.post '/logsurvey', (req, res) ->
  data = req.body
  {surveyname} = data
  if not surveyname?
    res.send 'need surveyname param'
    return
  data.ip = req.ip
  logsurvey data, ->
    res.send 'done'

app.get '/listsurvey', (req, res) ->
  {surveyname} = req.query
  if not surveyname?
    res.send 'need surveyname param'
    return
  get-collection surveyname, (collection, db) ->
    collection.find({}).toArray (err, results) ->
      res.send JSON.stringify(results)
      db.close()

get-mongo-db = (callback) ->
  #MongoClient.connect mongourl, {
  #  auto_reconnect: true
  #  poolSize: 20
  #  socketOtions: {keepAlive: 1}
  #}, (err, db) ->
  MongoClient.connect mongourl, (err, db) ->
    if err
      console.log 'error getting mongodb'
    else
      callback db

get-collection = (collection_name, callback) ->
  get-mongo-db (db) ->
    callback db.collection(collection_name), db

logsurvey = (data, callback) ->
  {surveyname} = data
  if not surveyname?
    console.log 'missing surveyname'
    return
  data.time = Date.now()
  data.localtime = new Date().toString()
  console.log 'performing insertion'
  console.log data
  get-collection surveyname, (collection, db) ->
    console.log 'have collection:'
    console.log collection
    collection.insert data, (err, docs) ->
      if err?
        console.log 'error upon insertion'
        console.log err
      else
        console.log 'insertion done'
        if callback?
          callback()
      db.close()


