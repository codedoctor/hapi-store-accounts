[![Build Status](https://travis-ci.org/codedoctor/hapi-store-accounts.svg?branch=master)](https://travis-ci.org/codedoctor/hapi-store-accounts)
[![Coverage Status](https://img.shields.io/coveralls/codedoctor/hapi-store-accounts.svg)](https://coveralls.io/r/codedoctor/hapi-store-accounts)
[![NPM Version](http://img.shields.io/npm/v/hapi-store-accounts.svg)](https://www.npmjs.org/package/hapi-store-accounts)
[![Dependency Status](https://gemnasium.com/codedoctor/hapi-store-accounts.svg)](https://gemnasium.com/codedoctor/hapi-store-accounts)
[![NPM Downloads](http://img.shields.io/npm/dm/hapi-store-accounts.svg)](https://www.npmjs.org/package/hapi-store-accounts)
[![Issues](http://img.shields.io/github/issues/codedoctor/hapi-store-accounts.svg)](https://github.com/codedoctor/hapi-store-accounts/issues)
[![HAPI 6.0](http://img.shields.io/badge/hapi-6.0-blue.svg)](http://hapijs.com)
[![API Documentation](http://img.shields.io/badge/API-Documentation-ff69b4.svg)](http://coffeedoc.info/github/codedoctor/hapi-store-accounts)

(C) 2014 Martin Wawrusch

# Provides a backend data store to manage accounts associated with users.

The purpose of this module is to provide account management functionality similar to
those found in SAAS sites like new relic. Core assumptions is that a user can have access
to multiple accounts, and that Stripe is used for billing (note: We might factor out the whole stripe billing part into it's own billing module).


## See also

* [hapi-auth-bearer-mw](https://github.com/codedoctor/hapi-auth-bearer-mw)
* [hapi-loggly](https://github.com/codedoctor/hapi-loggly)
* [hapi-mandrill](https://github.com/codedoctor/hapi-mandrill)
* [hapi-mongoose-db-connector](https://github.com/codedoctor/hapi-mongoose-db-connector)
* [hapi-store-accounts](https://github.com/codedoctor/hapi-store-accounts)
* [hapi-routes-authorization-and-session-management](https://github.com/codedoctor/hapi-routes-authorization-and-session-management)
* [hapi-routes-oauth-management](https://github.com/codedoctor/hapi-routes-oauth-management)
* [hapi-routes-roles](https://github.com/codedoctor/hapi-routes-roles)
* [hapi-routes-status](https://github.com/codedoctor/hapi-routes-status)
* [hapi-routes-users-authorizations](https://github.com/codedoctor/hapi-routes-users-authorizations)
* [hapi-routes-users](https://github.com/codedoctor/hapi-routes-users)
* [hapi-user-store-multi-tenant](https://github.com/codedoctor/hapi-user-store-multi-tenant)

and additionally

* [api-pagination](https://github.com/codedoctor/api-pagination)
* [mongoose-oauth-store-multi-tenant](https://github.com/codedoctor/mongoose-oauth-store-multi-tenant)
* [mongoose-rest-helper](https://github.com/codedoctor/mongoose-rest-helper)
* [mongoose-user-store-multi-tenant](https://github.com/codedoctor/mongoose-user-store-multi-tenant)


## Contributing
 
* Check out the latest master to make sure the feature hasn't been implemented or the bug hasn't been fixed yet
* Check out the issue tracker to make sure someone already hasn't requested it and/or contributed it
* Fork the project
* Start a feature/bugfix branch
* Commit and push until you are happy with your contribution
* Make sure to add tests for it. This is important so I don't break it in a future version unintentionally.
* Please try not to mess with the package.json, version, or history. If you want to have your own version, or is otherwise necessary, that is fine, but please isolate to its own commit so I can cherry-pick around it.

## Copyright

Copyright (c) 2014 Martin Wawrusch 
