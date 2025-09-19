#!/bin/bash
docker exec -it watchtower /watchtower --run-once --cleanup --label-enable
