# iperf3

## User Authentication with Password and RSA Public Keypair

### Compatibility Notice

The version after 3.17 has fixed a side-channel attack which
makes the authentication process incompatible with older versions.
For backwards-compatibility use the --use-pkcs1-padding flag.

### Setup

Prepare configuration directory at `/etc/iperf3`

Generate RSA Key pair

```bash
openssl genpkey -algorithm RSA -out /etc/iperf3/private_key.pem -pkeyopt rsa_keygen_bits:2048
openssl rsa -pubout -in /etc/iperf3/private_key.pem -out /etc/iperf3/public_key.pem
```

Prepare user/password pair at `/etc/iperf3/users.csv`
