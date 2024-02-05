# TODO

- https://github.com/NginxProxyManager/nginx-proxy-manager/blob/bb0f4bfa626bfa30e3ad2fa31b5d759c9de98559/docker/rootfs/etc/nginx/conf.d/include/block-exploits.conf
- https://hub.docker.com/r/owasp/modsecurity-crs
- use Iknowwhatyoudownlod to check. might be a fix https://www.reddit.com/r/VPNTorrents/comments/abt8mm/qbittorrent_with_vpn_activated_does_not_hide_ip/
- Letterboxd watchlist for everyone? https://github.com/screeny05/letterboxd-list-radarr
- Optionally add clean scripts to sab: https://trash-guides.info/Downloaders/SABnzbd/scripts/
- Put link, default username / password when requestrr is done in discord.
  Best method would be monitor content-requests for bobby.bot.requests and issue the following when found:
  curl -X 'GET' \
  'http://earth:5055/api/v1/request?take=20&skip=0&sort=added&requestedBy=1' \
  -H 'accept: application/json' \
  -H 'X-Api-Key: X-Api-Key TOKEN'

# Best Practices 

https://wiki.servarr.com/docker-guide which also links to
https://trash-guides.info/Hardlinks/How-to-setup-for/Docker/

I didn't follow the user / group / permission reccommendations though.

It's systemd recommendation might be good addtion as well when
integrating with ansible.

# Setup

- Need to copy the nordvpn username etc to .env.production
- Need to download openvpn config from nordvpn and copy ovpn file to `config/.openvpn`

# Setup: App Specifics

## Sonarr / Radarr

For each quality, I have configured profiles for english-only and any-language. See:
https://trash-guides.info/Radarr/Tips/How-to-setup-language-custom-formats/
(These aren't accessible via requestarr though)

Also, for the 720/1080 profile used by requestarr, I reordered to prefer non-remuxed 1080p
so that the filesizes stay down.

See here for how Radarr chooses downloads: https://wiki.servarr.com/radarr/faq#how-are-possible-downloads-compared

## Requestarr

Defaults to 720/1080 profile in radarr/sonarr

## Overseerr

Defaults to Any profile in radarr/sonarr (includes 4k)

## Prowlarr

Can tag an index with privoxy to have it go through qbit's privoxy

## Plex


In Plex, a server can be "claimed" and "signed-in" separately.
The only way I found to avoid sign-in was to click through via "What's this?" on the sign in page,
which is enabled if you have `allowedNetworks="172.18.0.0/16,192.168.86.0/24"` and a matching Host in URL.
`enableLocalSecurity="0"` allows a server to be unclaimed, but I didn't use this and just claimed instead.

IDK, basically just setup on local network and then access through nginx with those allowedNetwork settings.
I used a managed account for Bobby guests.

Some resources:
    - Pref XML Settings: https://support.plex.tv/articles/201105343-advanced-hidden-server-settings/
    - Plex network stuff: https://support.plex.tv/articles/200430283-network/
        - Interestingly, Plex says the allowedNetworks feature requires plex pass

# LVM 

This is the best resource for working with LVM disk management:
https://www.digitalocean.com/community/tutorials/how-to-use-lvm-to-manage-storage-devices-on-ubuntu-18-04#step-2-creating-or-extending-lvm-components
- One thing this doesn't cover is that you have to format logical volumes after creation: `mkfs.xfs /dev/vg-data/lv-data`

Each disk is a physical volume (/dev/sda disk is 2TB SSD).
There is a single volume group "vgubuntu" with all physical volumes.
I created a logical volume called "media" for media purposes and mounted to `/mnt/media`.

Use `sudo pvdisplay` to get PV info.
Use `lsblk` to see disks and lvm relationships.
