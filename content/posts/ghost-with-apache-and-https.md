---
title: Ghost with Apache and HTTPS
slug: ghost-with-apache-and-https
date: 2019-12-29T12:37:50.000Z
lastmod: 2020-09-20T18:40:36.000Z
author: Martin
tags:
- Self Hosted
- Software
description: How to fix an "infinite redirects" error when setting up Ghost with Apache and SSL. As a fix, add a protocol header when forwarding the request to Ghost.
cover: /images/HttpsApacheGhost-2.png
---

When you set up a ghost blog with an Apache HTTP server as reverse proxy and enable SSL, you will get an error that the page cannot be loaded. In short, the fix is to add a header that specifies the incoming protocol at the reverse proxy to be `https`: `RequestHeader set X-Forwarded-Proto "https"`

```apacheconf
<IfModule mod_ssl.c>
  <VirtualHost *:443>
	ServerName blog.example.com

	ErrorLog ${APACHE_LOG_DIR}/error.log
	CustomLog ${APACHE_LOG_DIR}/access.log combined

	SSLCertificateFile /etc/letsencrypt/live/blog.example.com/fullchain.pem
	SSLCertificateKeyFile /etc/letsencrypt/live/blog.example.com/privkey.pem
	Include /etc/letsencrypt/options-ssl-apache.conf

	# Without this, ghost infinitely redirects:
	RequestHeader set X-Forwarded-Proto "https"

	ProxyPreserveHost on
	ProxyRequests off
	AllowEncodedSlashes NoDecode
	ProxyPass / http://127.0.0.1:2369/ nocanon
	ProxyPassReverse / http://127.0.0.1:2369/
  </VirtualHost>
</IfModule>
```

Example configuration with letsencrypt
## Details

The concrete error that you get when you do not set the `X-Forwarded-Proto` header depends on your browser. Chrome moans that there are "too many redirects", whereas Firefox whines that the site "is not configured correctly". In any case, if you monitor the network, you will see that the browsers (thankfully) stop an endless stream of forwards. The server always returns the same response: an HTTP redirect.

```http
Connected to blog.example.com port 443
GET / HTTP/1.1
Host: blog.example.com

HTTP/1.1 301 Moved Permanently
Location: https://blog.example.com
```

HTTP request/response for `https://blog.example.com/` (shortened)
Some details can be found in [this Github issue](https://github.com/TryGhost/Ghost/issues/2796) from 2014. To go deeper, we can look at the source code of ghost. The relevant code can be found in the [`url-redirect.js` middleware line 78](https://github.com/TryGhost/Ghost/blob/7284227f1ebb8835f2f9a91dea988332383fc219/core/server/web/shared/middlewares/url-redirects.js#L78):

```js
// CASE: configured canonical url is HTTPS, but request is HTTP, redirect to requested host + SSL
if (urlUtils.isSSL(blogHostWithProtocol) && !secure) {
  debug('redirect because protocol does not match');

  return _private.redirectUrl({
	redirectTo: `https://${requestedHost}`,
	path: requestedUrl,
	query: queryParameters
  });
}
```

`secure` is based on the `req.secure` property of the request. See [line 97 of the same file](https://github.com/TryGhost/Ghost/blob/7284227f1ebb8835f2f9a91dea988332383fc219/core/server/web/shared/middlewares/url-redirects.js#L97):

```js
/**
 * Takes care of
 *
 * 1. required SSL redirects
 * 2. redirect to the correct admin url
 *
 */
_private.redirect = (req, res, next, redirectFn) => {
  const redirectUrl = redirectFn({
	requestedHost: req.hostname,
	requestedUrl: url.parse(req.originalUrl || req.url).pathname,
	queryParameters: req.query,
	secure: req.secure
  });

  if (redirectUrl) {
	debug(`url redirect to: ${redirectUrl}`);
	return urlUtils.redirect301(res, redirectUrl);
  }

  debug('no url redirect');
  next();
};
```

Ghost uses the [Express web framework for Node.js](https://github.com/expressjs/express/). In Express' [`request.js` lib file line 292](https://github.com/expressjs/express/blob/b8e50568af9c73ef1ade434e92c60d389868361d/lib/request.js#L292), it defines when to set the protocol to `https`:

```js
/**
 * Return the protocol string "http" or "https"
 * when requested with TLS. When the "trust proxy"
 * setting trusts the socket address, the
 * "X-Forwarded-Proto" header field will be trusted
 * and used if present.
 *
 * If you're running behind a reverse proxy that
 * supplies https for you this may be enabled.
 *
 * @return {String}
 * @public
 */
defineGetter(req, 'protocol', function protocol(){
  var proto = this.connection.encrypted
	? 'https'
	: 'http';
  var trust = this.app.get('trust proxy fn');

  if (!trust(this.connection.remoteAddress, 0)) {
	return proto;
  }

  // Note: X-Forwarded-Proto is normally only ever a
  //       single value, but this is to be safe.
  var header = this.get('X-Forwarded-Proto') || proto
  var index = header.indexOf(',')

  return index !== -1
	? header.substring(0, index).trim()
	: header.trim()
});
```

As you can see, if the incoming connection is not encrypted, it checks for the `X-Forwarded-Proto` header and returns its value. Normally, you would terminate SSL at ??your reverse proxy so that Express receives a plain `http` protocol request. However, by setting the `X-Forwarded-Proto: https` header on the reverse proxy, Express trusts that the connection from the original client was done using the `https` protocol.

As you set up your Apache server to handle SSL requests, any request you forward to ghost can safely get the header added. Once that is done, ghost will see that:

1. Your URL uses `https://` and
2. The incoming request *is* deemed secure and therefore
3. Return the content instead of a redirect (see ghost code above)
