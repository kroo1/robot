#!/usr/bin/env bash
set -e

CMD="robot --console verbose -i WebDemo --outputdir /reports /suites "


echo ${CMD}

``${CMD}``