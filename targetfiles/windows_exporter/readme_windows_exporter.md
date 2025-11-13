# Windows Exporter

## Intro
This serves as support for a relevant blog post at https://www.mythryll.com/ here: https://www.mythryll.com/?p=3648.
It's a series of blog posts, with part 1 here: https://www.mythryll.com/?p=3329.

## Versions

You have to choose your windows exporter version carefully depending on the Windows Server Edition you are installing onto. 
Currently (November 2025):

- for Windows Server 2016 - Server 2019 version 0.30.9 install and works fine, later versions hang at startup.
- for Windows Server 2022 - version 0.30.9 install and works fine, more tests will be run soon to check newer versions.

## Installation Instructions

I have used the msi installers extensively. I advise using Powershell in Administrator Mode and running the following line:

msiexec /i <soruce path and filec> ENABLED_COLLECTORS=[defaults],cpu_info,cs,logon,memory,process,time,vmware --% EXTRA_FLAGS="--web.config.file=""C:\Program Files\windows_exporter\web-config.yaml"""

## Prerequisites

Create a directory under Program Files called 'windows_exporter' and another one called 'textfile_inputs' if you plan to use the textfile collector.
Copy the config.yaml and web-config.yaml files in there and make sure you also put the server certificates in there and rename them accordingly.
Remember that if you have an enterprise CA that has signed the certificate, you will need that CA's chain certificate in your prometheus server to verify the target certificate when accessing the exporter page.

## Configuration - Prepare the password
The password contained in the web-config.yaml is a hash and is produced from the original password either through online coverters or using your own script.
Check the instructions here for a complete explanation and choice of methods: https://prometheus.io/docs/guides/basic-auth/
Remember, hashed password goes in the web-config file at the target, clear text password goes in the Prometheus config (but is hidden if the config is viewer from the Prometheus server web site).
Web configuration is common for the exporters and is mentioned here: https://github.com/prometheus/exporter-toolkit/blob/master/docs/web-configuration.md