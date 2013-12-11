#' Start indexing a CouchDB database using Elasticsearch.
#'
#' @import httr
#' @param dbname Database name. (charcter)
#' @param endpoint the endpoint, defaults to localhost (http://127.0.0.1)
#' @param port port to connect to, defaults to 9200
#' @details The function returns TRUE. Though note that this can result even 
#'    if the database does not exist in CouchDB. 
#' @references See docs for the Elasticsearch River plugin \url{#} that lets you 
#' 	  easily index CouchDB databases.
#' @examples \dontrun{
#' library(sofa)
#' sofa_createdb(dbname='alm_couchdb')
#' elastic_river_start(dbname="alm_couchdb")
#' }
#' @export
elastic_river_start <- function(dbname, endpoint="http://localhost", port=9200)
{
  call_ <- sprintf("%s:%s/_river/%s/_meta", endpoint, port, dbname)
  args <- paste0('{ "type" : "couchdb", "couchdb" : { "host" : "localhost", "port" : 5984, "db" : "', dbname, '", "filter" : null } }')
  tt <- PUT(url = call_, body=args)
  stop_for_status(tt)
  content(tt)[1] 
}