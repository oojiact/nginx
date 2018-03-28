
hroling / gist:85f36e86d48285f08161

Apache 2.4 SSL config for A+ on SSLLabs.com
gistfile1.txt
OS: Ubuntu 14.04 LTS, Apache 2.4.7, OpenSSL 1.0.1f
SSL Labs: A+ (RSA2048, SHA256 certificate)
Certificate: 100%
Protocol Support: 95%
Key Exchange: 90%
Cipher Strength: 90% 

#### In the SSL.CONF file
SSLCipherSuite AES256+EECDH:AES256+EDH:AES128+EECDH:AES128+EDH

SSLProtocol -ALL -SSLv3 +TLSv1 +TLSv1.1 +TLSv1.2

SSLHonorCipherOrder on
SSLStrictSNIVHostCheck Off
SSLCompression off

SSLStaplingCache shmcb:/tmp/stapling_cache(128000)

SSLOptions +FakeBasicAuth +ExportCertData +StrictRequire

### In the <virtualhost> section of file default-ssl.conf
SSLUseStapling on
SSLStaplingResponderTimeout 5
SSLStaplingReturnResponderErrors off

### headers_module must be enabled for these extra security settings
Header always set Strict-Transport-Security "max-age=63072000; includeSubDomains"
Header edit Set-Cookie ^(.*)$ $1;HttpOnly;Secure
Header set Public-Key-Pins "pin-sha256=\"<Subject Public Key Information (SPKI)>\"; max-age=2592000; includeSubDomains"
Header always set X-Frame-Options SAMEORIGIN

@ibrahim87
ibrahim87 
commented about 2 years ago
very good

@angshumancn
angshumancn 
commented over 1 year ago
Does the above keyword support Apache/2.2.22 ?

@DarkLogicX
DarkLogicX 
commented over 1 year ago
Where is the "Default-SSL.conf" file?

Also when I put "SSLStaplingCache shmcb:/tmp/stapling_cache(128000)" in the SSL.conf file (the one in Httpd/conf.d/) httpd wouldn't start.

@cofifield
cofifield 
commented over 1 year ago
Great Info

@zachariahtimothy
zachariahtimothy 
commented 7 months ago
Just used this, thanks for sharing! I omitted the public key pins and still received A+.

Comment on gist
Sign in to comment
or sign up to join this conversation on GitHub
 Desktop version
