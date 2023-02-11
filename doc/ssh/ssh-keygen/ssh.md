# Generate ssh key

Step 1:

Paste the text below to generate a new SSH key on your local machine.

```shell
ssh-keygen -t ed25519 -C "comment text"
```

If you are using a legacy system that doesn't support the Ed25519 algorithm, use:

```shell
ssh-keygen -t rsa -b 4096 -C "comment text"
```

---

Step 2:

Adding the SSH public key to your GitHub account.

Note: Private key file "~/.ssh/id_rsa" permissions must be 700.

---
