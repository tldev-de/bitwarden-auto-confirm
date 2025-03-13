# bitwarden-auto-confirm

This docker image is used to confirm the Vaultwarden / Bitwarden Organization invitation automatically using
the [Bitwarden CLI](https://bitwarden.com/help/cli/).

## How to use?

> [!WARNING]  
> This given user has full access to the organization in vaultwarden - including all credentials and user management.
> Use a separate account for this. Run this image only in a trusted environment!

You need a Bitwarden / Vaultwarden account, which is member of at least one organization. The account has to be
`Administrator` or`Owner` role in your organization. Use these credentials (client_id, client_secret, master password)
and the given docker-compose to start the container.

Using vaultwarden, you get your credentials at https://vaultwarden.example.com/#/settings/security/security-keys.
Information on how to get the credentials using bitwarden can be
found [here](https://bitwarden.com/help/personal-api-key/).

## environment variables

| Variable             | Description                                                                             | Default Value              |
|----------------------|-----------------------------------------------------------------------------------------|----------------------------|
| `BW_CLIENT_ID`       | **[Mandatory]** The client id of your vaultwarden / bitwarden account                   |                            |
| `BW_CLIENT_SECRET`   | **[Mandatory]** The client secret of your vaultwarden / bitwarden account               |                            |
| `BW_MASTER_PASSWORD` | **[Mandatory]** The master password of your vaultwarden / bitwarden account             |                            |
| `BW_SERVER`          | The URL to your bitwarden / vaultwarden instance, e.g. https://vaultwarden.example.com/ | https://vault.bitwarden.eu |
| `SYNC_INTERVAL`      | The interval in seconds to check for new invitations.                                   | 3600                       |