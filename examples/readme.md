To run the tests you need to setup 2 testing accounts on vzaar app and upload testing video to your first account.
Then generate RW and RO tokens for each account.

After that copy examples/api_envs.yml.example to the main gem's directory (as a api_envs.yml) and fill config with the data from your accounts.


rake spec:api:dev will run all api specs