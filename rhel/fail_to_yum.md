# Certidicate has expired

`yum update`

Loaded plugins: product-id, refresh-packagekit, rhnplugin, security, subscription-manager
There was an error communicating with RHN.
RHN Satellite or RHN Classic support will be disabled.
rhn-plugin: Error communicating with server. The message was:

Error Message:
    Satellite Certificate has expired
Error Class Code: 3006
Error Class Info: Invalid satellite certificate
Explanation:
     An error has occured while processing your request. If this problem
     persists please consult the Red Hat Customer Portal Knowledge Base
     landing page on common registration Error Class Codes at
     https://access.redhat.com/solutions/17036 for a possible resolution.
     If you choose to open a support case in the Red Hat Customer Portal,
     please be sure to include details of what you were trying to do when
     this error occurred and specifics on how to reproduce this problem.

## Solution:
change the rhnplugin.conf from enable 1 to 0

`vi /etc/yum/pluginconf.d/rhnplugin.conf`

[main]
enabled = 1  ->  0
