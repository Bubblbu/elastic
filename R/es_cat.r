#' Use the cat Elasticsearch api.
#' 
#' @import httr 
#' @importFrom plyr compact
#' 
#' @template all
#' @template get
#' @param exists XXX
#' @details There are a lot of terms you can use for Elasticsearch. See here 
#'    \url{http://www.elasticsearch.org/guide/reference/query-dsl/} for the documentation.
#' @export
#' @examples \dontrun{
#' es_cat(index='twitter', type='tweet', id=1)
#' es_cat(index='mran', id=1)
#' }

es_cat <- function(index=NULL, type=NULL, id=NULL, source=FALSE, 
  fields=NULL, exists=FALSE, raw=FALSE, callopts=list(), verbose=TRUE, ...)
{
  conn <- es_get_auth()
  
  if(length(id) > 1){ # pass in request in body
    body <- toJSON(list(ids = as.character(id)))
  }
  
  if(!is.null(fields)) fields <- paste(fields, collapse=",")
  
  url <- paste(conn$url, ":", conn$port, sep="")
  if(source) url <- paste(url, '_source', sep="/")
  args <- es_compact(list(fields = fields, ...))
  
  if(exists){
    out <- HEAD(url, query=args, callopts)
    message(paste(out$headers[c('status','statusmessage')], collapse=" - "))
  } else
  {
    out <- GET(url, query=args, callopts)
    stop_for_status(out)
    if(verbose) message(URLdecode(out$url))
    tt <- content(out, as="text")
    class(tt) <- "elastic_get"
    if(raw){ tt } else { es_parse(tt) }
  }
}