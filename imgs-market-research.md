---
date: 2022-07-24
title: market research for imgs.sh
---

I've been a little more [vocal](https://fosstodon.org/@erock/108702632072746753) recently about our
intention to build a premium image hosting service for hackers.  We are still
in the planning stage of that endeavor but I wanted to spend some time to
perform market research on image hosting services currently available to
people.

[I've gathered a list of image hosting services](https://erock.lists.sh/image-hosting-sites) 
and will be using this list as the foundation for our investigation.

# Feature comparison

Comparing cheapest option for all paid services.

## photos.google.com

- price               $1.67/mo (1 yr plan)
- file size           200MB
- total storage size  100GB
- num file types      9
- ads                 no
- compressed          no
- resize              no
- bundled             yes (one.google.com)
- permenant           yes
- api                 yes
- hotlinking          yes 

## dropbox.com

- price               $10/mo (1 yr plan)
- file size           100GB
- total storage size  2TB
- num file types      All of them
- ads                 no
- compressed          no
- resize              no
- bundled             yes (general file storage)
- permenant           yes
- api                 yes
- hotlinking          yes

## imgur.com

- price               $5/mo
- file size           20MB images, 200MB animated 
- total storage size  Unlimited
- num file types      14 
- ads                 no
- compressed          yes (over 5MB) 
- resize              no
- bundled             yes (coil provides ad free for other services)
- permenant           yes
- api                 yes
- hotlinking          no

# snap.as

- price               $6/mo
- file size           50MB
- total storage size  Unlimited
- num file types      ??
- ads                 no
- compressed          no
- resize              yes (width 1280px)
- bundled             yes
- permenant           yes
- api                 yes
- hotlinking          yes

# lensdump.com

- price               $2/mo
- file size           100MB
- total storage size  Unlimited
- num file types      5
- ads                 no
- compressed          no
- resize              no 
- bundled             no
- permenant           yes
- api                 yes
- hotlinking          no

# postimages.org 

- price               $3.49/mo (3 yr plan)
- file size           48MB
- total storage size  Unlimited
- num file types      ??
- ads                 no
- compressed          no
- resize              no 
- bundled             no
- permenant           yes
- api                 no
- hotlinking          yes

# flickr.com

- price               $3.49/mo (3 yr plan)
- file size           48MB
- total storage size  Unlimited
- num file types      4
- ads                 no
- compressed          no
- resize              no 
- bundled             no
- permenant           yes
- api                 yes
- hotlinking          yes (must provide backlink to flickr under image)

# photobucket.com

- price               $5.41/mo (1 yr plan)
- file size           ??
- total storage size  25GB
- num file types      4
- ads                 no
- compressed          no
- resize              no 
- bundled             no
- permenant           yes
- api                 no
- hotlinking          yes

# imageshack.com

- price               $3.16/mo (1 yr plan)
- file size           25MB
- total storage size  Unlimited
- num file types      5
- ads                 no
- compressed          no
- resize              no 
- bundled             no
- permenant           yes
- api                 no
- hotlinking          yes

# catbox.moe 

- price               Free 
- file size           200MB
- total storage size  Unlimited
- num file types      All of them minus 5
- ads                 no
- compressed          no
- resize              no 
- bundled             no
- permenant           yes
- api                 yes
- hotlinking          yes (with prior approval)

# Pricing

- photos.google.com
  - $1.67/mo (1 yr plan)
- imgur.com
  - $5/mo (via Coil)
- snap.as
  - $6/mo billed annually or 
  - $9/mo month-to-month
- 0x0.st
  - Free
- lensdump.com
  - $2/mo
  - $7/mo
  - $18/mo
- postimages.org
  - Free
  - $3.49/mo (3 year plan)
  - $6.99/mo (1 year plan)
  - $11.95/mo (1 month plan)
- cubeupload.com
  - Free
  - Donate
- flickr.com
  - $8.25/mo (plus tax)
  - $5.99/mo, total $71.99 (plus tax, 1 year plan)
  - $5.54/mo, total $132.99 (plus tax, 2 year plan) 
- photobucket.com
  - $6/mo (or $65/yr)
  - $8/mo (or $87/yr)
  - $13/mo (or $141/yr) 
- imageshack.com
  - $3/mo (or $37.99/yr) 
  - $29.99/mo (or $285.99/yr)
  - $99.99/mo (or $953.99/yr)
- kek.gg
  - Free 
- imgchest.com
  - Free
- catbox.moe
  - Free
  - Donation
    - $900/mo server bills
- vgy.me
  - Free
  - Donation
- imgbox.com
  - Free
- imgpile.com
  - Ads
- bayimg.com
  - Donation
    - BTC

# Premium Features

- imgur.com
  - Ad-free
  - Permenant
- snap.as
  - Purchased via write.as pro
  - For professional photographer or hobbyist
  - Share photos on the internet
  - Photo albums
  - Captions
  - No ads
  - CLI
  - Permenant
- 0x0.st
  - Max file size: 512.0 MB
  - Blocked file types: application/x-dosexec, application/x-executable, application/x-hdf5, application/java-archive, Android APKs and system images
  - Files are valid between 30 days and a year depending on the size of the
    file
- lensdump.com
  - $2/mo
    - You get good karma in return
    - Every penny counts
    - Helps us stay ad free
    - Skip automated image moderation
  - $7/mo
    - Everything in prev plan
    - Hotlink image assets as CDN
    - Commercial usage allowed
  - $18/mo
    - Sharex and API access
- postimages.org
  - Free
    - Advertising enabled
    - Hotlinks downscaled to 1280px
    - Max 24Mb file size
  - Premium
    - Unlimited Image Hosting
    - Advertising disabled for you and visitors of your images
    - Hotlink images in original resolution
    - Max 48Mb file size
- cubeupload.com
  - At the moment we accept .JPG, .PNG, and .GIF
  - 5MB in size 
  - Never compress these formats or mess with your image
  - .BMP and .PDF are also accepted, but they convert them to .PNG
- flickr.com
  - Unlimited storage
  - Full resolution
  - Ad-Free Browsing
  - Advanced Stats
  - Partner Discounts
  - Stats on your photo views
  - Ad-free browsing and sharing on Flickr
  - Desktop & Mobile Auto-Uploadr automatically backing-up images
  - Ability to use specific commercial activity to promote your business and products
  - Premier Product Support
  - Advanced Stats on Mobile
  - 6K Photo Display Option
  - 10-Minute Videos 
  - Share more of your photos in Groups. Post your photo in up to 60 groups when limits are posted. Free accounts have a 30 group limit.
- photobucket.com
  - No compression
  - Private encryption
  - Visibility controls
  - EXIF data removal
  - The embed link means you keep control of your photos, no matter where they end up.
  - $6/mo (or $65/yr)
    - 25 GB 
  - $8/mo
    - 250 GB
    - Unlimited hosting
  - $13/mo
    - Unlimited storage
    - Unlimited hosting
- imageshack.com
  - 25MB file size per image
  - Privacy controls
  - Easy to grab links
  - Image stats
  - Unlimited space
  - Ad and spam free
  - Embed photos on other websites
  - Free mobile app
  - Basic
    - Unlimited Space
    - Direct Linking
    - Image Stats
    - Watermarking
    - Automatic Backups
    - Mobile App 
  - Pro
    - Everything in Basic plan
    - Between 30Gb to 1Tb of bandwidth per month, equivalent to up to ~1 million views of a 1Mb file.
    - Dedicated Support
    - Dynamic Image Resizer
    - API Access
  - Premium
    - Everything in Pro plan
    - Between 1Tb to 4Tb of bandwidth per month, equivalent to up to ~4.2 million views of a 1Mb file. 
- kek.gg
  - EXIF Data is removed
  - does not use cookies
  - does not associate user data with images
  - does not use Google Analytics or any third party tracking service
  - Albume hosting
- imgchest.com
  - Upload 20 pictures at one time 
  - API
    - 60 requests per hour
    - Sharex integration
  - Ad-free
  - https://www.patreon.com/imagechest/creators
- catbox.moe
  - 200MB filesize
  - The following file types are currently not allowed: .exe, .scr, .cpl, .doc*, .jar
  - API
  - ShareX
- vgy.me
  - API 
  - 20 MB per image
  - No videos
  - EXIF data removed
  - jpg, jpeg, png, gif
  - ShareX
- imgbox.com
  - 10 MB per image 
  - jpg, jpeg, png, gif
  - Unlimited storage space
  - Unlimited storage time
- imgpile.com
  - Hotlinking
  - 100 MB file size
  - Served via CDN
- bayimg.com
  - 100 MB file size 
  - 140 different file extensions
  - Uncensored
