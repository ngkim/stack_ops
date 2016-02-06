#!/bin/bash

cp iptablesload /etc/network/if-pre-up.d/

cp iptablessave /etc/network/if-post-down.d/

/etc/network/if-pre-up.d/iptablesload
