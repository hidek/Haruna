# Haruna - DDNS Web interface suite

1. copy config.sample to config.pl and edit it
```perl
{
    zone            => 'YOUR ZONE NAME',
    ns              => 'YOUR NAME SERVER',
    ttl             => 300,
    consumer_key    => 'YOUR CONSUMER KEY',
    consumer_secret => 'YOUR CONSUMER SECRET',
}
```
you can share consumer key pair in a server and a client.

2. run Haruna server
```
plackup
```

3. update DNS entry from client host
```
haruna.pl -h www -u htpp://example.com:5000/
```
