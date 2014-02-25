#' Set connection details to an Elasticsearch engine.
#' 
#' @param url the url, defaults to localhost (http://127.0.0.1)
#' @param port port to connect to, defaults to 5984
#' @param user User name, if required for the connection. You can specify, but 
#' ignored for now.
#' @param pwd Password, if required for the connection. You can specify, but 
#' ignored for now.
#' @details The default configuration is set up for localhost access on port 9200,
#' with no username or password.
#' 
#' Pass on the returned 'es_conn' object to other functions in this package.
#' @export
#' @examples
#' (conn <- es_connect())
#' 

es_connect <- function(url="http://127.0.0.1", port=9200, user = NULL, pwd = NULL){
  ll <- list(url = url,
             port = port,
             user = user,
             pwd = pwd)
  class(ll) <- 'es_conn'
  return( ll )
}

#' @method print es_connect
#' @export
#' @rdname es_connect
print.es_connect <- function(x){
  fun <- function(x) ifelse(is.null(x), 'NULL', x)
  cat(paste('uri:      ', fun(x$url)), "\n")
  cat(paste('port:     ', fun(x$port)), "\n")
  cat(paste('username: ', fun(x$user)), "\n")
  cat(paste('password: ', fun(x$pwd)))
}