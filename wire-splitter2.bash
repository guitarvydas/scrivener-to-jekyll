#!/bin/bash
read data </dev/fd/3
echo ${data} >/dev/fd/5
echo ${data} >/dev/fd/4
