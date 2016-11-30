# Integration specs

## Setup

Copy the `api_envs.yml.example` file into the root of this repository.

```
cp examples/api_envs.yml.example api_envs.yml
```

Then edit your new file with the relevant information for the envionment you wish to target.
You will need the following to be setup in the relevant account:

1. Your category should have at least 3 sub-categories.
2. Ensure your account has access to the following encoding presets: `2, 3, 4, 5, 6`
3. You need at least 2 ingest recipes.

## Running the examples

From the root of this repository:

```
# development
rake spec:api:dev

# prodcution
rake spec:api:prod
```

## Verifying the results

The `Video` examples will upload and process multiple videos. You should always check
that these videos actually encode as expected.
