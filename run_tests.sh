#!/usr/bin/env bash

docker run --rm \
           --network=robot \
           -v "$PWD/output":/output \
           -v "$PWD/suites":/suites \
           -v "$PWD/scripts":/scripts \
           -v "$PWD/reports":/reports \
           --security-opt seccomp:unconfined \
           --shm-size "256M" \
           --entrypoint=/scripts/run_suite.sh \
           robot5