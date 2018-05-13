# Traefik active load balancer (Experimental)

### Info:

 This template deploys traefik active load balancers on top of Rancher. The configuration is generated and updated with confd from Rancher metadata.
 It would be deployed in hosts with label traefik_lb=true.

### Config:

- host_label = "traefik_lb=true" # Host label where to run traefik service.
- constraints = ""  # Traefik constraints for rancher provider.
- http_port = 8080  # Port exposed to get access to the published services.
- https_port = 8443  # Port exposed to get secured access to the published services.
- admin_enable = false  # Enable web ui.
- compress_enable = true    # Enable traefik compression
- admin_port = 8000  # Port exposed to get admin access to the traefik service.
- https_enable = <false | true | only>
  - false: Enable http enpoints and disable https ones.
  - true: Enable http and https endpoints.
  - only: Enable https endpoints and redirect http to https.
- acme_enable = false 				# Enable/Disable acme traefik support.
- acme_email = "test@traefik.io" 	# acme user email
- acme_ondemand = true 				# acme ondemand parameter.
- acme_onhostrule = true 			# acme onHostRule parameter.
- acme_caserver = "https://acme-v01.api.letsencrypt.org/directory" 			# acme caServer parameter.
- ssl_key # Paste your ssl key. *Required if you enable https
- ssl_crt # Paste your ssl crt. *Required if you enable https
- refresh_interval = 10s  # Interval to refresh traefik rules.toml from rancher-metadata.
- admin_readonly = false # Set REST API to read-only mode.
- admin_statistics = 10 # Enable more detailed statistics, extend recent errors number.
- admin_auth_method = "basic" # Selec auth method, basic or digest.
- admin_users = "" # Paste basic or digest users created with htdigest, one user per line.
- prometheus_enable = false # Enable prometheus statistics

### Service configuration labels:

Traefik labels has to be added in your services, in order to get included in traefik dynamic config.

- traefik.enable = <true | false>
  - true: the service will be published as *service_name.stack_name.traefik_domain*
  - stack: the service will be published as *stack_name.traefik_domain*. WARNING: You could have collisions inside services within your stack
  - false: the service will not be published
- traefik.alias = < alias >			# Alternate names to route rule. Multiple values separated by ",". WARNING: You could have collisions BE CAREFULL
- traefik.domain = < domain >		# Domain names to route rule. Multiple values separated by ","
- traefik.path = < path >		    # Path to route rule. Multiple paths separated by ","
- traefik.port = < port > 			# Port to expose throught traefik
- traefik.acme = < true | false >	# Enable/disable ACME traefik feature

### Usage:

 Select Traefik from catalog.

 Set the params.

 Click deploy.

 Services will be accessed throught hosts ip's whith $host_label:

 - http://${service_name}.${stack_name}.${traefik.domain}:${http_port}
 - https://${service_name}.${stack_name}.${traefik.domain}:${https_port}

 or

 - http://${stack_name}.${traefik.domain}:${http_port}
 - https://${stack_name}.${traefik.domain}:${https_port}

 If you set traefik.alias you service could also be acceses through

 - http://${traefik.alias}.${traefik.domain}:${http_port}
 - https://${traefik.alias}.${traefik.domain}:${https_port}

Note: To access the services, you need to create A or CNAMES dns entries for every one.
