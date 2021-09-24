#!/bin/bash
echo "152.140.241.246  zucpgtssvsat002.reddog.microsoft.com" >> /etc/hosts
echo "
# Red Hat Subscription Manager Configuration File:
# Unified Entitlement Platform Configuration
[server]
# Server hostname:
hostname = zucpgtssvsat002.reddog.microsoft.com
# Server prefix:
prefix = /rhsm
# Server port:
port = 443
# Set to 1 to disable certificate validation:
insecure = 1
# Set the depth of certs which should be checked
# when validating a certificate
ssl_verify_depth = 3
# an http proxy server to use
proxy_hostname =
# port for http proxy server
proxy_port =
# user name for authenticating to an http proxy, if needed
proxy_user =
# password for basic http proxy auth, if needed
proxy_password =
# host/domain suffix blacklist for proxy, if needed
no_proxy =
server_timeout = 900
[rhsm]
# Content base URL:
baseurl= https://zucpgtssvsat002.reddog.microsoft.com/pulp/repos
# Server CA certificate location:
ca_cert_dir = /etc/rhsm/ca/
# Default CA cert to use when generating yum repo configs:
repo_ca_cert = %(ca_cert_dir)skatello-server-ca.pem
# Where the certificates should be stored
productCertDir = /etc/pki/product
entitlementCertDir = /etc/pki/entitlement
consumerCertDir = /etc/pki/consumer
# Manage generation of yum repositories for subscribed content:
manage_repos = 1
# Refresh repo files with server overrides on every yum command
full_refresh_on_yum = 1
# If set to zero, the client will not report the package profile to
# the subscription management service.
report_package_profile = 1
# The directory to search for subscription manager plugins
pluginDir = /usr/share/rhsm-plugins
# The directory to search for plugin configuration files
pluginConfDir = /etc/rhsm/pluginconf.d
[rhsmcertd]
# Interval to run cert check (in minutes):
certCheckInterval = 240
# Interval to run auto-attach (in minutes):
autoAttachInterval = 1440
# If set to zero, the checks done by the rhsmcertd daemon will not be splayed (randomly offset)
splay = 1
[logging]
default_log_level = INFO
# subscription_manager = DEBUG
# subscription_manager.managercli = DEBUG
# rhsm = DEBUG
# rhsm.connection = DEBUG
# rhsm-app = DEBUG
# rhsm-app.rhsmd = DEBUG
" > /etc/rhsm/rhsm.conf 
subscription-manager unregister
rpm -Uvh --force http://zucpgtssvsat002.reddog.microsoft.com/pub/katello-ca-consumer-latest.noarch.rpm
subscription-manager register --org="Default_Organization" --activationkey="MCD-Azure-Clients"
subscription-manager repos --enable=rhel-7-server-rpms
yum-config-manager --disable rhui*
