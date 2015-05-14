Bitbucket Browser
=================

This simple application allows you to quickly browse the repositories,
members, and groups - and their relationships - for a Bitbucket team
account. This fills in gaps in the existing Bitbucket interface that
make it difficult to discover some of these relationships, for
example, listing all of the repositories a specific member has
explicit permissions for.

At the moment all data must be retrieved from Bitbucket offline using
included rake tasks. In addition, all Bitbucket data is currently
reloaded from scratch on every update, since there is no easy way to
query Bitbucket for account changes.
