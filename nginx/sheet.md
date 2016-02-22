# nginx
Written at v1.9.2 time

## Build

Go to [http://www.nginx.org](http://www.nginx.org)

```bash
tar -zxvf nginx-1.9.2.tar.gz
cd nginx-1.9.2
```

also need :

```bash
# Ubuntu / Debian
apt-get install build-essential
apt-get install libpcre3-dev zlib1g-dev libssl-dev

# RedHat / CentOS
yum group install "Development Tools"
yum install libpcre3-dev zlib1g-dev libssl-dev  # to control
```

Then build :

```bash
./configure
make
sudo make install
```

These commands will build in `/usr/local/nginx/`

- /usr/local/nginx/conf => configuration

To change the folders :
./configure --prefix=/usr —conf-path=/etc/nginx

These are the build option.  
You need to add --with-<option> at build time


```
Name                  option              Description                                             default
---------------------------------------------------------------------------------------------------------
Charset               http_charset        Adds the Content-Type header to the HTTP response       Yes
Gzip                  http_gzip           Compresses the HTTP response                            Yes
SSI                   http_ssi            Processes Service-Side Includes                         Yes
Userid                http_userid         Sets an HTTP Cookie suitable for Client Identification  Yes
Access                http_access         Allows limiting access to certain client IP addresses   Yes
Basic Auth            http_auth_basic     Allows limiting access by validating username and       Yes
                                              password using HTTP Basic Authentication

Auto Index            http_autoindex      Processes requests ending in “/” and produces a         Yes
                                              directory listing

Geo                   http_geo Creates    variables with values depending on the IP address       Yes
Map                   http_map Creates    variables whose values depend on other variable values  Yes
Split Clients         http_split_clients  Creates variables for use with split (A/B) testing      Yes
Referer               http_referer        Blocks access depending on the value of the HTTP        Yes
                                              Referer Header

Rewrite               http_rewrite        Changes the request URI using regular expressions       Yes
Proxy                 http_proxy          Allows passing requests to another HTTP server          Yes
Fastcgi               http_fastcgi        Allows passing requests to a FastCGI server             Yes
uWSGI                 http_uwsgi          Allows passing requests to a uWSGI server               Yes
SCGI                  http_scgi           Allows passing requests to a SCGI server                Yes
Memcached             http_memcached      Used to obtain values from a Memcached server           Yes
Limit Conn            http_limit_conn     Limit the number of connections per IP address          Yes
Limit Req             http_limit_req      Limit the request processing rate per IP address        Yes
Empty GIF             http_empty_gif      Emits a single-pixel transparent GIF image              Yes
Browser               http_browser        Allows browser detection based on the User-Agent HTTP   Yes
                                              Header


Perl                  http_perl           Implement location and variable handlers in Perl        No
SSL                   http_ssl            Handle SSL traffic within nginx                         No
SPDY                  http_spdy           Provides experimental support for SPDY                  No
RealIP                http_realip         Change the Client IP Address of the Request             No
Addition              http_addition       Adds text before and after the HTTP response            No
XSLT                  http_xslt           Post-process pages with XSLT                            No
Image Filter          http_image_filter   Transform images with libgd                             No
GeoIP                 http_geoip          Create variables with geo information based on          No
                                              the IP Address
Substitution          http_sub            Replace text in Pages                                   No
WebDAV                http_dav            WebDAV pass-through support                             No
FLV                   http_flv            Flash Streaming Video                                   No
MP4                   http_mp4            Enables mp4 streaming with seeking ability              No
Gunzip                http_gunzip         On-the-fly decompression of gzipped responses           No

Gzip Precompression   http_gzip_static    Serves already pre-compressed static files No
Auth Request          http_auth_request   Implements client authorization based on the result     No
                                              of a subrequest

Random Index          http_random_index   Randomize directory index                               No
Secure Link           http_secure_link    Protect pages with a secret key                         No
Degradation           http_degradation    Allow to return 204 or 444 code for some locations      No
                                              on low memory condition
Stub Status           http_stub_status    View server statistics                                  No
```
