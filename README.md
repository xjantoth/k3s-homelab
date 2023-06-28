# k3s-homelab

#### Ansible

```bash
ansible-playbook k3s-playbook.yml -i inventory/inventory.yml --tags grafana --vault-password-file=.ansible_password
```

#### gitlab.rb config
```bash
sudo grep -v "^#"  /etc/gitlab/gitlab.rb

prometheus['enable'] = false
alertmanager['enable'] = false
node_exporter['enable'] = false
postgres_exporter['listen_address'] = '192.168.0.241:9187'
redis_exporter['listen_address'] = '192.168.0.241:9121'
gitlab_exporter['listen_address'] = '192.168.0.241'
gitlab_exporter['listen_port'] = '9168'
sidekiq['listen_address'] = "192.168.0.241"
sidekiq['listen_port'] = 8082
registry_external_url 'https://registry.gitlab.local:5005'
gitlab_rails['registry_enabled'] = true
gitlab_rails['registry_host'] = "registry.gitlab.local"
gitlab_rails['registry_port'] = "5005"
gitlab_rails['manage_backup_path'] = false
letsencrypt['enable'] = false
nginx['ssl_certificate'] = "/etc/gitlab/ssl/gitlab.local.crt"
nginx['ssl_certificate_key'] = "/etc/gitlab/ssl/gitlab.local.key"
nginx['redirect_http_to_https'] = true
external_url 'https://gitlab.local'

```

#### Generate TLS self-signed certificate for local Gitlab

```bash
openssl genrsa -des3 -out CA.key 4096
openssl req -new -x509 -days 3650 -key CA.key -out CA.crt
openssl genrsa -out gitlab.local.key 2048
vim openssl.cnf

cat  openssl.cnf

[req]
default_md = sha256
prompt = no
req_extensions = req_ext
distinguished_name = req_distinguished_name
[req_distinguished_name]
commonName = *.gitlab.local
countryName = US
stateOrProvinceName = No state
localityName = City
organizationName = LTD
[req_ext]
keyUsage=critical,digitalSignature,keyEncipherment
extendedKeyUsage=critical,serverAuth,clientAuth
subjectAltName = @alt_names
[alt_names]
DNS.1=gitlab.local
DNS.2=*.gitlab.local


openssl req -new -nodes -key gitlab.local.key -config openssl.cnf -out gitlab.local.csr
openssl req -noout -text -in gitlab.local.csr
openssl x509 -req -in gitlab.local.csr -CA CA.crt -CAkey CA.key -CAcreateserial -out gitlab.local.crt -days 1024 -sha256 -extfile openssl.cnf -extensions req_ext

sudo cp gitlab.local.crt gitlab.local.key /etc/gitlab/ssl/
sudo vim /etc/gitlab/gitlab.rb
sudo cp gitlab.local.key  /etc/gitlab/ssl/registry.gitlab.local.key
sudo cp gitlab.local.crt  /etc/gitlab/ssl/registry.gitlab.local.crt
sudo gitlab-ctl reconfigure

sudo netstat  -tunlp | grep 443
openssl s_client -connect gitlab.local:443
openssl x509 -text -noout -in gitlab.local.crt
sudo cp gitlab.local.crt gitlab.local.key /etc/gitlab/ssl/
openssl x509 -text -noout -in gitlab.local.crt
openssl s_client -connect gitlab.local:443
sudo gitlab-ctl stop nginx
sudo gitlab-ctl start nginx
openssl s_client -connect gitlab.local:443



```

