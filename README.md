# Parse on AutoPilot

Implementation of [Parse](http://parse.com/) using the [AutoPilot pattern](https://www.joyent.com/blog/app-centric-micro-orchestration).

Assuming you have a Docker environment, you can just do:

    make build runlocal

You should then have the Parse API server running at: http://localhost:1337/parse

And the Parse Dashboard running at:  http://localhost:8080

To deploy on Joyent Triton, make sure that your TRITON_ACCOUNT and TRITON_DC environment vars are set and that your Docker daemon is pointed to Triton, then you can just do a normal:

    docker-compose up

Your services will be available at your normal CNS addresses (as "parse" and "dashboard").

Before deploying anything publicly or to production you will want to update the APPLICATION_ID and MASTER_KEY values in .env, as well as enable (and require) SSL for both the Parse API server and Parse Dashboard.

TODO:

- [ ] Add Promethius telemetry to appropriate containers
- [ ] Add Nginx to support reverse proxy TLS/SSL for Parse Server and Dashboard 
- [ ] Add Parse Dashboard health check
- [ ] Add Redis and configure Parse "Cache Adapter" to use same (no need for persistence)
- [ ] Back up MongoDB to Manta (persistence)
- [ ] Implement Parse "File Adapter" for Manta (so user files will be stored there instead of MongoDB)
- [ ] Consider jumping on: https://github.com/ParsePlatform/parse-dashboard/issues/81 so that you can create/edit Cloud Code via the Parse Dashboard
