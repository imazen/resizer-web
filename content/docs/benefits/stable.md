Tag: benefits

# Stable and Secure

ImageResizer has been designed defensively since its inception six years ago.

## Stability

Aggressive disposal of large heap objects ensures ImageResizer can reach theoretical concurrency peaks, and won't crash your server.




## Secure - XSS

ImageResizer re-encodes images from untrusted domains. A bitmap image can also be a valid javascript file. 

## DOS and DDOS protection

### RAM & CPU

ImageResizer attempts memory allocation prior to any resource-intensive tasks. If there's not enough contiguous space, the request is rejected - swap space in the pagefile is never used. In practice, this makes DDOS attacks extremely ineffective, as they cannot exhaust (or even severely limit) RAM in an effective fashion. 


### Disk space

ImageResizer's DiskCache system supports cache cleanup management, and can limit the cache size. While it's less relevant in the age of transient storage space, AppHarbor and Azure, this feature is still an extra defense layer against a very determined attacker.
