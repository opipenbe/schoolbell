#!/usr/bin/python

import subprocess
import re
import argparse
from croniter import croniter
from datetime import datetime

# Error codes:
#   1 - crontab program error
#   2 - error reading cron syntax

# Lets add some arguments...
parser = argparse.ArgumentParser()
parser.add_argument("-cmd", help="show cronjob time and corresponding command",
                    action="store_true")
parser.add_argument("-user", help="specify crontab user. Example: -user=root")
args = parser.parse_args()

# Functions


def get_cron_table():  # read current crontab output into variable
    try:
        if args.user:  # check -user option
            cmd = 'crontab -l -u %s' % args.user
            cron_table = subprocess.check_output(cmd, shell=True)
        else:
            cmd = 'crontab -l'
            cron_table = subprocess.check_output(cmd, shell=True)
    except subprocess.CalledProcessError:  # cron program error
        exit(1)
    return cron_table


def find_cron_jobs(cron_table):  # append cronjob lines from variable into list
    lines = []
    for line in cron_table.splitlines():
        line = line.lstrip()  # erase leading whitespaces
        if validate_cron_syntax(line) == True:
            lines.append(line)
    return lines


def validate_cron_syntax(crontab_line):  # validates correct crontab lines
    if not crontab_line.strip():  # skip empty lines
        return False
    if crontab_line.startswith("#"):  # skip comments
        return False
    if crontab_line.startswith("@"):  #  skip special strings, they are not supported yet: @reboot etc
        return False
    return True


def get_time(cron_format, base=datetime.now()):  # convert cron syntax into time
    try:
        iter = croniter(cron_format, base)
    except ValueError:
        print "Program experienced error with crontab syntax. Sorry :("
        exit(2)
    clock = iter.get_next(datetime)
    return clock


def syntax_to_time(cronjob_line_list, show_time_only=True, time_base=datetime.now()):  # create new list and replace cron syntax with times.
    converted_list = []
    for line in cronjob_line_list:  # converts cron syntax to time
        cron_syntax = re.match('^([\S]+[\s]{1,}){4}[\S]+', line).group(0)   # find cron syntax from line
        converted_time = str(get_time(cron_syntax, base=time_base))
        if show_time_only is False:
            line = converted_time
        else:
            line = line.replace(cron_syntax, converted_time)
        converted_list.append(line)
    return converted_list


def first_cron_job(list):  # finds first cron job from list
    jobs = sorted(list)  # sort list by time
    try:
        job = jobs[0]
    except IndexError:
        job = ""
    return job


if __name__ == "__main__":
    show_cmd = False
    if args.cmd:  # check "-cmd" option
        show_cmd = True
    cron_table = get_cron_table()  # get running crontab output into variable
    cron_jobs = find_cron_jobs(cron_table)  # store cronjobs into list
    converted_jobs = syntax_to_time(cron_jobs, show_time_only=show_cmd)  # convert cron syntax to time
    print first_cron_job(converted_jobs)  # output nearest cronjob
