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
